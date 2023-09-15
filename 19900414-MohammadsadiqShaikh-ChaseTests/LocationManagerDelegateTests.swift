//
//  LocationManagerDelegateTests.swift
//  19900414-MohammadsadiqShaikh-ChaseTests
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import XCTest
import CoreLocation
import Combine
@testable import _9900414_MohammadsadiqShaikh_Chase
import Intents
import Contacts

class MockGeocoder: CLGeocoderProtocol {
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
        
        // Mock the placemark with locality
        let placeLocation = CLLocation(latitude: 0, longitude: 0)
        let postalAddress = CNMutablePostalAddress()
        postalAddress.city = "Test location"
        let placemark = CLPlacemark(
            location: placeLocation,
            name: "",
            postalAddress: postalAddress.copy() as? CNPostalAddress
        )
        completionHandler([placemark], nil)
    }
}

class LocationManagerDelegateTests: XCTestCase {
    var locationManagerDelegate: LocationManagerDelegate!
    var cancellables: Set<AnyCancellable> = []
    var mock = MockGeocoder()

    override func setUp() {
        super.setUp()
        locationManagerDelegate = LocationManagerDelegate(geocoder: mock)
    }

    override func tearDown() {
        locationManagerDelegate = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testUpdateCity() {
        
        // Given
        let expectation = XCTestExpectation(description: "Get Location")

        let cityPublisher = locationManagerDelegate.$lastSearchedCity
            .dropFirst()

        cityPublisher
            .sink { city in
                // Then
                XCTAssertEqual(city, "Test location")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        let location = CLLocation(latitude: 18.5204, longitude: 73.8567)
        locationManagerDelegate.locationManager(CLLocationManager(), didUpdateLocations: [location])

        wait(for: [expectation], timeout: 1.0)
    }
}
