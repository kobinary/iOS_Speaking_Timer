//
//  RunningTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class RunningTimerViewModel: NSObject {

    var hours : String = "0"
    var minutes : String = "0"
    var seconds : String = "0"
    
    func updateTimeLabel(time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        let timeString = String(format:"%02i : %02i : %02i", hours, minutes, seconds)
        return timeString
    }

    func timerIsOver() {
        AudioHelper().playTimeIsOverWith(sound: "alarm2")
    }

}
