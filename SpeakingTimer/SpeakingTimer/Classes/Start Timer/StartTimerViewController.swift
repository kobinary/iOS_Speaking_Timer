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
    
    var pickerDataSource = [["0 hours", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                             "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"],
                            ["0 min","1","2","3", "4", "5", "6", "7", "8", "9", "10", "11",  "12", "13", "14", "15", "16", "17", "18", "19", "20",
                             "21", "22", "23","59"],
                            ["0 sec","1","2","3", "4", "5", "6", "7", "8", "9", "10", "11",  "12", "13", "14", "15", "16", "17", "18", "19", "20",
                             "21", "22", "23", "59"]];
    
    var viewModel = StartTimerViewModel()
    var timeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetPickerView()
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
    
    func resetPickerView() {
        self.timerPicker.selectRow(0, inComponent: 0, animated: false)
        self.timerPicker.selectRow(0, inComponent: 1, animated: false)
        self.timerPicker.selectRow(0, inComponent: 2, animated: false)
    }

     // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        self.timeInterval = TimeConversorHelper().transforStringValuesIntoSeconds(hours: viewModel.hours,
                                                                                  minutes: viewModel.minutes,
                                                                                  seconds: viewModel.seconds)
        return self.timeInterval > 0 ? true : false
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "runTimer" {
            let runningViewController = segue.destination as! RunningTimerViewController
            runningViewController.hero.isEnabled = true
            runningViewController.hero.modalAnimationType = .fade
            
            let runningViewModel = RunningTimerViewModel.init(withTime: self.timeInterval)
            runningViewController.updateWithViewModel(viewModel: runningViewModel)
        }
    }
}

enum TimerComponents : Int {
    case hours = 0, mins, secs
}

extension StartTimerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerDataSource[component][row]
        let titleInWhite = NSAttributedString(string: titleData,
                                              attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica Neue", size: 15.0)!, NSAttributedStringKey.foregroundColor:UIColor.white])
        return titleInWhite
    }

}
