//
//  GameViewModel.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import SDWebImage

class GameViewModel {
    
    // MARK: - PRIVATE PROPERTIES
    
    var delegate: GameViewModelDelegate?
    
    private var userGuesses: [String?] = []
    private var index: Int = 0
    
    private let api = SpotifyAPI()
    private var audioTracks: [AudioTrack?] = []
    private var tracksIDs: [String] = ["4LRPiXqCikLlN15c3yImP7",
                                       "3IAfUEeaXRX9s9UdKOJrFI",
                                       "3sd2p4kE7xQmFH3lPnFl6h",
                                       "7xVSNhAUQhUIpwfR6lTOwA",
                                       "3BZEcbdtXQSo7OrvKRJ6mb",
                                       "35mvY5S1H3J2QZyna3TFe0"]
    
    // MARK: - INITIALIZER
    
    init() {
        userGuesses = [String?](repeating: nil, count: tracksIDs.count)
        setTracks()
    }
    
    // MARK: PUBLIC PROPERTIES
    
    public func getSongTitles() -> [String?] {
        return userGuesses
    }
    
    public func getSongTitle(at index: Int) -> String? {
        return userGuesses[index]
    }
    
    public func getNumberOfItens() -> Int {
        return tracksIDs.count
    }
    
    public func getIndex() -> Int {
        return index
    }
    
    public func getTextFieldPlaceHolder() -> String {
        return "E o nome da música é..."
    }
    
    public func getAlbumURL(forIndex index: Int, completion: @escaping (Result<String, Error>) -> Void) {
        api.getTrack(for: tracksIDs[index]) { track in
            guard let track = track else { return }
            completion(.success(track.album?.images.first?.url ?? ""))
        }
    }
    
    public func getAudioTrack(atIndex index: Int) -> AudioTrack? {
        return audioTracks[index]
    }
    
    public func updateSongTitle(at index: Int, with songTitle: String?) {
        self.userGuesses[index] = songTitle
    }
    
    public func updateIndex(_ index: Int) {
        self.index = index
    }
    
    private func setTracks() {
        for trackID in tracksIDs {
            api.getTrack(for: trackID) { [weak self] track in
                guard let self = self else { return }
                self.audioTracks.append(track)
            }
        }
    }
}

protocol GameViewModelDelegate {
    func didSetTracks()
}
