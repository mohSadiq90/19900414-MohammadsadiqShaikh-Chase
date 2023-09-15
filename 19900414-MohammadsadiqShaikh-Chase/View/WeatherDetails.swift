//
//  WeatherDetails.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import SwiftUI

struct WeatherDetails: View {
    var proxy: GeometryProxy
    var viewModel: WeatherUIModel
    @Environment(\.colorScheme) var colorScheme
    let orientation: UIInterfaceOrientation

    var gridItems: [GridItem] {
        if orientation.isLandscape {
            return Array(repeating: GridItem(), count: 3)
        } else {
            return Array(repeating: GridItem(), count: 2)
        }
    }
    
    var body: some View {
        Text(String.weatherDetails)
            .padding(.top, .space16)
        LazyVGrid(
            columns: gridItems,
            spacing: .space8
        ) {
            ForEach(viewModel.details, id: \.id) { model in
                VStack(alignment: .center) {
                    Image(systemName: model.icon)
                        .frame(width: .space50)
                        .padding(.space8)
                    Text(model.desc)
                    Text(model.unit)
                        .font(.sys26)
                        .fontWeight(SwiftUI.Font.Weight.bold)
                        .padding(.bottom , .space8)
                }
                .padding(.space16)
                .frame(
                    width: orientation.isLandscape ? (proxy.size.width - .space60) / 3 : (proxy.size.width - .space40) / 2 ,
                    height: orientation.isLandscape ? (proxy.size.width - .space60) / 3 * 0.8 : (proxy.size.width - .space40) / 2 * 0.8
                )
                .background(colorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(.space16)
            }
        }
    }
}
