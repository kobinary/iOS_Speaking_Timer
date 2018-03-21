//
//  RunningTimerViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit
import Hero

class RunningTimerViewController: UIViewController, RunningTimerDelegate {

    var viewModel : RunningTimerViewModel!
    @IBOutlet weak var leftTimeLabel: UILabel!
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
        self.updateLabelWithCurrentTime()
    }
    
    func updateWithViewModel(viewModel: RunningTimerViewModel) {
        viewModel.delegate = self
        self.viewModel = viewModel
        self.viewModel.startTimer()
    }
    
    func updateLabelWithCurrentTime() {
        self.timerLabel.text = viewModel.updateTimeLabel(time: viewModel.time)
        self.leftTimeLabel.text = viewModel.speechText
    }
    
    func updateLabelWithRunningTime(time: String) {
        self.timerLabel.text = time
        self.leftTimeLabel.text = viewModel.speechText
    }
    
    func updatePasueResumeButton() {
        if viewModel.isTimerPaused {
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

    func stopTimerAndDismissView() {
        viewModel.stopTimer()
        self.dismissTimer()
    }

    @IBAction func stopTimer(_ sender: Any) {
        self.stopTimerAndDismissView()
    }

    @IBAction func pauseResumeTimer(_ sender: Any) {
        if viewModel.isTimerPaused {
            viewModel.resumeTimer()
        } else {
            viewModel.pauseTimer()
        }
        self.updatePasueResumeButton()
    }
    
    func dismissTimer() {
        self.dismiss(animated: true, completion: nil)
    }
    
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
        LocalNotificationHelper().showNotification(time: viewModel.time)
    }
    
    @objc func timerDidEnterToForeground(notification: Notification) {
        
    }
}
