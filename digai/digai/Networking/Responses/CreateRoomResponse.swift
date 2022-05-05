//
//  CreateRoomResponse.swift
//  digai
//
//  Created by Wilton Ramos on 01/05/22.
//

public struct CreateRoomResponse: Codable {
    let id: String
    let tracks: [Track]
    let started: Bool
    let genres: [String]
    
    init(id: String,
         tracks: [Track],
         started: Bool,
         genres: [String]) {
        self.id = id
        self.tracks = tracks
        self.started = started
        self.genres = genres
    }
}

