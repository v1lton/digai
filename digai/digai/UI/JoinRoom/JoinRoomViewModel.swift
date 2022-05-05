//
//  JoinRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import Foundation
import SDWebImage

class JoinRoomViewModel {
    
    var delegate: JoinRoomDelegate?
    var socketManager: GameSocketManager?
    private var room: CreateRoomResponse?
    private let api = DigaiAPI()
    
    init(){
        self.socketManager = GameSocketManager(delegate: self)
    }
    
    public func createRoom(playerName: String?){
        guard let playerName = validate(input: playerName, errorTitle: "nome inválido",
                                        errorMessage: "o campo de nome é obrigatório") else { return }
        
        socketManager?.createRoom(player: playerName) { [weak self] roomName in
            guard let roomName = roomName else {
                self?.delegate?.showError(title: "erro ao criar sala",
                                         message: "não conseguimos criar a sala, tente novamente")
                return
            }
            self?.delegate?.didCreateRoom(roomName)
        }
        
    }
    
    public func joinRoom(id: String?, playerName: String?){
        guard let playerName = validate(input: playerName, errorTitle: "nome inválido",
                                        errorMessage: "o campo de nome é obrigatório") else { return }
        guard let roomCode = validate(input: id, errorTitle: "código da sala inválido",
                                      errorMessage: "o campo de código da sala é obrigatório") else { return }
        
        socketManager?.joinRoom(player: playerName, roomName: roomCode) { [weak self] roomName in
            guard let roomName = roomName else {
                self?.delegate?.showError(title: "erro ao entrar na sala",
                                          message: "código da sala incorreto, tente novamente")
                return
            }
            self?.delegate?.didJoinRoom(roomName)
        }
    }
    
    public func getRoom() -> CreateRoomResponse {
        
        return self.room ?? CreateRoomResponse(id: "", tracks: [], started: false, genres: [])
    }
    
    private func validate(input: String?, errorTitle: String, errorMessage: String) -> String? {
        guard let input = input?.trimmingCharacters(in: .whitespacesAndNewlines), !input.isEmpty else {
            delegate?.showError(title: errorTitle, message: errorMessage)
            return nil
        }
        
        return input
    }
}

protocol JoinRoomDelegate {
    func didCreateRoom(_ roomName: String)
    func didJoinRoom(_ roomName: String)
    func showError(title: String, message: String)
    func didStopGame()
}

extension JoinRoomViewModel: GameSocketManagerDelegate {
    func didConnect() {
        debugPrint("did connect with socket")
    }
    
    func didReceive(message: String) {
        if message == "stop requested" {
            print("stop")
            self.delegate?.didStopGame()
            
        }
    }
}
