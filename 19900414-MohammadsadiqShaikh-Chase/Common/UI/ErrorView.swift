//
//  ErrorView.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let proxy: GeometryProxy

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            Text(errorMessage)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Text(String.pleaseTryAgain)
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
        .frame(height: proxy.size.width)
    }
}
