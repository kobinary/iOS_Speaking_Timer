//
//  StartTimerInterfaceController.swift
//  SpeakingTimerWatch Extension
//
//  Created by Maria Ortega on 22/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import WatchKit
import Foundation

class StartTimerInterfaceController: WKInterfaceController {

    @IBOutlet var oneMinButton: WKInterfaceButton!
    @IBOutlet var twoMinsButton: WKInterfaceButton!
    @IBOutlet var fiveMinsButton: WKInterfaceButton!
    @IBOutlet var tenMinsButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        return ["time": Int(segueIdentifier)]
    }
}
