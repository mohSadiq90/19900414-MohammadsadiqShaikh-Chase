//
//  ImageCache.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 11/09/23.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()

    private var cache: [URL: Image] = [:]

    func getImage(url: URL) -> Image? {
        return cache[url]
    }

    func setImage(image: Image, forURL url: URL) {
        cache[url] = image
    }
}
