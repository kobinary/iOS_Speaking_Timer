//
//  DeviceSizeHelper.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 23/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class DeviceSizeHelper: NSObject {

    let generalTimerFontSize : Float = 68.0
    let smallTimerFontSize : Float = 57.0
    let iPhoneSE = 1136.0
    
    func getCorrectFontSize() -> Float {
        let screenSize = UIScreen.main.nativeBounds.height
        switch screenSize {
        case 1136.0 : // SE
            return smallTimerFontSize
        default:
            return generalTimerFontSize
        }
    }
}
