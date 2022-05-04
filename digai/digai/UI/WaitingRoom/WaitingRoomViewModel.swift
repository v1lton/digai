//
//  WaitingRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import SDWebImage

class WaitingRoomViewModel {
    private var digaiResponse: CreateRoomResponse
    
    init(room: CreateRoomResponse){
        self.digaiResponse = room
    }
    
    public func getRoom() -> CreateRoomResponse {
        
        return self.digaiResponse ?? CreateRoomResponse(id: "", players: [], tracks: [], started: false, steps: 0, genres: [])
    }
    
    public func getRoomId() -> String {
        
        return self.digaiResponse.id
    }
}
