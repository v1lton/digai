//
//  Result.swift
//  digai
//
//  Created by Wilton Ramos on 03/05/22.
//

public struct Results: Codable {
    let individualResults: [IndividualResult]
    let maximumScore: Int
}

public struct IndividualResult: Codable {
    let name: String
    let crowns: Int
}
