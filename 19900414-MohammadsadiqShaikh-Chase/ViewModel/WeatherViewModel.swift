//
//  WeatherViewModel.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation

/// Protocol for Weather ViewModel
protocol WeatherViewModelProtocol {
    /// Fetch weather API
    /// - Parameter city: city string
    func fetchWeather(for city: String)
    
    /// On view appear event
    func onAppear()
}

class WeatherViewModel: WeatherViewModelProtocol, ObservableObject {
    private let weatherService: WeatherServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    private var locationManager = CLLocationManager()

    @State private var lastSearchedCity: String? = UserDefaults.standard.string(forKey: "lastSearchedCity")
    @Published private var locationManagerDelegate = LocationManagerDelegate()
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var isError = false
    @Published var errorMessage: String? = ""
    
    @Published private(set) var weatheruiModel: WeatherUIModel?
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(for city: String) {
        isLoading = true
        isError = false
        
        weatherService.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .map({ response in
                WeatherUIModel(weather: response)
            })
            .sink(receiveCompletion: { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    self?.isError = true
                    self?.errorMessage = .internalServerError
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (response: WeatherUIModel) in
                self?.isLoading = false
                self?.weatheruiModel = response
            })
            .store(in: &cancellables)
    }
    
    func onAppear() {
        if let lastSearchedCity {
            fetchWeather(for: lastSearchedCity)
        } else {
            locationManager.delegate = locationManagerDelegate
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManagerDelegate.$lastSearchedCity
                .sink { location in
                    if let city = location {
                        self.fetchWeather(for: city)
                    }
                }
                .store(in: &cancellables)
        }
    }
}

#if DEBUG
extension WeatherViewModel {
    var test: Test {
        .init(target: self)
    }
    
    struct Test {
        var target: WeatherViewModel
        var locationManagetDelegate: LocationManagerDelegate {
            target.locationManagerDelegate
        }
    }
}

#endif
