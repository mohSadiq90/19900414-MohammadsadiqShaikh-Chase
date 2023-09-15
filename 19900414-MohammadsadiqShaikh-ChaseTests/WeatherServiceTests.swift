//
//  WeatherServiceTests.swift
//  19900414-MohammadsadiqShaikh-ChaseTests
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import XCTest
import Combine
@testable import _9900414_MohammadsadiqShaikh_Chase

struct MockWebservice: WeatherServiceProtocol {
    var isSuccess = true
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, WeatherError>  {
        let model: WeatherResponse = .mock
        if isSuccess {
            return Just(model)
                .setFailureType(to: WeatherError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail<WeatherResponse, WeatherError>(error: WeatherError.invalidURL)
                .eraseToAnyPublisher()
        }
    }
}

class WeatherServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var mock: MockWebservice!
    
    override func setUp() {
        super.setUp()
 
        mock = MockWebservice()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchWeatherSuccess() {
        let expectation = XCTestExpectation(description: "Weather success")
        mock.isSuccess = true
        mock.fetchWeather(for: "city")
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Failed")
                case .finished:
                    break
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.name, "Pune")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchWeatherFailure() {
        let expectation = XCTestExpectation(description: "Weather failure")
        
        mock.isSuccess = false
        
        mock.fetchWeather(for: "city")
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    expectation.fulfill()
                case .finished:
                    XCTFail("failure")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
