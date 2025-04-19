//
//  ImageCache.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation
import SwiftUI

final class ImageCache {
    static let shared = ImageCache()

    private var imageCache: NSCache<NSString, AnyObject>

    private init() {
        self.imageCache = NSCache<NSString, AnyObject>()
    }

    func object(for key: String) -> Image? {
        guard let image = imageCache.object(forKey: NSString(string: key)) as? Image else {
            return nil
        }
        return image
    }

    func setObject(image: Image, for key: String) {
        imageCache.setObject(image as AnyObject, forKey: NSString(string: key))
    }
}
