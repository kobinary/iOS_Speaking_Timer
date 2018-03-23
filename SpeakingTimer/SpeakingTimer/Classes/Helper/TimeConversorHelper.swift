//
//  TimeConversorHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 20/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// TimeConversorHelper Class : Provide all the methods needed to transform Time in miliseconds to Hours, Minutes and Seconds, and viceversa also.
//                             Also transform String values into miliseconds values to usa as TimeInteval into the Timer.
//

import UIKit

class TimeConversorHelper: NSObject {

    
    // MARK : Transform Time in (hours, minuts, seconds) into a milisecs

    func transformTimeIntoSeoncds(hours: Int, minutes: Int, seconds: Int) -> Int {
        let hoursToMinutes = hours * 60
        let minutesToSeconds = (minutes * 60) + (hoursToMinutes * 60)
        let timeInSeconds = minutesToSeconds + seconds
        
        return timeInSeconds
    }


    // MARK : Transform String values (hours, minuts, seconds) into a milisecs

    func transformStringValuesIntoSeconds(hours: String, minutes: String, seconds: String) -> Int {
        let hoursValue = Int(hours)
        let minutesValue = Int(minutes)
        let secondsValue = Int(seconds)
        
        let hoursToSeconds = hoursValue! * 60
        let minutesToSeconds = (minutesValue! * 60) + (hoursToSeconds * 60)
        let timeInSeconds = minutesToSeconds + secondsValue!
        
        return timeInSeconds
    }
    
    
    // MARK : Transform Milisecs into Time values (hours, minuts, seconds)

    func transformIntevalIntoTime(interval: Int) -> (Int, Int, Int) {
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        return (hours,minutes,seconds)
    }

    
    // MARK : Get Time Difference from Date to hours, minuts, seconds
    
    static func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
        return(components.hour!, components.minute!, components.second!)
    }

}
