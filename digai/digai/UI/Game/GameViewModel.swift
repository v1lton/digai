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
    
    // MARK: - PRIVATE PROPERTIES
    
    private var userGuesses: [String?] = []
    private var index: Int = 0
    
    private let api = DigaiAPI()
    private var digaiResponse: CreateRoomResponse?
    
    // MARK: - INITIALIZER
    
    init() {
        setTracks()
    }
    
    // MARK: - PUBLIC METHODS
    
    public func getSongTitles() -> [String?] {
        return userGuesses
    }
    
    public func getSongTitle(at index: Int) -> String? {
        return nil
    }
    
    public func getNumberOfItens() -> Int {
        return digaiResponse?.tracks.count ?? 0
    }
    
    public func getIndex() -> Int {
        return index
    }
    
    public func getTextFieldPlaceHolder() -> String {
        return "E o nome da música é..."
    }
    
    public func getAlbumURL(at index: Int) -> String? {
        guard let digaiResponse = digaiResponse else { return nil }
        if index < digaiResponse.tracks.count {
            return digaiResponse.tracks[index].albumArt
        }
        return nil
    }
    
    public func getAudioTrack(at index: Int) -> CreateRoomResponse.Track? {
        guard let digaiResponse = digaiResponse else { return nil }
        if index < digaiResponse.tracks.count {
            return digaiResponse.tracks[index]
        }
        return nil
    }
    
    public func updateSongTitle(at index: Int, with songTitle: String?) {
        self.userGuesses[index] = songTitle
    }
    
    public func updateIndex(_ index: Int) {
        self.index = index
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setTracks() {
        let createRoomRequest = CreateRoomRequest(steps: 5,
                                                  owner: .init(name: "kk",
                                                               crowns: 0),
                                                  genres: ["funk"])
        api.createRoom(for: createRoomRequest) { [weak self] createRoom in
            guard let self = self else { return }
            self.digaiResponse = createRoom
            self.setupUserGuesses(with: createRoom?.tracks.count ?? 0)
            DispatchQueue.main.async {
                self.delegate?.didSetTracks()
            }
        }
    }
    
    private func setupUserGuesses(with count: Int) {
        userGuesses = [String?](repeating: nil, count: count)
    }
}

protocol GameViewModelDelegate {
    func didSetTracks()
}
