//
//  ImageCache.swift
//  RickAndMorty
//
//  Created by Kirill on 21.08.2023.
//

import UIKit



class ImageCache {
    static let shared = ImageCache(); private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(url: URL?) -> UIImage? {
        guard let safeUrl = url else { return nil }
        let key = NSString(string: safeUrl.description)
        if let image = self.cache.object(forKey: key) {
            return image
        }
        return nil
    }
    
    func saveImage(url: URL?, image: UIImage) -> Void {
        guard let safeUrl = url else { return }
        let key = NSString(string: safeUrl.description)
        self.cache.setObject(image, forKey: key)
    }
}
