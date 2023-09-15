//
//  WeatherUIModel.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import Foundation

struct WeatherUIModel {
    let title: String
    
    struct Details {
        let id = UUID()
        let icon: String
        let desc: String
        let unit: String
    }
    
    let temprature: String
    let weatherDescription: String
    let weatherSubtitle: String
    let weatherIcon: URL?
    
    var details: [Details]
}

extension WeatherUIModel {
    init(weather: WeatherResponse) {
        title = weather.name
        temprature = "\(Int(weather.main.temp))º"
        weatherDescription = weather.weather.first?.description ?? ""
        weatherSubtitle =
            """
            \(CommonUtility.getDayOfWeek()) \(Int(weather.main.temp_min))º / \(Int(weather.main.temp_max))º
            """
        weatherIcon = URL(string: .imgURL + (weather.weather.first?.icon ?? "") + "@2x.png")

        let sunriseTimeString = CommonUtility.getTime(timeStamp: weather.sys.sunrise)
        let sunsetTimeString = CommonUtility.getTime(timeStamp: weather.sys.sunrise)
        
        details = [
            .init(icon: "thermometer.medium", desc: .feels, unit: "\(weather.main.feels_like)º"),
            .init(icon: "humidity", desc: .humidity, unit: "\(weather.main.humidity)"),
            .init(icon: "barometer", desc: .pressure, unit: "\(weather.main.pressure) hPa"),
            .init(icon: "wind", desc: .wind, unit: "\(weather.wind.speed) m/hr"),
            .init(icon: "sunrise", desc: .sunrise, unit: sunriseTimeString),
            .init(icon: "sunset", desc: .sunset, unit: sunsetTimeString),
            .init(icon: "eye.circle", desc: .visibility, unit: "\(weather.visibility / 1000) KM"),
        ]
    }
}

extension WeatherUIModel {
    static var mock: WeatherUIModel {
        .init(
            title: "Pune",
            temprature: "34",
            weatherDescription: "Cloudy",
            weatherSubtitle: "32 / 34",
            weatherIcon: URL(string: ""),
            details: [.init(icon: "cloud", desc: "test", unit: "test")]
        )
    }
}
