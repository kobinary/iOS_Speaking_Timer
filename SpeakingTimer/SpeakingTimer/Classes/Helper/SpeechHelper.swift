//
//  SpeechHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 21/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechHelper: NSObject {

    let speechSynthesizer = AVSpeechSynthesizer()
    var spechText : String!
    
    func speak(text: String) {
        self.spechText = text
        let speakMsg = AVSpeechUtterance(string: text)
        speakMsg.voice  = AVSpeechSynthesisVoice(language: "en-US")
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
            speak(text: "still \(hours) hours left")
        } else if (minutes == 0 && seconds == 0 && hours == 1) {
            speak(text: "still one hour left")
        }
    }
    
    func minutesCountDown(hours: Int, minutes: Int, seconds: Int) {
        if hours == 0 && seconds == 0 && (minutes > 9 && minutes < 51) {
            if  seconds == 0 && (minutes == 50 || minutes == 40 || minutes == 30 || minutes == 20 || minutes == 10) {
                speak(text: "still \(minutes) minutes left")
            }
        } else if hours == 0 && minutes == 5 && seconds == 0 {
            speak(text: "still 5 minutes left")
        } else if hours == 0 && (minutes < 5 && minutes > 0) && seconds == 0 {
            speak(text: "still \(minutes) minutes left")
        }
    }
    
    func secondsCountDown(hours: Int, minutes: Int, seconds: Int) {
        if hours == 0 && minutes == 0 && (seconds > 9  && seconds < 51) {
            if seconds == 50 || seconds == 40 || seconds == 30 || seconds == 20 || seconds == 10 {
                speak(text: "still \(seconds) seconds left")
            }
        } else if hours == 0 && minutes == 0 && (seconds < 10 && seconds > 0) {
            speak(text: "\(seconds)", rate: 0.5)
        }
    }
}
