//
//  AudioTrack.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import Foundation

struct AudioTrack: Codable {
    let id: String
    let name: String
    let album: Album?
    let previewUrl: String?
}
