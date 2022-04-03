//
//  Album.swift
//  digai
//
//  Created by Jacqueline Alves on 03/04/22.
//

import Foundation

struct Album: Codable {
    let id: String
    let name: String
    let images: [Image]
}
