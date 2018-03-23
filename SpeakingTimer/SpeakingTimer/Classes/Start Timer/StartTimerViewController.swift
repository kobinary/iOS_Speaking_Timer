//
//  StartTimerViewController.swift
//  SpeakingTimer
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// StartTimerViewController Class : It is the viewController whichs shows the first screen where the PickerView
//                                  is shown to select the time for the timer. Ans Start button to start runnung the timer.
//
//

import UIKit

enum TimerComponents : Int {
    case hours = 0, mins, secs
}

class StartTimerViewController: UIViewController {
   
    @IBOutlet weak var timerPicker: UIPickerView!
    
    var pickerData = [[""]]
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
    
    
    // MARK: - All setup methods
    
    func addBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    func setup() {
        self.setupPicker()
        self.addBackground()
    }
    
    func setupPicker() {
        self.getPickerData()
        self.timerPicker.dataSource = self;
        self.timerPicker.delegate = self;
        self.timerPicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    func resetPickerView() {
        self.getPickerData()
        self.timerPicker.selectRow(0, inComponent: 0, animated: false)
        self.timerPicker.selectRow(0, inComponent: 1, animated: false)
        self.timerPicker.selectRow(0, inComponent: 2, animated: false)
    }
    
    func getPickerData() {
        self.pickerData = viewModel.getPickerValues()
        print(self.pickerData)
    }
    
    // MARK: - Navigation method between viewControllers

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        self.timeInterval = TimeConversorHelper().transformStringValuesIntoSeconds(hours: viewModel.hours,
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


// MARK: - Extension with all the PickerView Logic

extension StartTimerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerComponent = TimerComponents(rawValue: component)
            
        switch pickerComponent {
        case .hours?:
            viewModel.hours = pickerData[component][row]
            break
        case .mins?:
            viewModel.minutes = pickerData[component][row]
            break
        default:
            viewModel.seconds = pickerData[component][row]
            break
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[component][row]
        let titleInWhite = NSAttributedString(string: titleData,
                                              attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica Neue", size: 15.0)!, NSAttributedStringKey.foregroundColor:UIColor.white])
        return titleInWhite
    }

}
