//
//  ImageLoader.swift
//  Filmi
//
//  Created by Harshil Patel on 8/11/23.
//

import SwiftUI

// Class responsible for Loading image from a URL, checking if image is present in cache, otherwise fetch from network.
struct ImageLoader {
    static let shared = ImageLoader()
    private init() {}

    func load(imageForKey key: String, withURL urlString: String) async -> UIImage? {
        // Check cache for image.
        if let cachedImage = ImageCache.shared.getImage(forKey: key) {
            return cachedImage
        } else {
            // If image not in cache, download it.
            guard let url = URL(string: urlString) else { return nil }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    // Store the downloaded image into the cache.
                    ImageCache.shared.setImage(image, forKey: key)
                    return image
                }
            } catch {
                // Error handling if image not found from URL. 
                print("Error loading image: \(error)")
            }
            return nil
        }
    }
}
