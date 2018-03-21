//
//  AudioHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 20/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftySound

class AudioHelper: NSObject {

    func playTimeIsOverWith(sound: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                Sound.play(file: sound, fileExtension: "mp3", numberOfLoops: numberOfLoops())
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func numberOfLoops() -> Int {
        if let result = Int("-1") {
            return result
        }
        return 0
    }
    
    func stopAlarm() {
        Sound.stopAll()
    }
}
