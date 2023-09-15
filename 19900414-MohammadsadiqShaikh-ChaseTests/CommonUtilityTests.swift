//
//  CommonUtilityTests.swift
//  19900414-MohammadsadiqShaikh-ChaseTests
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import XCTest
@testable import _9900414_MohammadsadiqShaikh_Chase

class CommonUtilityTests: XCTestCase {
    func testGetTime() {
        //Given
        let timeStamp = 1631503200

        // When
        let timeString = CommonUtility.getTime(timeStamp: timeStamp)

        // Then
        XCTAssertNotNil(timeString)
        XCTAssertEqual(timeString, "08:50 AM")
    }

    func testGetDayOfWeekNotEmpty() {

        // Given
        let dayOfWeek = CommonUtility.getDayOfWeek()

        // Then
        XCTAssertFalse(dayOfWeek.isEmpty)

    }
}
