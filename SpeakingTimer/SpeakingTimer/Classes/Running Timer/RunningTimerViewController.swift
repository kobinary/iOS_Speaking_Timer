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
    var isTimerOnBackground : Bool = false
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
        self.addObservers()
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
        print("updateTimer: ",self.time)
        if time < 1 {
            timer.invalidate()
            viewModel.timerIsOver()
            self.showAlertIsOver()
        } else {
            time -= 1
            timerLabel.text = viewModel.updateTimeLabel(time: time)
            SpeechHelper().speak(text: "5 minutes left")
        }
    }

    func stopTimer() {
        self.timer.invalidate()
        self.isTimerRunning = false
    }
    
    func stopTimerAndDismissView() {
        self.stopTimer()
        self.dismissTimer()
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
        self.stopTimerAndDismissView()
    }

    @IBAction func pauseResumeTimer(_ sender: Any) {
        if self.isTimerPaused {
            self.resumeTimer()
        } else {
            self.pauseTimer()
        }
        self.updatePasueResumeButton()
    }
    
    func dismissTimer() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RunningTimerViewController {

    func showAlertIsOver() {
        let alert = UIAlertController(title: "Timer Done", message: nil , preferredStyle: UIAlertControllerStyle.alert)
      
        alert.addAction(UIAlertAction(title: "Stop", style: UIAlertActionStyle.destructive, handler:{ action in
            self.stopAlarm()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func stopAlarm() {
        AudioHelper().stopAlarm()
        self.stopTimerAndDismissView()
    }
}

extension RunningTimerViewController {
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(timerDidEnterToBackground(notification:)), name: .UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(timerDidEnterToForeground(notification:)), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func timerDidEnterToBackground(notification: Notification) {
        print(self.time)
        LocalNotificationHelper().showNotification(time: self.time)
    }
    
    @objc func timerDidEnterToForeground(notification: Notification) {
        
        
    }
}
