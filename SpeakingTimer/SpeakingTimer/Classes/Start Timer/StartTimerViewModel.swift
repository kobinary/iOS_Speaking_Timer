//
//  StartTimerViewModel.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
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
    
    func getCorrectValueFrom(stringValue: String) -> String {
        return stringValue.contains(" ") ? "0" : stringValue
    }
}
