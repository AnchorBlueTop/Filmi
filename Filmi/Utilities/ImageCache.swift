//
//  ImageCache.swift
//  Filmi
//
//  Created by Harshil Patel on 8/11/23.
//

import SwiftUI

// Class Responsible for managing the cache of images. Downloaded images are strored in the cache. 
class ImageCache {
    
    // Singleton instance used throughout the app.
    static let shared = ImageCache()
    
    // Cache object where the images are stored. NSCache is a key-value pair collection.
    private var cache = NSCache<NSString, UIImage>()
    
    // Private initalizer
    private init() {}
    
    // Function for retreiving image. A key uniquely identifies an image.
    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
    
    // Function to save image into the cache with a key. Key is then used to retrieve the image. 
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
