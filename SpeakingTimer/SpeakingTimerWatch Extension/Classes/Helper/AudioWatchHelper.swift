//
//  AudioWatchHelper.swift
//  SpeakingTimerWatch Extension
//
//  Created by Maria Ortega on 22/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// AudioWatchHelper Class : Plays time over sound selected by name (like alarm1.mp3, alarm2.mp3 and alarm3.mp3) when the timer is done.
//                          The sound plays infinetly until user taps Stop on the Alert View on screen.
//

import WatchKit

class AudioWatchHelper: NSObject {

    var player: WKAudioFilePlayer!

    // MARK : Alarm Sound Logic

    func setupPlayer() {
        let filePath = Bundle.main.path(forResource: "alarm2", ofType: "mp3")!
        let fileUrl = NSURL.fileURL(withPath: filePath)
        let asset = WKAudioFileAsset.init(url: fileUrl)
        let playerItem = WKAudioFilePlayerItem(asset: asset)
        player = WKAudioFilePlayer(playerItem: playerItem)
    }
    
    func playSound() {
        player.play()
    }
}
