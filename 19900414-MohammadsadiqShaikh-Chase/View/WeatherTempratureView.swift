//
//  WeatherTempratureView.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import SwiftUI

struct WeatherTempratureView: View {
    var proxy: GeometryProxy
    var viewModel: WeatherUIModel
    let orientation: UIInterfaceOrientation
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(viewModel.temprature)
                .font(.sysLarge120)
            VStack {
                if let url = viewModel.weatherIcon {
                    AsyncImageView(
                        url: url,
                        placeholder: Image(systemName: "photo")
                    )
                        .frame(width: .space80, height: .space80)
                }
                Text(viewModel.weatherDescription)
                    .font(.sys22)
                    .padding(.bottom, .space20)
            }
        }
        .padding(.vertical, .space8)
        .padding(.top, orientation.isLandscape ? .space20 : proxy.size.width / 2.5)
        
        HStack {
            Text(viewModel.weatherSubtitle)
        }
    }
}


