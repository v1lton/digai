//
//  AuthManager.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import Foundation
import UIKit

final class SpotifyManager {
    
    static let shared = SpotifyManager()
    
    private let api = SpotifyAPI()
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationData: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationData = tokenExpirationData else { return false }
        
        let currentDate = Date()
        return currentDate.addingTimeInterval(TimeInterval(300)) >= expirationData
    }
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    var signInURL: URL? {
        let scopes = ["streaming"]
        let scopeAsString = scopes.joined(separator: " ")
        var components = URLComponents(string: "https://accounts.spotify.com/authorize")
        
        components?.queryItems = [URLQueryItem(name: "response_type", value: "code"),
                                  URLQueryItem(name: "client_id", value: spotifyClientID),
                                  URLQueryItem(name: "scope", value: scopeAsString),
                                  URLQueryItem(name: "show_dialog", value: "TRUE"),
                                  URLQueryItem(name: "redirect_uri", value: spotifyRedirectURL)]
        return components?.url
    }
    
    private init() {}
    
    func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        api.getAccessToken(from: code) { [weak self] response in
            guard let response = response else { completion(false); return }
            self?.cacheToken(result: response)
            completion(true)
        }
    }
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard shouldRefreshToken else { completion(true); return }
        guard let refreshToken = refreshToken else { return }
        
        api.refreshAccessToken(refreshToken) { [weak self] response in
            guard let response = response else { completion(false); return }
            self?.cacheToken(result: response)
            completion(true)
        }
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.set(result.accessToken, forKey: "access_token")
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expirationDate")
        
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.set(refreshToken, forKey: "refresh_token")
        }
    }
}
