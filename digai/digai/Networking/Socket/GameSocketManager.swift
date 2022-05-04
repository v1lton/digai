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
    func didReceive(message: String)
}

class GameSocketManager {
    
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
    }
    
    func joinRoom(player: String, roomName: String){
        let info: [String : Any] = [
                    "roomValue": player,
                    "userValue": roomName
                ]
        socket.emit("join-room", info) {
            
        }
    
    }
    
    func requestStop(player: String) {
        socket.emit("stop", ["player_name": player])
    }
}

