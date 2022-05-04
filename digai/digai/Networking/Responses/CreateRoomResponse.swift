//
//  CreateRoomResponse.swift
//  digai
//
//  Created by Wilton Ramos on 01/05/22.
//

public struct CreateRoomResponse: Codable {
    let id: String
    let players: [String]
    let tracks: [Track]
    let started: Bool
    let steps: Int
    let genres: [String]
    
    init(id: String,
         players: [String],
         tracks: [Track],
         started: Bool,
         steps: Int,
         genres: [String]) {
        self.id = id
        self.players = players
        self.tracks = tracks
        self.started = started
        self.steps = steps
        self.genres = genres
    }
}

