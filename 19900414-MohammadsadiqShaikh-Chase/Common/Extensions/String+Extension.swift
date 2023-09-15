//
//  String+Extension.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 12/09/23.
//

import Foundation

extension String {
    static var loading = "Loading..."
    static var nodata = "No data"
    static var city = "City"
    static var search = "Search"
    static var weatherDetails = "Weather details"
    static var pleaseTryAgain = "Please try again."
    static var internalServerError = "Internal server error"
    
    
    static var feels = "Feels like"
    static var humidity = "Humidity"
    static var pressure = "Pressure"
    static var wind = "Wind speed"
    static var sunrise = "Sunrise"
    static var sunset = "Sunset"
    static var visibility = "Visibility"
}

extension String {
    static var imgURL = "https://openweathermap.org/img/wn/"
    
    /// Encode Url for city with space e.g New York
    /// - Returns: encoded url
    func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
