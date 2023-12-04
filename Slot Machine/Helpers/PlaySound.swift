//
//  PlaySound.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 4.12.2023.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound:String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }

}
