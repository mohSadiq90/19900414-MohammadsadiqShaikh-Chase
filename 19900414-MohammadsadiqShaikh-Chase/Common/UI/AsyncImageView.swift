//
//  AsyncImageView.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL
    let placeholder: Image
    
    @State private var image: Image?
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
        } else {
            placeholder
                .resizable()
                .scaledToFit()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(url: url) {
            image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    ImageCache.shared.setImage(image: image, forURL: url)
                    self.image = image
                }
            }.resume()
        }
    }
}
