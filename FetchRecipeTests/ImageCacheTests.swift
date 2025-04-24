//
//  ImageCacheTests.swift
//  FetchRecipeTests
//
//  Created by Lucas Knight on 4/24/25.
//

import XCTest
@testable import FetchRecipe
import SwiftUI

class ImageCacheTests: XCTestCase {

    var imageCache: ImageCache = ImageCache.shared
    
    // MARK: - Test Cache Fetch
    
    func testFetchImageFromCache() async {
        let url = URL(string: "fakeURLtoEnsureImageComesFromCache.com")!
        let cacheUIImage = UIImage(systemName: "star")!
        
        // Simulate adding an image to the cache
        imageCache.cache.setObject(cacheUIImage, forKey: url as NSURL)
        
        do {
            let fetchedImage = try await imageCache.image(for: url)
            
            XCTAssertNotNil(fetchedImage, "The image fetched from cache should not be nil.")
            XCTAssertEqual(fetchedImage, Image(uiImage: cacheUIImage), "The cached image should be the same as image used to cache at the start.")
        } catch {
            XCTFail("Fetching image from cache should not throw an error.")
        }
    }
    
    // MARK: - Test Image Fetch From Network
    
    func testFetchImageFromNetwork() async {
        let url = Recipe.mockRecipeBanana.photoURLSmall
        
        do {
            let fetchedImage = try await imageCache.image(for: url)
            
            XCTAssertNotNil(fetchedImage, "The image fetched from network should not be nil.")
        } catch {
            XCTFail("Fetching image from network should not throw an error.")
        }
    }
    
    // MARK: - Test Image Fetch with Network Error
    
    func testFetchImageWithNetworkError() async {
        let url = URL(string: "fakeURLtoEnsureImageFails")!
        
        do {
            let _ = try await imageCache.image(for: url)
            XCTFail("Fetching image should throw an error due to invalid data.")
        } catch ImageError.networkError {
            XCTAssertTrue(true, "An invalid data error should be thrown.")
        } catch {
            XCTFail("Expected ImageError.invalidData but received a different error.")
        }
    }

    // MARK: - Test Cache After Fetch
    
    func testCacheAfterFetch() async {
        let url = Recipe.mockRecipeBanana.photoURLSmall
        
        do {
            let fetchedImage = try await imageCache.image(for: url)
            
            // Check if the image was cached
            let cachedImage = imageCache.cache.object(forKey: url as NSURL)!
            XCTAssertNotNil(cachedImage, "The image should be cached after fetching from the network.")
            XCTAssertEqual(fetchedImage, Image(uiImage: cachedImage), "The cached image should match the fetched image.")
        } catch {
            XCTFail("Fetching image should not throw an error.")
        }
    }
}
