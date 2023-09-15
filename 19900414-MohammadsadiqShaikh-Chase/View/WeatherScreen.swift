//
//  WeatherScreen.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import SwiftUI

struct WeatherScreen: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @State private var orientation = UIInterfaceOrientation.unknown

    var body: some View {
        GeometryReader { proxy in
           
            NavigationStack {
                ZStack {
                    Color("bg")
                     .edgesIgnoringSafeArea(.all)
                    ScrollView(.vertical) {
                        SearchView(viewModel: viewModel)
                        if viewModel.isLoading {
                            ProgressView(String.loading)
                        } else if viewModel.isError {
                            ErrorView(
                                errorMessage: viewModel.errorMessage ?? "",
                                proxy: proxy
                            )
                        } else if let uiModel = viewModel.weatheruiModel {
                            WeatherMainView(
                                proxy: proxy,
                                viewModel: viewModel,
                                weatherUIModel: uiModel,
                                orientation: orientation
                            )
                        } else {
                            ErrorView(
                                errorMessage: .nodata,
                                proxy: proxy
                            )
                        }
                    }
                    .padding(.horizontal, .space16)
                    .onAppear() {
                        viewModel.onAppear()
                    }.onRotate { newOrientation in
                        orientation = newOrientation
                    }
                }
            }
        }
    }
}

struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen(viewModel: WeatherViewModel(weatherService: WeatherAPIService()))
    }
}
