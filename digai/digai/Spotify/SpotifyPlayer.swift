//
//  SpotifyPlayer.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import AVFoundation

final class SpotifyPlayer {
    
    static let shared = SpotifyPlayer()
    
    private let api = SpotifyAPI()
    private var player: AVPlayer?
    
    private init() {}
    
    func play(_ id: String) {
        api.getTrack(for: "4LRPiXqCikLlN15c3yImP7") { track in
            guard let track = track else { return }
            SpotifyPlayer.shared.play(track)
        }
    }
    
    func play(_ track: AudioTrack) {
        guard let urlString = track.previewUrl,
              let url = URL(string: urlString) else { return }
        
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
