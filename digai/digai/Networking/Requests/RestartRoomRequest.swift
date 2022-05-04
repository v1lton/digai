//
//  RestartRoomRequest.swift
//  digai
//
//  Created by Wilton Ramos on 02/05/22.
//

public struct RestartRoomRequest: Codable {
    var roomId: String
    
    init(roomId: String) {
        self.roomId = roomId
    }
}
