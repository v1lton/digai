//
//  ResultViewModelProtocol.swift
//  digai
//
//  Created by Wilton Ramos on 03/05/22.
//

protocol ResultViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    var delegate: ResultViewModelDelegate? { get set }
    
    // MARK: - FUNCTIONS
    
    func getResultsCount() -> Int
    func getIndividualResult(at index: Int) -> IndividualResult?
    func getMaximumScore() -> Int
}
