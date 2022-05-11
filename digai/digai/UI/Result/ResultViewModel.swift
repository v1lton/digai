//
//  ResultViewModel.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

protocol ResultViewModelDelegate: AnyObject {
    func didGetResults()
}

class ResultViewModel: ResultViewModelProtocol {
    
    // MARK: - PUBLIC PROPERTIES
    
    weak var delegate: ResultViewModelDelegate?
    
    // MARK: - PRIVATE PROPERTIES
    
    private var results: Results? = nil
    
    // MARK: - INITIALIZER
    
    init() {
        getResults()
    }
    
    // MARK: - PUBLIC METHODS
    
    func getResultsCount() -> Int {
        return results?.individualResults.count ?? 0
    }
    
    func getIndividualResult(at index: Int) -> IndividualResult? {
        guard let results = results else { return nil }
        
        if index < results.individualResults.count {
            return results.individualResults[index]
        }
        
        return nil
    }
    
    func getMaximumScore() -> Int {
        return results?.maximumScore ?? 0
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getResults() {
        let results: Results = .init(individualResults: [
            .init(userName: "arthur", userScore: 3),
            .init(userName: "morgs", userScore: 3),
            .init(userName: "jac", userScore: 2),
            .init(userName: "scala", userScore: 2),
            .init(userName: "wilton", userScore: 1)
        ], maximumScore: 5)
        
        self.results = results
        delegate?.didGetResults()
    }
}
