//
//  StartTimerInterfaceController.swift
//  SpeakingTimerWatch Extension
//
//  Created by Maria Ortega on 22/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//
//
// StartTimerInterfaceController Class : It is the first InterfaceController whichs allow the user to select the time for the timer.
//
//


import WatchKit
import Foundation

class StartTimerInterfaceController: WKInterfaceController {

    @IBOutlet var hoursPickerView: WKInterfacePicker!
    @IBOutlet var minutesPickerView: WKInterfacePicker!
    @IBOutlet var secondsPickerView: WKInterfacePicker!
    @IBOutlet var startButton: WKInterfaceButton!
    
    var pickerViewData = [[""]]
    var hours : Int = 0
    var minutes : Int = 0
    var seconds : Int = 0
    var viewModel = StartTimerViewModel()
    
    // MARK: - All setup methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.setupPickerView()
    }
    
    func setupPickerView() {
        self.getPickerData()
        self.setupPickerData()
    }
    
    func getPickerData() {
        self.pickerViewData = viewModel.getPickerValues()
    }
    
    func setupPickerData() {
        hoursPickerView.setItems(getPickerItems(array: self.pickerViewData[0]))
        minutesPickerView.setItems(getPickerItems(array: self.pickerViewData[1]))
        secondsPickerView.setItems(getPickerItems(array: self.pickerViewData[2]))
    }

    func getPickerItems(array : [String]) -> [WKPickerItem] {
        var pickerItems : [WKPickerItem] = []
        
        for value in array {
            let pickerItem = WKPickerItem()
            let correctValue = viewModel.getCorrectValueFrom(stringValue: value)
            pickerItem.title = correctValue
            pickerItems.append(pickerItem)
        }
        return pickerItems
    }
    
    func resetPicker() {
        hoursPickerView?.setSelectedItemIndex(0)
        minutesPickerView?.setSelectedItemIndex(0)
        secondsPickerView?.setSelectedItemIndex(0)
    }

    override func willActivate() {
        super.willActivate()
        self.resetPicker()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    
    // MARK: - WKPickerInterface Selection Logic
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        return ["time": TimeConversorHelper().transformTimeIntoSeoncds(hours: self.hours, minutes: self.minutes, seconds: self.seconds)]
    }
    
    @IBAction func pickerHoursSelectedItemChanged(_ value: Int) {
        self.hours = value
    }
    
    @IBAction func pickerMinssSelectedItemChanged(_ value: Int) {
        self.minutes = value
    }
    
    @IBAction func pickerSecsSelectedItemChanged(_ value: Int) {
        self.seconds = value
    }
    
}

