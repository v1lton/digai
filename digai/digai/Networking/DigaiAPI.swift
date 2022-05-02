//
//  SpotifyAPI.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import Foundation

final class DigaiAPI {
    
    // MARK: - PRIVATE METHODS
    
    private var baseURL: String {
        return "http://localhost:3000"
    }
    
    // MARK: - PUBLIC METHODS
    
    func createRoom(for request: CreateRoomRequest, completion: @escaping (CreateRoomResponse?) -> Void) {
        let jsonData = try? JSONEncoder().encode(request)
        guard let url = URL(string: "\(baseURL)/api/create-room") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        request.fetch { response in
            completion(response)
        }
    }
    
    func joinRoom(for request: JoinRoomRequest, completion: @escaping (JoinRoomResponse?) -> Void) {
        let jsonData = try? JSONEncoder().encode(request)
        guard let url = URL(string: "\(baseURL)/api/join-room") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        request.fetch { response in
            completion(response)
        }
    }
    
    func fetchRooms(completion: @escaping (FetchRoomsResponse?) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/fetch-rooms") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.fetch { response in
            completion(response)
        }
    }
    
    func exitRoom(for request: ExitRoomRequest, completion: @escaping (ExitRoomResponse?) -> Void) {
        let jsonData = try? JSONEncoder().encode(request)
        guard let url = URL(string: "\(baseURL)/api/exit-room") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        request.fetch { response in
            completion(response)
        }
    }
    
    func updateRoom(for request: UpdateRoomRequest, completion: @escaping (UpdateRoomResponse?) -> Void) {
        let jsonData = try? JSONEncoder().encode(request)
        guard let url = URL(string: "\(baseURL)/api/update-room") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        request.fetch { response in
            completion(response)
        }
    }
    
    func restartRoom(for request: RestartRoomRequest, completion: @escaping (RestartRoomResponse?) -> Void) {
        let jsonData = try? JSONEncoder().encode(request)
        guard let url = URL(string: "\(baseURL)/api/restart-room") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        request.fetch { response in
            completion(response)
        }
    }
}
