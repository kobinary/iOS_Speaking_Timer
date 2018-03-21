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
        return self.transfromTime(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func transfromTime(hours: String, minutes: String, seconds: String) -> Int {
        self.hours = getCorrectValueFrom(stringValue: hours)
        self.minutes = getCorrectValueFrom(stringValue: minutes)
        self.seconds = getCorrectValueFrom(stringValue: seconds)
        
        return self.transforValuesIntoTimerData()
    }
    
    func transforValuesIntoTimerData() -> Int {
        let hoursValue = Int(self.hours)
        let minutesValue = Int(self.minutes)
        let secondsValue = Int(self.seconds)

        let hoursToMinutes = hoursValue! * 60
        let minutesToSeconds = (minutesValue! * 60) + (hoursValue! * 60)
        let timeInterval = hoursToMinutes + minutesToSeconds + secondsValue!
        
        return timeInterval
    }
    
    func getCorrectValueFrom(stringValue: String) -> String {
        return stringValue.contains(" ") ? "0" : stringValue
    }
    
}
