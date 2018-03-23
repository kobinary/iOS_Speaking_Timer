//
//  StartTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// StartTimerViewModel Class : It is the StartTimer View Model for the StartTimerViewContrller. Where the main variables are set.
//
//

import UIKit

class StartTimerViewModel: NSObject {
    
    var hours : String = "0" {
        didSet {
            hours = getCorrectValueFrom(stringValue: hours)
        }
    }
    var minutes : String = "0" {
        didSet {
            minutes = getCorrectValueFrom(stringValue: minutes)
        }
    }
    var seconds : String = "0" {
        didSet {
            seconds = getCorrectValueFrom(stringValue: seconds)
        }
    }
    
    
    // MARK: - Get the correct String Value to be a valid Int

    func getCorrectValueFrom(stringValue: String) -> String {
        return stringValue.contains(" ") ? "0" : stringValue
    }
    
    // MARK: - Get the values to be shown into the picker view
    
    func getPickerValues() -> [[String]] {
        
        var hoursValues = ["0 hours"]
        var minutesValues = ["0 mins"]
        var secondsValues = ["0 secs"]
        
        for value in 1...59 {
            if value < 24 {
                hoursValues.append("\(value)")
            }
            minutesValues.append("\(value)")
            secondsValues.append("\(value)")
        }
        return [hoursValues, minutesValues, secondsValues]
    }

    
}
