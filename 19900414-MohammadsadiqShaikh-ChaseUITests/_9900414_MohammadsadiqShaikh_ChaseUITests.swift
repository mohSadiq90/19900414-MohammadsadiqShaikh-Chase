//
//  _9900414_MohammadsadiqShaikh_ChaseUITests.swift
//  19900414-MohammadsadiqShaikh-ChaseUITests
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import XCTest

final class _9900414_MohammadsadiqShaikh_ChaseUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApp() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let txt = app.textFields["City"]
        txt.tap()
        txt.typeText("Pune")
        let button = app.buttons["Search"]
        button.tap()
        let loading =  app.staticTexts["Loading..."]
        XCTAssertTrue(loading.waitForExistence(timeout: 1))

        let expectation = XCTestExpectation(description: "data loaded")
        let details = app.staticTexts["Weather details"]
        let exist = details.waitForExistence(timeout: 2)
  
        if exist {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
