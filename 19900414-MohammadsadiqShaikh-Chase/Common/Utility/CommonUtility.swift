//
//  CommonUtility.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import Foundation

struct CommonUtility {
    static func getTime(timeStamp: Int) -> String {
        let interval = TimeInterval(timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"

        let date = Date(timeIntervalSince1970: interval)
        
        return dateFormatter.string(from: date)
    }
    
    static func getDayOfWeek() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        return dateFormatter.string(from: today)
    }
}
