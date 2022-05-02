//
//  ExitRoomRequest.swift
//  digai
//
//  Created by Wilton Ramos on 02/05/22.
//

public struct ExitRoomRequest: Codable {
    var roomId: String
    var user: String
    
    init(roomId: String,
         user: String) {
        self.roomId = roomId
        self.user = user
    }
}
