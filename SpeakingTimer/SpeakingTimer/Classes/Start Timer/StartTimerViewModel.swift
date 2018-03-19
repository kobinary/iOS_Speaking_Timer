//
//  StartTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class StartTimerViewModel: NSObject {
    
    var hours : String = "0"
    var minutes : String = "0"
    var seconds : String = "0"
    
    func getTimeIntervalWithSelectedValues() -> Int {
        return self.transforValuesIntoTimerData(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func transforValuesIntoTimerData(hours: String, minutes: String, seconds: String) -> Int {
        let hoursValue = Int(hours)
        let minutesValue = Int(minutes)
        let secondsValue = Int(seconds)

        let hoursToMinutes = hoursValue! * 60
        let minutesToSeconds = (minutesValue! * 60) + (hoursValue! * 60)
        let timeInterval = hoursToMinutes + minutesToSeconds + secondsValue!
        
        return timeInterval
    }
    
}
