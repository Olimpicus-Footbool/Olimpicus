//
//  AudioPlayerService.swift
//  OlimpicFind
//
//  Created by Developer on 02.12.2022.
//
import UserDefaultsStandard
import Foundation
import AVFoundation
import AVKit
import Combine

final class AudioPlayerService {
    
    public var trackEnd     : ClosureEmpty!
    public var isPlay       = false
    public var isMute       = false
    public var trackPlaying = false
    
    static let shared = AudioPlayerService()
    
    private var player     : AVPlayer!
    private var audioPlayer: AVAudioPlayer!
    
    //загрузка аудио файла
    public func load(fileName: Files, type: Types = .mp3) {
        guard let isMusic: Bool = UserDefaultsStandard.shared.get(key: .isMusic),
              isMusic else {
            return
        }
        guard let file = Bundle.main.path(
            forResource: fileName.rawValue,
            ofType: type.rawValue) else { return }
        let url = URL(fileURLWithPath: file)
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.numberOfLoops = 0
            self.audioPlayer.volume = 0.5
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    public func mute(){
        self.isMute.toggle()
    }
    
    public func pause(delay: Double = 0){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.audioPlayer?.pause()
            self.isPlay = false
        }
    }
    
    public func play() {
        self.audioPlayer?.play()
        self.isPlay = true
    }
    
    private func addObserver(){
        let nsTime = CMTime(seconds: 1, preferredTimescale: 1000)
        self.player.addPeriodicTimeObserver(forInterval: nsTime, queue: DispatchQueue.main) { (time) in
            let second   = self.player.currentTime().seconds
            let duration = self.player.currentItem?.duration.seconds ?? 0
            guard second == duration, self.isPlay else { return }
            self.isPlay = false
            guard self.trackPlaying else { return }
            self.isPlay = true
            self.trackEnd?()
        }
    }
    
    enum Files: String {
        case openCard
        case successCard
        case loseCard
        case winGame
        case gameFon
    }
    
    enum Types: String, CaseIterable {
        case mp3
        case wav
    }
}
