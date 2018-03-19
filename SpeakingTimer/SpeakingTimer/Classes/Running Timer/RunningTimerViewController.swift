//
//  RunningTimerViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class RunningTimerViewController: UIViewController {

    var initTimeInDate : Date!
    var pausedTime : Date!
    var timer = Timer()
    var isTimerRunning : Bool = false
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
        
    func setup() {
        self.addBackground()
    }
    
    func addBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }

}

extension RunningTimerViewController {
    
//    
//    func startTimerFrom(time: Date) {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
//        self.isTimerRunning = true
//
//    }
//    
//    func updateTimer() {
//        if seconds < 1 {
//            timer.invalidate()
//            //Send alert to indicate time's up.
//        } else {
//            seconds -= 1
//            timerLabel.text = timeString(time: TimeInterval(seconds))
//            timerLabel.text = String(seconds)
//            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
//        }
//    }
//    
//    func timeString(time:TimeInterval) -> String {
//        let hours = Int(time) / 3600
//        let minutes = Int(time) / 60 % 60
//        let seconds = Int(time) % 60
//        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
//    }
//    
//    func stopTimer() {
//        self.timer.invalidate()
//        self.isTimerRunning = false
//    }
//    
//    func pauseTimer() {
//        self.timer.invalidate()
//        self.isTimerRunning = false
//        // save current time in paused timer
//    }
//    
//    func resumeTimer() {
//        self.starTimerFrom(time: pausedTime)
//    }
//    
//    @IBAction func stopTimer(_ sender: Any) {
//        self.stopTimer()
//    }
//    
//    @IBAction func pauseTimer(_ sender: Any) {
//        self.pauseTimer()
//    }
    
}
