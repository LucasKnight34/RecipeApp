//
//  RecipeService.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import SwiftUI

// MARK: - RecipeFetching Protocol

protocol RecipeFetching {
    func fetchRecipes() async throws -> [Recipe]
}

// MARK: - Service Error Definitions

enum RecipeServiceError: Error, LocalizedError {
    case emptyData
    case decodingError
    case networkError
    case unknown

    var errorImage: Image {
        switch self {
        case .emptyData: return Image(systemName: "book.closed")
        case .decodingError, .networkError, .unknown: return Image(systemName: "exclamationmark.triangle")
        }
    }
    
    var errorHeadline: String {
        switch self {
        case .emptyData: return "No recipes available."
        case .decodingError, .networkError, .unknown: return "Failed to load recipes."
        }
    }
    
    var errorSubHeadline: String {
        switch self {
        case .emptyData: return "Try refreshing or check back later."
        case .decodingError, .networkError, .unknown: return "Please check your connection or try again later."
        }
    }
}

// MARK: - RecipeServiceMode (used for mocking/testing)

enum RecipeServiceMode {
    case normal
    case empty
    case malformed
    case slowService
}

// MARK: - RecipeService Implementation

class RecipeService : RecipeFetching {
    static let shared = RecipeService()
    private let mode: RecipeServiceMode
    private let endpoint: URL
    
    /// Initializes the service with a given mode. Useful for previewing different service errors.
    init(mode: RecipeServiceMode = .normal) {
        self.mode = mode
        switch mode {
        case .normal, .slowService:
            self.endpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        case .empty:
            self.endpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        case .malformed:
            self.endpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
            
        }
    }

    private struct RecipeList: Decodable {
        let recipes: [Recipe]
    }

    /// Asynchronously fetches a list of recipes from the remote API based on the configured `RecipeServiceMode`.
    ///
    /// This method performs a network request to retrieve JSON data and decodes it into an array of `Recipe` models.
    /// Depending on the service mode, it can simulate normal, slow, empty, or malformed responses for testing and previews.
    ///
    /// - Returns: An array of decoded `Recipe` objects.
    /// - Throws:
    ///   - `RecipeServiceError.decodingError` if the JSON is malformed or missing the expected structure.
    ///   - `RecipeServiceError.emptyData` if the response is valid but contains no recipes.
    ///   - `RecipeServiceError.networkError` for any network-related error thrown by `URLSession`.
    ///
    /// - Note: If `mode == .slowService`, a 5-second artificial delay is introduced to simulate a slow API response.
    func fetchRecipes() async throws -> [Recipe] {
        guard let (data, _) = try? await URLSession.shared.data(from: endpoint) else {
            throw RecipeServiceError.networkError
        }
        
        guard let jsonObject = try? JSONDecoder().decode([String: [Recipe]].self, from: data),
              let recipes = jsonObject["recipes"] else {
            throw RecipeServiceError.decodingError
        }
        
        if recipes.isEmpty {
            throw RecipeServiceError.emptyData
        }
        
        if mode == .slowService {
            try await Task.sleep(nanoseconds: UInt64(5 * Double(NSEC_PER_SEC)))
        }
        
        return recipes
    }
}
