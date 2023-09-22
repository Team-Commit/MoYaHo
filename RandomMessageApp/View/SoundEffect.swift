//
//  File.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/21.
//

import Foundation
import AVFoundation


class SoundEffect {
    
    var crashAudioPlayer: AVAudioPlayer?
    var oceanAudioPlayer: AVAudioPlayer?
    var windAudioPlayer: AVAudioPlayer?

    
    func playCrashSound() {
        guard let url = Bundle.main.url(forResource: "crash", withExtension: "mp3") else {return}
        do {
            crashAudioPlayer = try AVAudioPlayer(contentsOf: url)
            crashAudioPlayer?.play()
            print("Attempting to play sound.")

        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func playOceanSound() {
        guard let url = Bundle.main.url(forResource: "summer-surf-120252", withExtension: "mp3") else { return }
        do {
            oceanAudioPlayer = try AVAudioPlayer(contentsOf: url)
            oceanAudioPlayer?.numberOfLoops = -1
            oceanAudioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
     
    func playWindSound() {
        guard let url = Bundle.main.url(forResource: "wind", withExtension: "mp3") else { return }
        do {
            windAudioPlayer = try AVAudioPlayer(contentsOf: url)
            windAudioPlayer?.numberOfLoops = -1
            windAudioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }

    
}
