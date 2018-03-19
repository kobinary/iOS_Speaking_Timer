//
//  StartViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var pickerTimer: UIDatePicker!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func addBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    func setup() {
        self.addBackground()
        self.setupPicker()
    }
    
    func setupPicker() {
        pickerTimer.setValue(UIColor.white, forKeyPath: "textColor")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

