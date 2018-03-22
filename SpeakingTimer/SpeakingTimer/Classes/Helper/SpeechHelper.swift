//
//  SpeechHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 21/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit
import AVFoundation

let stillText = NSLocalizedString("stillText", comment: "stillText for speech text")
let leftText = NSLocalizedString("leftText", comment: "leftText for speech text")
let hourText = NSLocalizedString("hourText", comment: "hourText for speech text")
let hoursText = NSLocalizedString("hoursText", comment: "hoursText for speech text")
let minutesText = NSLocalizedString("minutesText", comment: "minutesText for speech text")
let secondsText = NSLocalizedString("secondsText", comment: "secondsText for speech text")
let speechLanguage =  NSLocalizedString("en-US-SpeechLanguage", comment: "SpeechLanguage in en-US")

class SpeechHelper: NSObject {

    let speechSynthesizer = AVSpeechSynthesizer()
    var spechText : String!
    
    func speak(text: String) {
        self.spechText = text
        let speakMsg = AVSpeechUtterance(string: text)
        speakMsg.voice  = AVSpeechSynthesisVoice(language: speechLanguage)
        speechSynthesizer.speak(speakMsg)
    }
    
    func speak(text: String, rate: Float) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = rate
        speechSynthesizer.speak(speechUtterance)
    }
    
    func updateCountDown(hours: Int, minutes: Int, seconds: Int) {
        hoursCountDown(hours: hours, minutes: minutes, seconds: seconds)
        minutesCountDown(hours: hours, minutes: minutes, seconds: seconds)
        secondsCountDown(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func hoursCountDown(hours: Int, minutes: Int, seconds: Int) {
        if minutes == 0 && seconds == 0 && hours > 1 {
            speak(text: stillText + " \(hours) " + hoursText + " " + leftText)
        } else if (minutes == 0 && seconds == 0 && hours == 1) {
            speak(text: stillText + " \(hours) " + hourText + " " + leftText)
        }
    }
    
    func minutesCountDown(hours: Int, minutes: Int, seconds: Int) {
        if hours == 0 && seconds == 0 && (minutes > 9 && minutes < 51) {
            if  seconds == 0 && (minutes == 50 || minutes == 40 || minutes == 30 || minutes == 20 || minutes == 10) {
                speak(text: stillText + " \(minutes) " + minutesText + " " + leftText)
            }
        } else if hours == 0 && minutes == 5 && seconds == 0 {
            speak(text: stillText + " \(minutes) " + minutesText + " " + leftText)
        } else if hours == 0 && (minutes < 5 && minutes > 0) && seconds == 0 {
            speak(text: stillText + " \(minutes) " + minutesText + " " + leftText)
        }
    }
    
    func secondsCountDown(hours: Int, minutes: Int, seconds: Int) {
        if hours == 0 && minutes == 0 && (seconds > 9  && seconds < 51) {
            if seconds == 50 || seconds == 40 || seconds == 30 || seconds == 20 || seconds == 10 {
                speak(text: stillText + " \(seconds) " + secondsText + " " + leftText)
            }
        } else if hours == 0 && minutes == 0 && (seconds < 10 && seconds > 0) {
            speak(text: "\(seconds)", rate: 0.5)
        }
    }
}
