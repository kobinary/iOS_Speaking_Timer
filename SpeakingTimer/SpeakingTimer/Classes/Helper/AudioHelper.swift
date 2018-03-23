//
//  AudioHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 20/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// AudioHelper Class : Plays time over sound selected by name (like alarm1.mp3, alarm2.mp3 and alarm3.mp3) when the timer is done.
//                     The sound plays infinetly until user taps Stop on the Alert View on screen.
//

import UIKit
import AVFoundation
import SwiftySound

class AudioHelper: NSObject {

    // MARK : Alarm Sound Logic
    
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
    
    func stopAlarm() {
        Sound.stopAll()
    }
    
    
    // MARK : Loop method to keep the alarm sounding until is being stoped
    
    private func numberOfLoops() -> Int {
        if let result = Int("-1") {
            return result
        }
        return 0
    }
    
  
}
