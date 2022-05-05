//
//  GameViewModel.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import SDWebImage

class GameViewModel {
    
    // MARK: - PUBLIC PROPERTIES
    
    var delegate: GameViewModelDelegate?
    public var socketManager: GameSocketManager?
    // MARK: - PRIVATE PROPERTIES
    
    private var userGuesses: [String?] = []
    private var index: Int = 0
    
    private let api = DigaiAPI()
    private var digaiResponse: CreateRoomResponse
    
    // MARK: - INITIALIZER
     
    init(room: CreateRoomResponse, socketManager: GameSocketManager?) {
        self.digaiResponse = room
        self.socketManager = socketManager
        setTracks()
    }
    
    // MARK: - PUBLIC METHODS
    
    public func getSongTitles() -> [String?] {
        return userGuesses
    }
    
    public func getSongTitleGuess(at index: Int) -> String? {
        if index >= 0 && index < userGuesses.count {
            return userGuesses[index]
        }
        return nil
    }
    
    public func getNumberOfItens() -> Int {
        return digaiResponse.tracks.count
    }
    
    public func getIndex() -> Int {
        return index
    }
    
    public func getTextFieldPlaceHolder() -> String {
        return "E o nome da música é..."
    }
    
    public func getAlbumURL(at index: Int) -> String? {
        //guard let digaiResponse = digaiResponse else { return nil }
        if index < digaiResponse.tracks.count {
            return digaiResponse.tracks[index].albumArt
        }
        return nil
    }
    
    public func getAudioTrack(at index: Int) -> Track? {
        if index < digaiResponse.tracks.count {
            return digaiResponse.tracks[index]
        }
        return nil
    }
    
    public func updateSongGuess(at index: Int, with songTitle: String?) {
        self.userGuesses[index] = songTitle
    }
    
    public func updateIndex(_ index: Int) {
        self.index = index
    }
    
    // MARK: - PRIVATE METHODS
    
    public func setTracks() {
       
        self.setupUserGuesses(with: digaiResponse.tracks.count )
        DispatchQueue.main.async {
            self.delegate?.didSetTracks()
        }
        
    }
    
    private func setupUserGuesses(with count: Int) {
        userGuesses = [String?](repeating: nil, count: count)
    }
    
}

protocol GameViewModelDelegate {
    func didSetTracks()
}
