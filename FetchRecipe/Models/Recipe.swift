//
//  Recipe.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import Foundation

// MARK: - Recipe Model

struct Recipe: Identifiable, Decodable, Equatable {
    let id: String
    let name: String
    let cuisine: String
    let photoURLSmall: URL
    let photoURLLarge: URL
    let sourceURL: URL?
    let youtubeURL: URL?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "name"
        case cuisine = "cuisine"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

// MARK: - Mock Data for Previews

/// - Note: Data taken directly from (https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json)
extension Recipe {
    static let mockRecipeApam = Recipe(
        id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        name: "Apam Balik",
        cuisine: "Malaysian",
        photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!,
        photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")!,
        sourceURL: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
        youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    )
    
    static let mockRecipeBanana = Recipe(
        id: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
        name: "Banana Pancakes",
        cuisine: "American",
        photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")!,
        photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg")!,
        sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
        youtubeURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
    )
    
    static let mockRecipePhotoError = Recipe(
        id: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
        name: "Banana Pancakes",
        cuisine: "American",
        photoURLSmall: URL(string: "not valid")!,
        photoURLLarge: URL(string: "not valid")!,
        sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
        youtubeURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
    )
    
    static let mockRecipeList: [Recipe] = [
        mockRecipeApam,
        mockRecipeBanana
    ]
}
