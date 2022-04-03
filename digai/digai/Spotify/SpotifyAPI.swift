//
//  SpotifyAPI.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import Foundation

final class SpotifyAPI {
    
    private var basicToken: String? {
        let token = (spotifyClientID + ":" + spotifyClientSecretKey).data(using: .utf8)
        guard let base64Token = token?.base64EncodedString() else { return nil }
        return "Basic \(base64Token)"
    }
    
    private var accessToken: String? {
        guard let token = SpotifyManager.shared.accessToken else { return nil }
        return "Bearer \(token)"
    }
    
    func getAccessToken(from code: String, completion: @escaping (AuthResponse?) -> Void) {
        guard let basicToken = basicToken else { completion(nil); return }
        
        var components = URLComponents(string: "https://accounts.spotify.com/api/token")
        components?.queryItems = [URLQueryItem(name: "grant_type", value: "authorization_code"),
                                  URLQueryItem(name: "code", value: code),
                                  URLQueryItem(name: "redirect_uri", value: spotifyRedirectURL)]
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components?.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(basicToken, forHTTPHeaderField: "Authorization")
        
        request.fetch { result in
            completion(result)
        }
    }
    
    func refreshAccessToken(_ refreshToken: String, completion: @escaping (AuthResponse?) -> Void) {
        guard let basicToken = basicToken else { completion(nil); return }
        
        var components = URLComponents(string: "https://accounts.spotify.com/api/token")
        components?.queryItems = [URLQueryItem(name: "grant_type", value: "refresh"),
                                 URLQueryItem(name: "refresh_token", value: refreshToken)]
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components?.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(basicToken, forHTTPHeaderField: "Authorization")
        
        request.fetch { result in
            completion(result)
        }
    }
}
