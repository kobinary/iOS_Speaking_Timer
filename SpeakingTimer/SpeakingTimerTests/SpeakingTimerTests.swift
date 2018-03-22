//
//  SpeakingTimerTests.swift
//  SpeakingTimerTests
//
//  Created by Maria Ortega on 19/03/2018.
//  Copyright © 2018 Maria Ortega. All rights reserved.
//

import XCTest
@testable import SpeakingTimer

class SpeakingTimerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStartTimerViewModelCorrectVariablesValues() {
        
        let viewModel = StartTimerViewModel()
        
        viewModel.hours = "0 hours"
        viewModel.minutes = "0 mins"
        viewModel.seconds = "0 secs"
        
        XCTAssertEqual(viewModel.hours, "0")
        XCTAssertEqual(viewModel.minutes, "0")
        XCTAssertEqual(viewModel.seconds, "0")
        
        let viewModel_2 = StartTimerViewModel()
        
        viewModel_2.hours = "0 asd adasd"
        viewModel_2.minutes = "234 3"
        viewModel_2.seconds = "   "
        
        XCTAssertEqual(viewModel_2.hours, "0")
        XCTAssertEqual(viewModel_2.minutes, "0")
        XCTAssertEqual(viewModel_2.seconds, "0")
        
        let viewModel_3 = StartTimerViewModel()
        
        viewModel_3.hours = "5"
        viewModel_3.minutes = "2"
        viewModel_3.seconds = "1"
        
        XCTAssertEqual(viewModel_3.hours, "5")
        XCTAssertEqual(viewModel_3.minutes, "2")
        XCTAssertEqual(viewModel_3.seconds, "1")
    }
    
    func testTransforTimeIntoSeoncds() {
        var (hours, minutes , seconds) : (Int, Int, Int) = (1, 5, 40)
        var timeConverted = TimeConversorHelper().transforTimeIntoSeoncds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 3940)
        
        (hours, minutes , seconds) = (0, 9, 21)
        timeConverted = TimeConversorHelper().transforTimeIntoSeoncds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 561)
        
        (hours, minutes , seconds) = (20, 0, 0)
        timeConverted = TimeConversorHelper().transforTimeIntoSeoncds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 72000)
        
        (hours, minutes , seconds) = (3, 3, 3)
        timeConverted = TimeConversorHelper().transforTimeIntoSeoncds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 10983)
    }
    
    func testTransforStringValuesIntoSeconds() {
        var (hours, minutes , seconds) = ("0", "10", "59")
        var timeConverted = TimeConversorHelper().transforStringValuesIntoSeconds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 659)
        
        (hours, minutes , seconds)  = ("0", "0", "0")
        timeConverted = TimeConversorHelper().transforStringValuesIntoSeconds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 0)
        
        (hours, minutes , seconds)  = ("0", "54", "2")
        timeConverted = TimeConversorHelper().transforStringValuesIntoSeconds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 3242)
        
        (hours, minutes , seconds) = ("23", "59", "59")
        timeConverted = TimeConversorHelper().transforStringValuesIntoSeconds(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(timeConverted, 86399)
        
        let (hours_2, minutes_2 , seconds_2) : (String, String, String) = ("4", "32", "0")
        let timeConverted_2 = TimeConversorHelper().transforStringValuesIntoSeconds(hours: hours_2, minutes: minutes_2, seconds: seconds_2)
        XCTAssertEqual(timeConverted_2, 16320)
    }
    
    func testTransformIntevalIntoTime() {
        let (hours, minutes , seconds) : (Int, Int, Int) = (4, 32, 0)
        let timeInterval = 16320
        let  (hoursConverted, minutesConverted , secondsConverted) = TimeConversorHelper().transformIntevalIntoTime(interval: timeInterval)
        XCTAssertEqual(hoursConverted, hours)
        XCTAssertEqual(minutesConverted, minutes)
        XCTAssertEqual(secondsConverted, seconds)
    }
    
    func testCountDownText() {
        var (hours, minutes, seconds) : (Int, Int, Int) = (0, 0, 0)
        
        (hours, minutes, seconds) = (0, 0, 10)
        var speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "still 10 seconds left")
        
        (hours, minutes, seconds) = (0, 0, 9)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "9")

        (hours, minutes, seconds) = (0, 0, 40)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "still 40 seconds left")

        (hours, minutes, seconds) = (1, 0, 1)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "")
        
        (hours, minutes, seconds) = (1, 0, 0)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "still one hour left")

        (hours, minutes, seconds) = (0, 50, 0)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime,  "still 50 minutes left")

        (hours, minutes, seconds) = (0, 5, 0)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "still 5 minutes left")

        (hours, minutes, seconds) = (0, 2, 0)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "still 2 minutes left")

        (hours, minutes, seconds) = (3, 0, 00)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "still 3 hours left")

        (hours, minutes, seconds) = (1, 5, 46)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime, "")

        (hours, minutes, seconds) = (0, 10, 7)
        speechForTime = LocalNotificationHelper().countDownText(hours: hours, minutes: minutes, seconds: seconds)
        XCTAssertEqual(speechForTime,  "")
    }

    
}
