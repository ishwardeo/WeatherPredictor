//
//  WeatherPredictorUITests.swift
//  WeatherPredictorUITests
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import XCTest

class WeatherPredictorUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
    }

    func testFetchWeather() {
        // Launch the application
        let app = XCUIApplication()
        app.launch()

        // 1st button tap
        let showCititesBtn = app.buttons[GlobalConstants.SHOW_CITIES]
        XCTAssertTrue(showCititesBtn.exists, "Show Citites Button does not exist")
        //Tap the button
        showCititesBtn.tap()
        
        sleep(1)
        
        // 2.  city selection
        let masterTableView = app.tables.matching(identifier: String(describing: MasterViewController.self))

        // City Selection / Master table cell selection
        let firstCell = masterTableView.cells.element(matching: .cell, identifier: "TVC_0_0")

        // Existence check
        XCTAssertTrue(firstCell.exists, "1st cell does not exist")
        firstCell.tap()
        
        let predicate = NSPredicate(format: "exists == 1")
        let fetchWeatherExp = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let result = XCTWaiter.wait(for: [fetchWeatherExp], timeout: 5.0) // wait and store the result
//        XCTAssertTrue(result == .completed)
        
        // 3. Tap "See Map" in Details screen
        let seeMapBtn = app.buttons[GlobalConstants.SHOW_CURRENT_CITY_MAP]
        XCTAssertTrue(seeMapBtn.exists, "See Map Button does not exist")
        seeMapBtn.tap()

        let seeMapPredicate = NSPredicate(format: "exists == 1")
        let seeMapExp = expectation(for: seeMapPredicate, evaluatedWith: seeMapBtn, handler: nil)
        let result2 = XCTWaiter.wait(for: [seeMapExp], timeout: 5.0) // wait and store the result
//        XCTAssertTrue(result2 == .completed)

        // 4. Forecast for 5 days, 3 hours
        
        let forecastButton = app.buttons[GlobalConstants.FORECAST_WEATHER]
        XCTAssertTrue(forecastButton.exists, "Forecast Button does not exist")
        forecastButton.tap()
        
        let forecastButtonPredicate = NSPredicate(format: "exists == 1")
        let forecastExp = expectation(for: forecastButtonPredicate, evaluatedWith: forecastButton, handler: nil)
        let result3 = XCTWaiter.wait(for: [forecastExp], timeout: 5.0)
        // wait and store the result
//        XCTAssertTrue(result3 == .completed)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
            }
        }
    }
}
