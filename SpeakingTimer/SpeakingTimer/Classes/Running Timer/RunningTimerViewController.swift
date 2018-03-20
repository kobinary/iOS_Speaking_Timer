//
//  RunningTimerViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit
import Hero

class RunningTimerViewController: UIViewController {

    var time : Int = 0
    var timer = Timer()
    var isTimerRunning : Bool = false
    var isTimerPaused : Bool = false
    let viewModel = RunningTimerViewModel()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseResumeButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func setup() {
        self.addBackground()
        self.updatePasueResumeButton()
        self.updateTimeLabel()
    }
    
    func updateTimeLabel() {
        self.timerLabel.text = viewModel.updateTimeLabel(time: self.time)
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
            viewModel.timerIsOver()
            self.showAlertIsOver()
        } else {
            time -= 1
            timerLabel.text = viewModel.updateTimeLabel(time: time)
        }
    }

    func stopTimer() {
        self.timer.invalidate()
        self.isTimerRunning = false
        self.dismiss(animated: true, completion: nil)
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

extension RunningTimerViewController {
    
    func showAlertIsOver() {
        let alarmActionHandler = { (action:UIAlertAction!) -> Void in
            AudioHelper().stopAlarm()
        }
        
        let alert = UIAlertController(title: "Timer Done", message: nil , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Stop", style: UIAlertActionStyle.destructive, handler: alarmActionHandler))
        self.present(NotificationPopUp().showAlertIsOver(), animated: true, completion: nil)
    }
    
}
