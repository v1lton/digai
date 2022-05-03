//
//  FetchRoomResponse.swift
//  digai
//
//  Created by Wilton Ramos on 02/05/22.
//

public struct FetchRoomsResponse: Codable {
    let id: String
    let players: [String]
    let tracks: [Track]
    let started: Bool
    let steps: Int
    let genres: [String]
}
