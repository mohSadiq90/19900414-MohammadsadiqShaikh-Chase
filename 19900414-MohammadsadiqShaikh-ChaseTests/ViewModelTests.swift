//
//  ViewModelTests.swift
//  19900414-MohammadsadiqShaikh-ChaseTests
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import XCTest
import Combine
@testable import _9900414_MohammadsadiqShaikh_Chase

class MockWeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<_9900414_MohammadsadiqShaikh_Chase.WeatherResponse, _9900414_MohammadsadiqShaikh_Chase.WeatherError> {
        return Result.Publisher(fetchWeatherResult)
            .eraseToAnyPublisher()
    }
    
    var fetchWeatherResult: Result<WeatherResponse, WeatherError> = .success(.mock)
}

class WeatherViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        
        mockWeatherService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockWeatherService)
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchWeather() {
        let expectation = XCTestExpectation(description: "Weather api")
        
        mockWeatherService.fetchWeatherResult = .success(.mock)
        
        viewModel.$weatheruiModel.dropFirst()
            .sink { weatherUIModel in
                XCTAssertNotNil(weatherUIModel)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchWeather(for: "city")
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testOnAppear() {
        let expectation = XCTestExpectation(description: "OnAppear")
        
        viewModel.test.locationManagetDelegate.lastSearchedCity = "TestCity"
        
        viewModel.onAppear()
        
        viewModel.$weatheruiModel.dropFirst()
            .sink { weatherUIModel in
                XCTAssertNotNil(weatherUIModel)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}



