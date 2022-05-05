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
    private var players: [String] {
        didSet { delegate?.didUpdatePlayers() }
    }
    
    init(_ response: JoinRoomResponse, socketManager: GameSocketManager?){
        self.roomName = response.id
        self.players = response.players
        self.socketManager = socketManager
        self.socketManager?.delegate = self
    }
    
    public func getRoomId() -> String {
        return roomName
    }
    
    func getPlayersText() -> String {
        return players.enumerated()
            .map { (index, player) in return "\(index + 1). \(player)" }
            .joined(separator: "\n\n")
    }
    
    func startGame() {
        socketManager?.requestStart { [weak self] tracks in
            guard let self = self, let tracks = tracks else { return }
            let roomResponse = CreateRoomResponse(id: self.roomName, tracks: tracks,
                                                  started: true, genres: [])
            self.delegate?.didStartGame(roomResponse: roomResponse)
        }
    }
}

protocol WaitingRoomDelegate {
    func didUpdatePlayers()
    func didStartGame(roomResponse: CreateRoomResponse)
    func didStopGame()
}

extension WaitingRoomViewModel: GameSocketManagerDelegate {    
    func didReceive(message: String, data: Any?) {
        if message == "room-update", let players = data as? [String] {
            self.players = players
            
        } else if message == "propagate-start", let tracks = data as? [Track] {
            let roomResponse = CreateRoomResponse(id: roomName, tracks: tracks,
                                                  started: true, genres: [])
            delegate?.didStartGame(roomResponse: roomResponse)
            
        } else if message == "stop requested" {
            Player.shared.pause()
            self.delegate?.didStopGame()
            
        }
    }
}
