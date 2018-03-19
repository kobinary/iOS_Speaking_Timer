//
//  StartTimerViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import UIKit

class StartTimerViewController: UIViewController {
   
    @IBOutlet weak var timerPicker: UIPickerView!
    
    var pickerDataSource = [["0 hours", "1", "2", "3", "4", "5", "6"],["0 min","1","2","3", "4", "5", "6"],["0 sec","1","2","3", "4", "5", "6"]];
    
    var viewModel = StartTimerViewModel()
    
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
        self.timerPicker.dataSource = self;
        self.timerPicker.delegate = self;
        self.timerPicker.setValue(UIColor.white, forKeyPath: "textColor")
    }

    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "runTimer" {
            let runningViewController = segue.destination as! RunningTimerViewController
            runningViewController.time = self.viewModel.getTimeIntervalWithSelectedValues()
            runningViewController.startTimer()
        }
     }
}

enum TimerComponents : Int {
    case hours = 0, mins, secs
}

extension StartTimerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerComponent = TimerComponents(rawValue: component)
            
        switch pickerComponent {
        case .hours?:
            viewModel.hours = pickerDataSource[component][row]
            break
        case .mins?:
            viewModel.minutes = pickerDataSource[component][row]
            break
        default:
            viewModel.seconds = pickerDataSource[component][row]
            break
            
        }
    }
    
}
