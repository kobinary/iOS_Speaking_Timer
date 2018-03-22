//
//  SpeakingTimerUITests.swift
//  SpeakingTimerUITests
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import XCTest

class SpeakingTimerUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStartTimerLabels() {
        XCTAssert(app.staticTexts["Speaking Timer"].exists)
        XCTAssert(app.staticTexts["Speaking Timer helps you track your progress while practicing."].exists)
    }
    
    func testStartTimerPickerView() {
        let pickerWheel = app/*@START_MENU_TOKEN@*/.pickerWheels["0 hours"]/*[[".pickers.pickerWheels[\"0 hours\"]",".pickerWheels[\"0 hours\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pickerWheel.tap()
        pickerWheel.swipeUp()
        
        let pickerWheel2 = app/*@START_MENU_TOKEN@*/.pickerWheels["0 min"]/*[[".pickers.pickerWheels[\"0 min\"]",".pickerWheels[\"0 min\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pickerWheel2.tap()
        pickerWheel2.swipeUp()
        
        let pickerWheel3 = app/*@START_MENU_TOKEN@*/.pickerWheels["0 sec"]/*[[".pickers.pickerWheels[\"0 sec\"]",".pickerWheels[\"0 sec\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pickerWheel3.tap()
        pickerWheel3.swipeUp()
      
        app.buttons["Start"].tap()
    }
    
    func testRunningTimer() {
        let pickerWheel = app/*@START_MENU_TOKEN@*/.pickerWheels["0 min"]/*[[".pickers.pickerWheels[\"0 min\"]",".pickerWheels[\"0 min\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pickerWheel.tap()
        pickerWheel.swipeUp()
        app/*@START_MENU_TOKEN@*/.pickerWheels["0 sec"]/*[[".pickers.pickerWheels[\"0 sec\"]",".pickerWheels[\"0 sec\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.buttons["Start"].tap()
        app.buttons["Pause"].tap()
        app.buttons["Resume"].tap()
        app.buttons["Stop"].tap()
    }
    
}
