//
//  SpotifyPlayer.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import AVFoundation

final class SpotifyPlayer {
    
    static let shared = SpotifyPlayer()
    
    private let api = DigaiAPI()
    private var player: AVPlayer?
    
    private init() {}
    
    func play(_ track: AudioTrack) {
        guard let urlString = track.previewUrl,
              let url = URL(string: urlString) else { return }
        
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func play (_ track: CreateRoomResponse.Track) {
        guard let url = URL(string: track.preview) else { return }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
