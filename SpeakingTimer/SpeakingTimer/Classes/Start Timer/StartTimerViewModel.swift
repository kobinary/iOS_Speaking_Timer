//
//  StartTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class StartTimerViewModel: NSObject {
    
    var hours : String! {
        didSet {
            print(hours)
        }
    }
    var minutes : String! {
        didSet {
            print(minutes)
        }
    }
    var seconds : String! {
        didSet {
            print(seconds)
        }
    }
    
    var timer : NSDate!
    
    func getTimerDataWithSelectedValues() {
        self.transforValuesIntoTimerData(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func transforValuesIntoTimerData(hours: String, minutes: String, seconds: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let time = hours+":"+minutes+":"+seconds
        let date = dateFormatter.date(from: time) //according to date format your date string
        print(date ?? "") //Convert String to Date
        
    }
    
}
