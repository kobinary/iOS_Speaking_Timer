//
//  RunningTimerViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class RunningTimerViewController: UIViewController {

    var time : Int = 0
    var timer = Timer()
    var isTimerRunning : Bool = false
    var isTimerPaused : Bool = false
    let viewModel = RunningTimerViewModel()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseResumeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
        
    func setup() {
        self.addBackground()
        self.updatePasueResumeButton()
    }
    
    func updatePasueResumeButton() {
        if isTimerPaused {
            self.pauseResumeButton.setTitle("Resume", for: UIControlState.normal)
        } else {
            self.pauseResumeButton.setTitle("Pause", for: UIControlState.normal)
        }
        self.pauseResumeButton.reloadInputViews()
    }
    
    func addBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
}

extension RunningTimerViewController {

    func startTimer() {
        if !self.isTimerRunning {
            self.runTimer()
        }
    }
    
    func runTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: (#selector(RunningTimerViewController.updateTimer)),
                                          userInfo: nil,
                                          repeats: true)
        self.isTimerRunning = true
    }

    @objc func updateTimer() {
        if time < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            time -= 1
            timerLabel.text = viewModel.updateTimeLabel(time: TimeInterval(time))
        }
    }

    func stopTimer() {
        self.timer.invalidate()
        self.isTimerRunning = false
    }

    func pauseTimer() {
        self.timer.invalidate()
        self.isTimerRunning = false
        self.isTimerPaused = true
    }

    func resumeTimer() {
        self.runTimer()
        self.isTimerRunning = true
        self.isTimerPaused = false
    }

    @IBAction func stopTimer(_ sender: Any) {
        self.stopTimer()
    }

    @IBAction func pauseResumeTimer(_ sender: Any) {
        if self.isTimerPaused {
            self.resumeTimer()
        } else {
            self.pauseTimer()
        }
        self.updatePasueResumeButton()
    }
    
}
