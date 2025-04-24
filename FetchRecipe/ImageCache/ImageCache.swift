//
//  ImageCache.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/23/25.
//

import SwiftUI

/// An error that represents failures that can occur during image loading or decoding.
enum ImageError: Error {
    case invalidData
    case networkError
}

/// In-memory image cache using `NSCache` for temporary storage of images.
class ImageCache {
    /// Singleton instance of `ImageCache`
    static let shared = ImageCache()
    
    /// Cache storage
    internal let cache = NSCache<NSURL, UIImage>()

    /// Asynchronously loads an image from the given URL.
    ///
    /// If the image is already cached, the cached version is returned.
    /// Otherwise, the image is downloaded and stored in the cache before returning the `Image`.
    ///
    /// - Parameter url: The URL of the image to retrieve.
    /// - Returns: An `Image`.
    /// - Throws:
    ///     - `ImageError.invalidData` if the image data could not be decoded, or
    ///     - `ImageError.networkError` if any network-related error is thrown by `URLSession`.
    func image(for url: URL) async throws -> Image {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return Image(uiImage: cachedImage)
        }

        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw ImageError.networkError
        }
        
        guard let uiImage = UIImage(data: data) else {
            throw ImageError.invalidData
        }

        cache.setObject(uiImage, forKey: url as NSURL)
        return Image(uiImage: uiImage)
    }
}
