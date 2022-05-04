//
//  UpdateRoomRequest.swift
//  digai
//
//  Created by Wilton Ramos on 02/05/22.
//

public struct UpdateRoomRequest: Codable {
    var roomId: String
    var room: Room
    
    init(roomId: String,
         room: Room) {
        self.roomId = roomId
        self.room = room
    }
}

extension UpdateRoomRequest {
    struct Room: Codable {
        var started: Bool
        var steps: Int
        var genres: [String]
        var finished: Bool
    }
}
