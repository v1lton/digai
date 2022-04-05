//
//  RestAPI.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import Foundation

extension URLRequest {
    
    func fetch<T: Codable>(completion: @escaping (T?) -> Void) {
        let task = URLSession.shared.dataTask(with: self) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200 ..< 300) ~= response.statusCode,
                  error == nil else {
                
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(T.self, from: data)
                completion(result)
                
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        
        task.resume()
    }
}
