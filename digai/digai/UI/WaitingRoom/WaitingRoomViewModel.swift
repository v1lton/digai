//
//  WaitingRoomViewModel.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import SDWebImage

class WaitingRoomViewModel {
    //private var digaiResponse: CreateRoomResponse
    private var roomName: String
    public var socketManager: GameSocketManager
    
    init(roomName: String, socket: GameSocketManager){
        //self.digaiResponse = room
        self.socketManager = socket
        self.roomName = roomName
    }
    
    public func getRoom() -> CreateRoomResponse {
        
        /*return self.digaiResponse ?? CreateRoomResponse(id: "", players: [], tracks: [], started: false, steps: 0, genres: [])*/
        return CreateRoomResponse(id: "", players: [], tracks: [], started: false, steps: 0, genres: [])
    }
    
    public func getRoomId() -> String {
        
        //return self.digaiResponse.id
        return roomName
    }
}
