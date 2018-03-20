//
//  NotificationPopUp.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 20/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class NotificationPopUp: NSObject {

    func showAlertIsOver() -> UIAlertController {
        
        let alarmActionHandler = { (action:UIAlertAction!) -> Void in
            AudioHelper().stopAlarm()
        }
        
        let alert = UIAlertController(title: "Timer Done", message: nil , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Stop", style: UIAlertActionStyle.destructive, handler: alarmActionHandler))
        return alert
    }
    
}
