//
//  WaitingRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import SDWebImage

class WaitingRoomViewModel {
    
    var delegate: WaitingRoomDelegate?
    public var socketManager: GameSocketManager?
    private var roomName: String
    
    init(roomName: String, socketManager: GameSocketManager?){
        //self.digaiResponse = room
        self.socketManager = socketManager
        self.roomName = roomName
        self.socketManager = socketManager
        self.socketManager?.delegate = self
    }
    
    public func getRoomId() -> String {
        return roomName
    }
    
    public func startGame() {
        socketManager?.requestStart { [weak self] tracks in
            guard let self = self, let tracks = tracks else { return }
            let roomResponse = CreateRoomResponse(id: self.roomName, tracks: tracks,
                                                  started: true, genres: [])
            self.delegate?.didStartGame(roomResponse: roomResponse)
        }
    }
}

protocol WaitingRoomDelegate {
    func didStartGame(roomResponse: CreateRoomResponse)
}

extension WaitingRoomViewModel: GameSocketManagerDelegate {    
    func didReceive(message: String, data: Any?) {
        if message == "propagate-start", let tracks = data as? [Track] {
            let roomResponse = CreateRoomResponse(id: roomName, tracks: tracks,
                                                  started: true, genres: [])
            delegate?.didStartGame(roomResponse: roomResponse)
        }
    }
}
