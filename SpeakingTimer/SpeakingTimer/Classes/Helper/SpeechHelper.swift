//
//  SpeechHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 21/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// SpeechHelper Class : Provide all the methods needed to generate the speech to be spoken by the app when a certain time is reached.
//                      All these logic follows the requirements provided.
//                      Also generate the speech text to be shown on the app screen under the timer.
//

import UIKit
import AVFoundation
import UserNotifications

let textIdentifier = "timerIsOVer"
let stillText = NSLocalizedString("stillText", comment: "stillText for speech text")
let leftText = NSLocalizedString("leftText", comment: "leftText for speech text")
let hourText = NSLocalizedString("hourText", comment: "hourText for speech text")
let hoursText = NSLocalizedString("hoursText", comment: "hoursText for speech text")
let minutesText = NSLocalizedString("minutesText", comment: "minutesText for speech text")
let secondsText = NSLocalizedString("secondsText", comment: "secondsText for speech text")
let speechLanguage =  NSLocalizedString("speechLanguage", comment: "SpeechLanguage in en-US")

class SpeechHelper: NSObject {

    let speechSynthesizer = AVSpeechSynthesizer()
    var spechText : String!
    
    
    // MARK : Speak the text whic is being passed

    func speak(text: String) {
        let speakMsg = AVSpeechUtterance(string: text)
        speakMsg.voice  = AVSpeechSynthesisVoice(language: speechLanguage)
        speakMsg.rate = 0.55
        speechSynthesizer.speak(speakMsg)
    }
    
    
    // MARK : Updates speech countDown depends on the values (hours, minuts, seconds) which are being passed

    func updateSpeechCountDown(hours: Int, minutes: Int, seconds: Int) {
        speak(text: getSpeechTextForTimeIn(hours: hours, minutes: minutes, seconds: seconds))
    }

    
    // MARK : Get the speech text for the time values (hours, minuts, seconds) which are being passed

    func getSpeechTextForTimeIn(hours: Int, minutes: Int, seconds: Int) -> String {
        var speech = ""
        let hoursSpeech = hoursCountDown(hours: hours, minutes: minutes, seconds: seconds)
        let minutesSpeech = minutesCountDown(hours: hours, minutes: minutes, seconds: seconds)
        let secondsSpeech = secondsCountDown(hours: hours, minutes: minutes, seconds: seconds)
        
        if hoursSpeech != "" {
            speech = hoursSpeech
        } else if minutesSpeech != "" {
            speech = minutesSpeech
        } else if secondsSpeech != "" {
            speech = secondsSpeech
        }
        return speech
    }
    
    // MARK : Get the hours speech text

    func hoursCountDown(hours: Int, minutes: Int, seconds: Int) -> String {
        let stillHoursLeft = (minutes == 0 && seconds == 0 && hours > 0)
        return stillHoursLeft ? (stillText + " \(hours) " + hoursText + " " + leftText) : ""
    }
    
    // MARK : Get the minutes speech text

    func minutesCountDown(hours: Int, minutes: Int, seconds: Int) -> String {
        let stillFiveOrLessMinutesLeft = (hours == 0 && seconds == 0 && (minutes < 6 && minutes > 0))
        let stillMoreThanTenMinutes = (hours == 0 && seconds == 0 && (minutes > 9 && minutes < 51))
        let everyTenMinuetes = (seconds == 0 && (minutes == 50 || minutes == 40 || minutes == 30 || minutes == 20 || minutes == 10))
        let stillMinutesLeft = stillMoreThanTenMinutes && everyTenMinuetes
       
        return stillFiveOrLessMinutesLeft || stillMinutesLeft ? (stillText + " \(minutes) " + minutesText + " " + leftText) : ""
    }
    
    
    // MARK : Get the seconds speech text
    
    func secondsCountDown(hours: Int, minutes: Int, seconds: Int) -> String {
        let stillLessThanTenSeconds = (hours == 0 && minutes == 0 && (seconds < 11 && seconds > 0))
        let stillMoreThanTenSeconds = (hours == 0 && minutes == 0 && (seconds > 9  && seconds < 51))
        let everyTenSeconds = (seconds == 50 || seconds == 40 || seconds == 30 || seconds == 20)
        
        let stillSecondsLeft = stillMoreThanTenSeconds && everyTenSeconds
        
        if stillSecondsLeft {
            return (stillText + " \(seconds) " + secondsText + " " + leftText)
        }
        if stillLessThanTenSeconds {
            return ("\(seconds)")
        }
    
        return ""
    }
    
    
    // MARK : Shows And Says Time Done on a notification when the timer is over
    
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
}
