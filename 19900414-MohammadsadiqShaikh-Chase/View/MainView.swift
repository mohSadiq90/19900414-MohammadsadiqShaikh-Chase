//
//  MainView.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import SwiftUI

struct WeatherMainView: View {
    let proxy: GeometryProxy
    let viewModel: WeatherViewModel
    let weatherUIModel: WeatherUIModel
    let orientation: UIInterfaceOrientation
    
    var body: some View {
        VStack(alignment: .leading) {
            WeatherTempratureView(
                proxy: proxy,
                viewModel: weatherUIModel,
                orientation: orientation
            )
            WeatherDetails(
                proxy: proxy,
                viewModel: weatherUIModel,
                orientation: orientation
            )
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(weatherUIModel.title)
    }
}
