//
//  WaitingRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

protocol WaitingRoomDelegate {
    func didUpdatePlayers()
    func didStartGame(roomResponse: CreateRoomResponse)
}

class WaitingRoomViewModel {
    
    // MARK: - PUBLIC PROPERTIES
        
    var delegate: WaitingRoomDelegate?
    var socketManager: GameSocketManager?
    
    var playersText: String {
        return players.enumerated()
            .map { (index, player) in return "\(index + 1). \(player)" }
            .joined(separator: "\n\n")
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private(set) var roomId: String
    private var players: [String] {
        didSet { delegate?.didUpdatePlayers() }
    }
    
    // MARK: - INITIALIZER
    
    init(_ response: JoinRoomResponse, socketManager: GameSocketManager?){
        self.roomId = response.id
        self.players = response.players
        
        self.socketManager = socketManager
        self.socketManager?.delegate = self
    }
    
    // MARK: - PUBLIC METHODS
    
    func startGame() {
        socketManager?.requestStart { [weak self] tracks in
            guard let self = self, let tracks = tracks else { return }
            let roomResponse = CreateRoomResponse(id: self.roomId, tracks: tracks,
                                                  started: true, genres: [])
            self.delegate?.didStartGame(roomResponse: roomResponse)
        }
    }
}

// MARK: - GameSocketManagerDelegate

extension WaitingRoomViewModel: GameSocketManagerDelegate {

    func didReceive(event: SocketEvents, data: Any?) {
        
        if event == .roomUpdate, let players = data as? [String] {
            self.players = players
            
        } else if event == .propagateStart {
            guard let tracksString = data as? String,
                  let data = tracksString.data(using: .utf8),
                  let tracks = try? JSONDecoder().decode([Track].self, from: data) else { return }
                    
            let roomResponse = CreateRoomResponse(id: roomId, tracks: tracks,
                                                  started: true, genres: [])
            delegate?.didStartGame(roomResponse: roomResponse)
            
        }
    }
}
