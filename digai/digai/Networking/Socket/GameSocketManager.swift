//
//  GameSocketManager.swift
//  digai
//
//  Created by Faculdade on 02/05/22.
//

import SocketIO

protocol GameSocketManagerDelegate: AnyObject {
    func didConnect()
    func didReceive(event: SocketEvents, data: Any?)
}

extension GameSocketManagerDelegate {
    func didConnect() {}
    func didReceive(event: SocketEvents, data: Any?) {}
}

protocol SocketEvent {
    var rawValue: String { get }
}

class GameSocketManager {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let url: URL
    private lazy var manager = SocketManager(socketURL: url, config: [.log(false), .compress])
    private lazy var socket: SocketIOClient = manager.defaultSocket
    
    // MARK: - PUBLIC PROPERTIES
    
    weak var delegate: GameSocketManagerDelegate?
    
    // MARK: - INITIALIZERS
    
    init(delegate: GameSocketManagerDelegate? = nil) {
        self.url = URL(string: "https://1af2-45-70-74-57.sa.ngrok.io")!
        self.delegate = delegate
        
        setupSocketEventListeners()
        socket.connect()
    }
    
    deinit {
        socket.removeAllHandlers()
    }
    
    // MARK: - PUBLIC METHODS
    
    func createRoom(player: String, steps: Int, completion: @escaping (String?) -> Void) {
        let roomId = String(UUID().uuidString.prefix(4)).lowercased()
        let event = SocketEvents.createRoom.rawValue
        
        socket.emitWithAck(event, roomId, player, steps).timingOut(after: 2) { info in
            guard let room = info.first as? String, room == roomId else {
                completion(nil)
                return
            }
            completion(info.first as? String)
        }
    }

    func joinRoom(player: String, roomId: String, completion: @escaping ([String]?) -> Void) {
        let roomId = roomId.lowercased()
        let event = SocketEvents.joinRoom.rawValue
        
        socket.emitWithAck(event, roomId, player).timingOut(after: 2) { info in
            completion(info.first as? [String])
        }
    }
    
    func requestStop(completion: @escaping () -> Void) {
        let event = SocketEvents.stop.rawValue
        socket.emitWithAck(event).timingOut(after: 2) { _ in
            completion()
        }
    }
    
    func trackAssert(guesses: [String?], completion: @escaping () -> Void) {
        let event = SocketEvents.trackAssert.rawValue
        socket.emitWithAck(event, guesses).timingOut(after: 2) { _ in
            completion()
        }
    }
    
    func requestStart(completion: @escaping ([Track]?) -> Void) {
        let event = SocketEvents.start.rawValue
        
        socket.emitWithAck(event).timingOut(after: 2) { info in
            if let tracksString = info.first as? String, let data = tracksString.data(using: .utf8) {
                completion(try? JSONDecoder().decode([Track].self, from: data))
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func listen(_ event: SocketEvent, completion: ((Any?) -> Void)? = nil) {
        socket.on(event.rawValue) { [weak self] data, ack in
            DispatchQueue.main.async {
                completion?(data.first)
            }

            let receivedEvent = SocketEvents(rawValue: event.rawValue) ?? .unknown
            self?.delegate?.didReceive(event: receivedEvent, data: data.first)
        }
    }
    
    private func setupSocketEventListeners() {
        socket.on(clientEvent: .connect) { [weak self] _, _ in
            self?.delegate?.didConnect()
        }
        
        listen(SocketEvents.roomUpdate)
        listen(SocketEvents.propagateStart)
        listen(SocketEvents.propagateStop)
        listen(SocketEvents.resume)
    }
}
