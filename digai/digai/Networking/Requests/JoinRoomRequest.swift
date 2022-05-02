//
//  JoinRoomRequest.swift
//  digai
//
//  Created by Wilton Ramos on 02/05/22.
//

public struct JoinRoomRequest: Codable {
    var roomID: String
    var user: User
    
    init(roomId: String,
         user: User) {
        self.roomID = roomId
        self.user = user
    }
}

extension JoinRoomRequest {
    struct User: Codable {
        var name: String
        var crowns: Int?
    }
}
