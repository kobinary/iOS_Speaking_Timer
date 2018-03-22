//
//  LocalNotificationHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 21/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

let textIdentifier = "timerIsOVer"

class LocalNotificationHelper: NSObject {

    func showSpeechNotification(time: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Done"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: TimeInterval(time), repeats: false)
        let request = UNNotificationRequest(identifier:textIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func countDownText(hours: Int, minutes: Int, seconds: Int) -> String {
        if minutes == 0 && seconds == 0 && hours > 1 {
            return("still \(hours) hours left")
        } else if (minutes == 0 && seconds == 0 && hours == 1) {
            return( "still one hour left")
        }
        if hours == 0 && seconds == 0 && (minutes > 9 && minutes < 51) {
            if  seconds == 0 && (minutes == 50 || minutes == 40 || minutes == 30 || minutes == 20 || minutes == 10) {
                return ("still \(minutes) minutes left")
            }
        } else if hours == 0 && minutes == 5 && seconds == 0 {
            return("still 5 minutes left")
        } else if hours == 0 && (minutes < 5 && minutes > 0) && seconds == 0 {
            return( "still \(minutes) minutes left")
        }
        if hours == 0 && minutes == 0 && (seconds > 9  && seconds < 51) {
            if seconds == 50 || seconds == 40 || seconds == 30 || seconds == 20 || seconds == 10 {
                return("still \(seconds) seconds left")
            }
        } else if hours == 0 && minutes == 0 && seconds < 10 {
            return("\(seconds)")
        }
        return ""
    }
}


