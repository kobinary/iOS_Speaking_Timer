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
        content.title = NSLocalizedString("timerDoneText", comment: "timerDoneText for Notification")
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: TimeInterval(time), repeats: false)
        let request = UNNotificationRequest(identifier:textIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func countDownText(hours: Int, minutes: Int, seconds: Int) -> String {
        var speechText = ""
        
        let stillText = NSLocalizedString("stillText", comment: "stillText for speech text")
        let leftText = NSLocalizedString("leftText", comment: "leftText for speech text")
        let hourText = NSLocalizedString("hourText", comment: "hourText for speech text")
        let hoursText = NSLocalizedString("hoursText", comment: "hoursText for speech text")
        let minutesText = NSLocalizedString("minutesText", comment: "minutesText for speech text")
        let secondsText = NSLocalizedString("secondsText", comment: "secondsText for speech text")
        
        // Hours Speech Logic
        if minutes == 0 && seconds == 0 && hours > 1 {
            speechText = stillText + " \(hours) " + hoursText + " " + leftText
        } else if (minutes == 0 && seconds == 0 && hours == 1) {
            speechText = stillText + " \(hours) " + hourText + " " + leftText
        }
        
        // Minutes Speech Logic
        if hours == 0 && seconds == 0 && (minutes > 9 && minutes < 51) {
            if  seconds == 0 && (minutes == 50 || minutes == 40 || minutes == 30 || minutes == 20 || minutes == 10) {
                speechText = stillText + " \(minutes) " + minutesText + " " + leftText
            }
        } else if hours == 0 && minutes == 5 && seconds == 0 {
            speechText = stillText + " \(minutes) " + minutesText + " " + leftText
        } else if hours == 0 && (minutes < 5 && minutes > 0) && seconds == 0 {
            speechText = stillText + " \(minutes) " + minutesText + " " + leftText
        }
        
        // Seconds Speech Logic
        if hours == 0 && minutes == 0 && (seconds > 9  && seconds < 51) {
            if seconds == 50 || seconds == 40 || seconds == 30 || seconds == 20 || seconds == 10 {
                speechText = stillText + " \(seconds) " + secondsText + " " + leftText
            }
        } else if hours == 0 && minutes == 0 && seconds < 10 {
            speechText = "\(seconds)"
        }
        return speechText
    }
}


