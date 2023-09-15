//
//  _9900414_MohammadsadiqShaikh_ChaseApp.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import SwiftUI

@main
struct _9900414_MohammadsadiqShaikh_ChaseApp: App {
    @StateObject var viewModel = WeatherViewModel(weatherService: WeatherAPIService())
    
    var body: some Scene {
        WindowGroup {
            WeatherScreen(viewModel: viewModel)
        }
    }
}
