//
//  RecipeListViewModel.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import SwiftUI

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var error: RecipeServiceError? = nil
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    private let service: RecipeFetching
    
    init(service: RecipeFetching = RecipeService(mode: .normal)) {
        self.service = service
    }

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.cuisine.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    /// Loads the list of recipes asynchronously from the `RecipeService`.
    ///
    /// This method updates the view model's `recipes` property with the fetched data,
    /// or sets the `error` property with a user-facing error message if something goes wrong.
    ///
    /// Errors handled include:
    /// - `decodingError`: If JSON decoding fails due to mismatched structure or types.
    /// - `invalidData`: If the decoded data is missing required elements or doesn't conform to expectations.
    /// - `emptyData`: If the fetched data is valid but contains no recipes.
    /// - Any other unexpected error.
    ///
    func loadRecipes() {
        isLoading = true
        error = nil

        Task {
            do {
                let fetched = try await service.fetchRecipes()
                self.recipes = fetched
                self.isLoading = false
            } catch RecipeServiceError.decodingError {
                self.error = RecipeServiceError.decodingError
                self.isLoading = false
            } catch RecipeServiceError.emptyData {
                self.error = RecipeServiceError.emptyData
                self.isLoading = false
            } catch {
                self.error = RecipeServiceError.unknown
                self.isLoading = false
            }
        }
    }
}
