//
//  RunningTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

protocol RunningTimerDelegate {
    func updateLabelWithRunningTime(time: String)
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
    
    @objc func updateTimer() {
        print("updateTimer: ",self.time)
        if time < 1 {
            SpeechHelper().speak(text: NSLocalizedString("timeIsOverText", comment: "timeIsOverText speech"))
            self.timerIsOver()
            delegate?.showAlertIsOver()
        } else {
            time -= 1
            delegate?.updateLabelWithRunningTime(time: self.updateTimeLabel(time: time))
        }
    }
    
    func stopTimer() {
        self.timer.invalidate()
        backgroundTask.stopBackgroundTask()
        self.isTimerRunning = false
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
    
    func updateTimeLabel(time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        SpeechHelper().updateCountDown(hours: hours, minutes: minutes, seconds: seconds)
        
        let timeString = String(format:"%02i : %02i : %02i", hours, minutes, seconds)
        return timeString
    }

    func timerIsOver() {
        self.timer.invalidate()
        AudioHelper().playTimeIsOverWith(sound: "alarm2")
    }
}
