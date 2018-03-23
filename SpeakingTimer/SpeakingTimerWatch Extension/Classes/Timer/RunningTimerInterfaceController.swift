//
//  RunningTimerInterfaceController.swift
//  SpeakingTimerWatch Extension
//
//  Created by Maria Ortega on 22/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
//  RunningTimerInterfaceController Class : It is the InterfaceController which shows the timer running on the watch.
//                                          Shows Stop, Pause and Resume button.
//
//

import WatchKit
import Foundation
import AVFoundation

class RunningTimerInterfaceController: WKInterfaceController {

    @IBOutlet var intervalTimer: WKInterfaceTimer!
    @IBOutlet var pauseButton: WKInterfaceButton!
    @IBOutlet var stopButton: WKInterfaceButton!
    
    var player: WKAudioFilePlayer!
    var isTimerPaused : Bool = false
    var speechTimer = Timer()
    var backgroundTask = BackgroundTask()
    var time : Int = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.updatePasueResumeButton()
        self.setupWithContext(context)
        self.setupPlayer()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    
    // MARK : Setup Method
    
    func setupWithContext(_ context: Any?) {
        let dict = context as? NSDictionary
        if dict != nil {
            self.time = dict!["time"] as! Int
            self.starTimerWithTime(time)
        }
    }
    
    func setupPlayer() {
        self.player = AudioWatchHelper().setupPlayer()
    }
}


// MARK : Extension with all the Timer Methods

extension RunningTimerInterfaceController {
    
    func starTimerWithTime(_ time : Int) {
        backgroundTask.startBackgroundTask()
        self.speechTimer = Timer.scheduledTimer(timeInterval: 1,
                                           target: self,
                                           selector: (#selector(updateTimer)),
                                           userInfo: nil,
                                           repeats: true)
        
        let timeInDate  = NSDate(timeIntervalSinceNow: TimeInterval(time))
        self.intervalTimer.setDate(timeInDate as Date)
        self.intervalTimer.start()
    }
    
    @objc func updateTimer() {
        if time < 1 {
            SpeechHelper().speak(text: NSLocalizedString("timeIsOverText", comment: "timeIsOverText speech"))
            self.timerIsOver()
            self.showAlertIsOver()
        } else {
            time -= 1
           self.updateSpeechTime(time: time)
        }
    }
    
    func showAlertIsOver() {
        let handleAction = WKAlertAction.init(title: NSLocalizedString("stopText", comment: "stopText for Alert"), style:.cancel) {
            self.stopAlarm()
        }
        presentAlert(withTitle: NSLocalizedString("timerDoneText", comment: "timerDoneText for Alert"),
                     message:nil,
                     preferredStyle:.actionSheet,
                     actions: [handleAction])
    }
    
    func updateSpeechTime(time: Int) {
        let (hours, minutes, seconds) = TimeConversorHelper().transformIntevalIntoTime(interval: Int(time))
        SpeechHelper().updateSpeechCountDown(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func resumeTimer() {
        self.isTimerPaused = false
        self.starTimerWithTime(time)
    }
    
    func pausedTimer() {
        self.isTimerPaused = true
        self.invalidateTimers()
    }
    
    func updatePasueResumeButton() {
        if self.isTimerPaused {
            self.pauseButton.setTitle(NSLocalizedString("resumeText", comment: "resumeText for button"))
        } else {
            self.pauseButton.setTitle(NSLocalizedString("pauseText", comment: "pauseText for button"))
        }
    }
    
    @IBAction func stopTimer() {
        self.invalidateTimers()
        popToRootController()
    }
    
    func timerIsOver() {
        self.invalidateTimers()
        self.player.play()
    }
    
    @IBAction func pauseTimer() {
        if self.isTimerPaused {
            self.resumeTimer()
        } else {
            self.pausedTimer()
        }
        self.updatePasueResumeButton()
    }
    
    func stopAlarm() {
        self.player.pause()
        invalidateTimers()
    }
    
    func invalidateTimers() {
        intervalTimer.stop()
        speechTimer.invalidate()
        backgroundTask.stopBackgroundTask()
    }
}
