//
//  WeatherService.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, WeatherError>
}

struct WeatherAPIService: WeatherServiceProtocol {
    private let apiKey = "ddeffd422cb0718514e9f6a89ef38291"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, WeatherError> {
        let urlString = "\(baseURL)q=\(city)&appid=\(apiKey)&units=metric"
        guard let encoded = urlString.urlEncode(), let url = URL(string: encoded) else {
            return Fail(error: WeatherError.invalidURL).eraseToAnyPublisher()
        }
        
        /// Save users search location
        UserDefaults.standard.set(city, forKey: "lastSearchedCity")
        
        return session.dataTaskPublisher(for: url)
            .mapError { error in
                WeatherError.networkError(error)
            }
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw WeatherError.networkError(URLError(.badServerResponse))
                }
                
                return data
            }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .mapError { error in
                WeatherError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
}

/// Our custom error enum
enum WeatherError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
}
