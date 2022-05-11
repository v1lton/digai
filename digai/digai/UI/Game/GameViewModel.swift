//
//  GameViewModel.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

protocol GameViewModelDelegate {
    func didSetTracks()
    func didStopGame()
}

class GameViewModel {
    
    // MARK: - PUBLIC PROPERTIES
    
    var delegate: GameViewModelDelegate?
    var socketManager: GameSocketManager?
    var textFieldPlaceHolder: String = "E o nome da música é..."
    
    // MARK: - PRIVATE PROPERTIES
    
    private var userGuesses: [String?] = []
    private var index: Int = 0
    private var digaiResponse: CreateRoomResponse
    
    // MARK: - INITIALIZER
     
    init(room: CreateRoomResponse, socketManager: GameSocketManager?) {
        self.digaiResponse = room
        self.socketManager = socketManager
        
        self.socketManager?.delegate = self
        setTracks()
    }
    
    // MARK: - PUBLIC METHODS
    
    public func getSongTitles() -> [String?] {
        return userGuesses
    }
    
    public func getSongTitleGuess(at index: Int) -> String? {
        guard index >= 0 && index < userGuesses.count else { return nil }
        return userGuesses[index]
    }
    
    public func getNumberOfItens() -> Int {
        return digaiResponse.tracks.count
    }
    
    public func getIndex() -> Int {
        return index
    }
    
    public func getAlbumURL(at index: Int) -> String? {
        guard index >= 0 && index < digaiResponse.tracks.count else { return nil }
        return digaiResponse.tracks[index].albumArt
    }
    
    public func getAudioTrack(at index: Int) -> Track? {
        guard index >= 0 && index < digaiResponse.tracks.count else { return nil }
        return digaiResponse.tracks[index]
    }
    
    public func updateSongGuess(at index: Int, with songTitle: String?) {
        self.userGuesses[index] = songTitle
    }
    
    public func updateIndex(_ index: Int) {
        self.index = index
    }
    
    func requestStop() {
        socketManager?.requestStop() { [weak self] in
            self?.delegate?.didStopGame()
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    public func setTracks() {
        setupUserGuesses(with: digaiResponse.tracks.count )
        
        DispatchQueue.main.async {
            self.delegate?.didSetTracks()
        }
    }
    
    private func setupUserGuesses(with count: Int) {
        userGuesses = [String?](repeating: nil, count: count)
    }
}

// MARK: - GameSocketManagerDelegate

extension GameViewModel: GameSocketManagerDelegate {

    func didReceive(event: SocketEvents, data: Any?) {
        if event == .propagateStop {
            Player.shared.pause()
            delegate?.didStopGame()
        }
    }
}
