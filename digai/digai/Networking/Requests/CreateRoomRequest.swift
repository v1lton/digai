//
//  CreateRoom.swift
//  digai
//
//  Created by Wilton Ramos on 01/05/22.
//

public struct CreateRoomRequest: Codable {
    var steps: Int
    var owner: Owner
    var genres: [String]?
    
    init(steps: Int,
         owner: Owner,
         genres: [String]? = nil) {
        self.steps = steps
        self.owner = owner
        self.genres = genres
    }
}

extension CreateRoomRequest {
    struct Owner: Codable {
        var name: String
        var crowns: Int?
    }
}
