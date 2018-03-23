//
//  RunningTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// RunningTimerViewModel Class : It is the StartTimer View Model for the RunningTimerViewContrller.
//                               Where the main logic is based, like all the timer logic, activate speech, etc.
//

import UIKit

protocol RunningTimerDelegate {
    func updateLabelWithRunningTime(time: String, leftTime: String)
    func showAlertIsOver()
}

class RunningTimerViewModel: NSObject {

    var hours : String = "0"
    var minutes : String = "0"
    var seconds : String = "0"
    var speechText : String = ""
    var delegate: RunningTimerDelegate?
    
    var time : Int = 0
    var timer = Timer()
    var isTimerRunning : Bool = false
    var isTimerPaused : Bool = false
    var isTimerOnBackground : Bool = false
    var backgroundTask = BackgroundTask()
    
    init(withTime time: Int) {
        self.time = time
    }
    
    // MARK : Update Countdown Methods
    
    @objc func updateTimer() {
        if time < 1 {
            SpeechHelper().speak(text: NSLocalizedString("timeIsOverText", comment: "timeIsOverText speech"))
            self.timerIsOver()
            delegate?.showAlertIsOver()
        } else {
            time -= 1
            let isFinalCountdown = time < 10
            delegate?.updateLabelWithRunningTime(time: self.updateTimeLabel(time: time),
                                                 leftTime: isFinalCountdown ? "" : self.updateLeftTimeLabel(time: time))
        }
    }
    
    func updateLeftTimeLabel(time: Int) -> String {
        let (hours, minutes, seconds) = TimeConversorHelper().transformIntevalIntoTime(interval: Int(time))
        return SpeechHelper().getSpeechTextForTimeIn(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func updateTimeLabel(time: Int) -> String {
        let (hours, minutes, seconds) = TimeConversorHelper().transformIntevalIntoTime(interval: Int(time))
        SpeechHelper().updateSpeechCountDown(hours: hours, minutes: minutes, seconds: seconds)
        let timeString = String(format:"%02i : %02i : %02i", hours, minutes, seconds)
    
        return timeString
    }
    
    
    // MARK : Timer Methods
    
    func startTimer() {
        if !self.isTimerRunning {
            self.runTimer()
        }
    }
    
    func runTimer() {
        backgroundTask.startBackgroundTask()
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: (#selector(updateTimer)),
                                          userInfo: nil,
                                          repeats: true)
        self.isTimerRunning = true
    }
    
    func pauseTimer() {
        self.timer.invalidate()
        backgroundTask.stopBackgroundTask()
        self.isTimerRunning = false
        self.isTimerPaused = true
    }
    
    func resumeTimer() {
        self.runTimer()
        self.isTimerRunning = true
        self.isTimerPaused = false
    }
    
    func stopTimer() {
        self.timer.invalidate()
        backgroundTask.stopBackgroundTask()
        self.isTimerRunning = false
    }
    
    func timerIsOver() {
        self.timer.invalidate()
        AudioHelper().playTimeIsOverWith(sound: "alarm2")
    }
}
