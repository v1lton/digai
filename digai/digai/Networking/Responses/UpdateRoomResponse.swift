//
//  UpdateRoomResponse.swift
//  digai
//
//  Created by Wilton Ramos on 02/05/22.
//

public struct UpdateRoomResponse: Codable {
    let id: String
    let players: [String]
    let tracks: [AudioTrack]
    let started: Bool
    let steps: Int
    let genres: [String]
}

extension UpdateRoomResponse {
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

