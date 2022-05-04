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
    private var room: CreateRoomResponse?
    private let api = DigaiAPI()
    
    init(){
        
    }
    
    public func createRoom(){
        let createRoomRequest = CreateRoomRequest(steps: 5,
                                                  owner: .init(name: "kk",
                                                               crowns: 0),
                                                  genres: ["funk"])
        api.createRoom(for: createRoomRequest) { [weak self] createRoom in
            guard let self = self else { return }
            self.room = createRoom
            print(self.room)
            self.delegate?.didCreateRoom()
            
        }
        
    }
    
    public func joinRoom(id: String, name: String){
        /*
        let joinRoomRequest =  JoinRoomRequest(roomId: id, user: JoinRoomRequest.User(name: name))
        print(joinRoomRequest)
        api.joinRoom(for: joinRoomRequest) { [weak self] joinRoom in
            guard let self = self else { return }
            
            self.room = joinRoom
            print(self.room?.players)
            self.delegate?.didCreateRoom()
            
        }*/
    }
    
    public func getRoom() -> CreateRoomResponse {
        
        return self.room ?? CreateRoomResponse(id: "", players: [], tracks: [], started: false, steps: 0, genres: [])
    }
    
    
}

protocol JoinRoomDelegate {
    func didCreateRoom()
}
