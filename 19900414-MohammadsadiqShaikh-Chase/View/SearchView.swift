//
//  SearchView.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            TextField(String.city, text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                viewModel.fetchWeather(for: viewModel.searchText)
            } label: {
                Text(String.search)
            }
            .foregroundColor(colorScheme == .dark ? .white: .black)
        }
    }
}
