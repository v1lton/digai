//
//  JoinRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

protocol JoinRoomDelegate {
    func didCreateRoom(_ joinRoomResponse: JoinRoomResponse)
    func didJoinRoom(_ joinRoomResponse: JoinRoomResponse)
    func showError(title: String, message: String)
}

class JoinRoomViewModel {
    
    // MARK: - PUBLIC PROPERTIES
    
    var delegate: JoinRoomDelegate?
    var socketManager: GameSocketManager?
    
    // MARK: - PRIVATE PROPERTIES
    
    private let stepsCount = 5
    
    // MARK: - INITIALIZER
    
    init(){
        self.socketManager = GameSocketManager()
    }
    
    // MARK: - PUBLIC METHODS
    
    func createRoom(playerName: String?){
        guard let playerName = validate(input: playerName, errorTitle: "nome inválido",
                                        errorMessage: "o campo de nome é obrigatório") else { return }
        
        socketManager?.createRoom(player: playerName, steps: stepsCount) { [weak self] roomId in
            guard let roomId = roomId else {
                self?.delegate?.showError(title: "erro ao criar sala",
                                          message: "não conseguimos criar a sala, tente novamente")
                return
            }
            
            let joinResponse = JoinRoomResponse(id: roomId, players: [playerName],
                                                tracks: [], started: false,
                                                steps: self?.stepsCount ?? 0 , genres: [])
            self?.delegate?.didCreateRoom(joinResponse)
        }
    }
    
    func joinRoom(id: String?, playerName: String?){
        guard let playerName = validate(input: playerName, errorTitle: "nome inválido",
                                        errorMessage: "o campo de nome é obrigatório") else { return }
        guard let roomId = validate(input: id, errorTitle: "código da sala inválido",
                                    errorMessage: "o campo de código da sala é obrigatório") else { return }
        
        socketManager?.joinRoom(player: playerName, roomId: roomId) { [weak self] players in
            guard let players = players else {
                self?.delegate?.showError(title: "erro ao entrar na sala",
                                          message: "código da sala incorreto, tente novamente")
                return
            }
            
            let joinResponse = JoinRoomResponse(id: roomId.lowercased(), players: players,
                                                tracks: [], started: false, steps: 5, genres: [])
            self?.delegate?.didJoinRoom(joinResponse)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func validate(input: String?, errorTitle: String, errorMessage: String) -> String? {
        guard let input = input?.trimmingCharacters(in: .whitespacesAndNewlines), !input.isEmpty else {
            delegate?.showError(title: errorTitle, message: errorMessage)
            return nil
        }
        
        return input
    }
}
