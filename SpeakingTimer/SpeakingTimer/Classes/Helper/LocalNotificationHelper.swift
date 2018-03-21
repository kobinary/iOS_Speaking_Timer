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

class LocalNotificationHelper: NSObject, UNUserNotificationCenterDelegate {
    
    func showNotification(time: Int) {
        
        let content = UNMutableNotificationContent()
        content.title = "Timer Done"
//        content.subtitle = "Lets code,Talk is cheap"
//        content.body = "Sample code from WWDC"
        content.sound = UNNotificationSound(named: "alarm2.mp3")
        
        //To Present image in notification
        //        if let path = Bundle.main.path(forResource: "monkey", ofType: "png") {
        //            let url = URL(fileURLWithPath: path)
        //
        //            do {
        //                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
        //                content.attachments = [attachment]
        //            } catch {
        //                print("attachment not found.")
        //            }
        //        }
        //
        
        let timeInterval = TimeInterval(time)
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier:"TimerIsOVer", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil) {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == "TimerIsOVer"{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}
