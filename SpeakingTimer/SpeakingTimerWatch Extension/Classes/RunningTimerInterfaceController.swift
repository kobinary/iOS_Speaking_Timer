//
//  RunningTimerInterfaceController.swift
//  SpeakingTimerWatch Extension
//
//  Created by Maria Ortega on 22/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import WatchKit
import Foundation
import AVFoundation

class RunningTimerInterfaceController: WKInterfaceController {

    @IBOutlet var intervalTimer: WKInterfaceTimer!
    @IBOutlet var pauseButton: WKInterfaceButton!
    @IBOutlet var stopButton: WKInterfaceButton!
    
    var isTimerPaused : Bool = false
    var speechTimer = Timer()
    var time : Int = 0

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.updatePasueResumeButton()
        self.setupWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        invalidateTimers()
        super.didDeactivate()
    }
    
    func setupWithContext(_ context: Any?) {
        let dict = context as? NSDictionary
        if dict != nil {
            self.time = dict!["time"] as! Int
            self.starTimerWithTime(time)
        }
    }
}


/*
 EXTENSION: Timer Methods
 */
extension RunningTimerInterfaceController {
    
    func starTimerWithTime(_ time : Int) {
        speechTimer = Timer.scheduledTimer(timeInterval: 1,
                                           target: self,
                                           selector: (#selector(updateTimer)),
                                           userInfo: nil,
                                           repeats: true)
        
        let timeInDate  = NSDate(timeIntervalSinceNow: TimeInterval(time))
        intervalTimer.setDate(timeInDate as Date)
        intervalTimer.start()
    }
    
    @objc func updateTimer() {
        print("updateTimer: ",time)
        if time < 1 {
            speechTimer.invalidate()
        } else {
            time -= 1
            updateSpeechTime(time: time)
        }
    }
    
    func updateSpeechTime(time: Int) {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        SpeechHelper().updateCountDown(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func resumeTimer() {
        self.isTimerPaused = false
        starTimerWithTime(time)
    }
    
    func pausedTimer() {
        self.isTimerPaused = true
        invalidateTimers()
    }
    
    func updatePasueResumeButton() {
        if self.isTimerPaused {
            self.pauseButton.setTitle("Resume")
        } else {
            self.pauseButton.setTitle("Pause")
        }
    }
    
    @IBAction func stopTimer() {
        invalidateTimers()
        popToRootController()
    }
    
    @IBAction func pauseTimer() {
        if self.isTimerPaused {
            self.resumeTimer()
        } else {
            self.pausedTimer()
        }
        self.updatePasueResumeButton()
    }
    
    func invalidateTimers() {
        intervalTimer.stop()
        speechTimer.invalidate()
    }
    
}
