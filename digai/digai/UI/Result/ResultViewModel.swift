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
    var socketManager: GameSocketManager?
    
    // MARK: - PRIVATE PROPERTIES
    
    private var results: Results? = nil {
        didSet { delegate?.didGetResults() }
    }
    
    // MARK: - INITIALIZER
    
    init(socketManager: GameSocketManager?) {
        self.socketManager = socketManager
        self.socketManager?.delegate = self
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
    
    func sendGuesses(_ guesses: [String?]) {
        socketManager?.trackAssert(guesses: guesses) { [weak self] data in
            self?.setResults(from: data)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setResults(from data: Any?) {
        guard let resultsString = data as? String,
              let data = resultsString.data(using: .utf8),
              let results = try? JSONDecoder().decode([IndividualResult].self, from: data) else { return }
                
        self.results = Results(individualResults: results, maximumScore: 5)
    }
}

// MARK: - GameSocketManagerDelegate

extension ResultViewModel: GameSocketManagerDelegate {

    func didReceive(event: SocketEvents, data: Any?) {
        if event == .resume {
            setResults(from: data)
        }
    }
}
