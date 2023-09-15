//
//  Weather.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import Foundation

struct WeatherResponse: Codable {
    struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }

    struct WeatherCondition: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct WeatherMain: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let sea_level: Int?
        let grnd_level: Int?
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }

    struct Clouds: Codable {
        let all: Int
    }

    struct System: Codable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }

    let coord: Coordinates
    let weather: [WeatherCondition]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: System
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

extension WeatherResponse: Error {
    static var mock: WeatherResponse {
        .init(
            coord: .init(lon: 3, lat: 3),
              weather: [],
              base: "",
              main: .init(temp: 3, feels_like: 3, temp_min: 4, temp_max: 4, pressure: 4, humidity: 4, sea_level: 4, grnd_level: 4),
              visibility: 4, wind: .init(speed: 4, deg: 4, gust: 4),
              clouds: .init(all: 4),
              dt: 4343, sys: .init(country: "in", sunrise: 43, sunset: 43),
              timezone: 34,
              id: 43,
              name: "Pune",
              cod: 43
        )
    }
}
