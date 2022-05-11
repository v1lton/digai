//
//  SpotifyPlayer.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import AVFoundation

final class Player {
    
    static let shared = Player()

    private var player: AVPlayer?
    
    private init() {}
    
    func play (_ track: Track) {
        guard let url = URL(string: track.preview) else { return }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
