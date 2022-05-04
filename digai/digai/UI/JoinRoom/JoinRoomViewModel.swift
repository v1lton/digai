//
//  JoinRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import Foundation
import SDWebImage

class JoinRoomViewModel {
    
    private var room: CreateRoomResponse?
    private let api = DigaiAPI()
    
    init(){
        //createRoom()
    }
    
    public func createRoom() {
        let createRoomRequest = CreateRoomRequest(steps: 5,
                                                  owner: .init(name: "kk",
                                                               crowns: 0),
                                                  genres: ["funk"])
        api.createRoom(for: createRoomRequest) { [weak self] createRoom in
            guard let self = self else { return }
            self.room = createRoom
            print(self.room)
            
        }
    }
    
    public func getRoom() -> CreateRoomResponse {
        
        return self.room ?? CreateRoomResponse(id: "", players: [], tracks: [], started: false, steps: 0, genres: [])
    }
    
    public func getTracks() -> [Track] {
        return room?.tracks ?? []
    }
    
    public func getRoomId() -> String {
        return room?.id ?? ""
    }
    
}
