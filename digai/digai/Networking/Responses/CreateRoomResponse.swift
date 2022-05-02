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

extension CreateRoomResponse {
    struct Track: Codable {
        let name: String
        let artist: String
        let album: String
        let albumArt: String
        let preview: String
        let uri: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case artist
            case album
            case albumArt = "album_art"
            case preview = "preview_url"
            case uri
        }
    }
}