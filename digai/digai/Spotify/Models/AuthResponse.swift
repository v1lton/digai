//
//  AuthResponse.swift
//  digai
//
//  Created by Jacqueline Alves on 03/04/22.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
}
