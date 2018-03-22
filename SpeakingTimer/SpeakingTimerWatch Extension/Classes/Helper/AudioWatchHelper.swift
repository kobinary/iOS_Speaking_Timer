//
//  AudioWatchHelper.swift
//  SpeakingTimerWatch Extension
//
//  Created by Maria Ortega on 22/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import WatchKit

class AudioWatchHelper: NSObject {

    var player: WKAudioFilePlayer!

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
