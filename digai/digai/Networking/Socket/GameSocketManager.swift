//
//  GameSocketManager.swift
//  digai
//
//  Created by Faculdade on 02/05/22.
//

import Foundation
import SocketIO

protocol GameSocketManagerDelegate: AnyObject {
    func didConnect()
    func didReceive(message: String, data: Any?)
}

extension GameSocketManagerDelegate {
    func didConnect() {}
    func didReceive(message: String, data: Any?) {}
}

class GameSocketManager {
    
    enum SocketError: Error {
        case `default`
    }
    
    private let manager = SocketManager(socketURL: URL(string: "http://localhost:3000/")!,
                                        config: [.log(false), .compress])
    
    weak var delegate: GameSocketManagerDelegate?
    lazy var socket: SocketIOClient = manager.defaultSocket
    
    init(delegate: GameSocketManagerDelegate) {
        self.delegate = delegate
        
        setupSocketEventes()
        socket.connect()
    }
    
    private func stop() {
        socket.removeAllHandlers()
    }
    
    private func setupSocketEventes() {
        socket.on(clientEvent: .connect) { [weak self] _, _ in
            self?.delegate?.didConnect()
        }
        
        /*socket.on("stop-requested") { [weak self] _, _ in
            self?.delegate?.didReceive(message: "stop requested")
        }*/
        
        socket.on("propagate-start") { [weak self] data, _ in
            var tracks: [Track]?
            if let tracksString = data.first as? String, let data = tracksString.data(using: .utf8) {
                tracks = try? JSONDecoder().decode([Track].self, from: data)
            }
            
            self?.delegate?.didReceive(message: "propagate-start", data: tracks)
        }
    }
    
    func createRoom(player: String, completion: @escaping (String?) -> Void) {
        let roomName = String(UUID().uuidString.prefix(4)).lowercased()
        
        socket.emitWithAck("create-room", roomName, player, 5).timingOut(after: 2) { info in
            if let room = info.first as? String, room == roomName {
                completion(room)
            } else {
                completion(nil)
            }
        }
    }

    
    func joinRoom(player: String, roomName: String, completion: @escaping (String?) -> Void) {
        let roomName = roomName.lowercased()
        
        socket.emitWithAck("join-room", roomName, player).timingOut(after: 2) { info in
            if let room = info.first as? String, room == roomName {
                completion(room)
            } else {
                completion(nil)
            }
        }
    }
    
    func requestStart(completion: @escaping ([Track]?) -> Void) {
        socket.emitWithAck("start").timingOut(after: 2) { info in
            if let tracksString = info.first as? String, let data = tracksString.data(using: .utf8) {
                completion(try? JSONDecoder().decode([Track].self, from: data))
            } else {
                completion(nil)
            }
        }
    }
    
    func requestStop(player: String) {
        socket.emit("stop", ["player_name": player])
    }
}

