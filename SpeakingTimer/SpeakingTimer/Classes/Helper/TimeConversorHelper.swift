//
//  TimeConversorHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 20/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class TimeConversorHelper: NSObject {

    func transforTimeIntoSeoncds(hours: Int, minutes: Int, seconds: Int) -> Int {
        let hoursToMinutes = hours * 60
        let minutesToSeconds = (minutes * 60) + (hoursToMinutes * 60)
        let timeInSeconds = minutesToSeconds + seconds
        
        return timeInSeconds
    }
    
    func transforStringValuesIntoSeconds(hours: String, minutes: String, seconds: String) -> Int {
        let hoursValue = Int(hours)
        let minutesValue = Int(minutes)
        let secondsValue = Int(seconds)
        
        let hoursToSeconds = hoursValue! * 60
        let minutesToSeconds = (minutesValue! * 60) + (hoursToSeconds * 60)
        let timeInSeconds = minutesToSeconds + secondsValue!
        
        return timeInSeconds
    }
    
    func transformIntevalIntoTime(interval: Int) -> (Int, Int, Int) {
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        return (hours,minutes,seconds)
    }
   
}
