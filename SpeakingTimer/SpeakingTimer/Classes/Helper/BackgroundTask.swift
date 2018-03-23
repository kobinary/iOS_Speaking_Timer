//
//  BackgroundTask.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 20/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// BackgroundTask Class : Allows the timer still working when the app goes into Background.
//
//

import AVFoundation

class BackgroundTask {
    
    var player = AVAudioPlayer()
    var timer = Timer()
    
    func startBackgroundTask() {
        NotificationCenter.default.addObserver(self, selector: #selector(interuptedAudio), name: NSNotification.Name.AVAudioSessionInterruption, object: AVAudioSession.sharedInstance())
        self.playAudio()
    }
    
    func stopBackgroundTask() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        player.stop()
    }
    
    @objc fileprivate func interuptedAudio(_ notification: Notification) {
        if notification.name == NSNotification.Name.AVAudioSessionInterruption && notification.userInfo != nil {
            var info = notification.userInfo!
            var intValue = 0
            (info[AVAudioSessionInterruptionTypeKey]! as AnyObject).getValue(&intValue)
            if intValue == 1 { playAudio() }
        }
    }
    
    fileprivate func playAudio() {
        do {
            let bundle = Bundle.main.path(forResource: "alarm1", ofType: "mp3")
            let alertSound = URL(fileURLWithPath: bundle!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with:AVAudioSessionCategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            try self.player = AVAudioPlayer(contentsOf: alertSound)
            self.player.numberOfLoops = -1
            self.player.volume = 0.00
            self.player.prepareToPlay()
            self.player.play()
        } catch { print(error) }
    }
}
