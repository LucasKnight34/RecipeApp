//
//  RecipeListViewModelTests.swift
//  FetchRecipeTests
//
//  Created by Lucas Knight on 4/24/25.
//

import XCTest
@testable import FetchRecipe

final class RecipeListViewModelTests: XCTestCase {
        
    class MockRecipeService: RecipeFetching {
        var shouldReturnError: RecipeServiceError?
        var mockRecipes: [Recipe] = []

        func fetchRecipes() async throws -> [Recipe] {
            if let error = shouldReturnError {
                throw error
            }
            return mockRecipes
        }
    }
    
    var viewModel: RecipeListViewModel!
    var mockService: MockRecipeService!

    @MainActor override func setUp() {
        mockService = MockRecipeService()
        viewModel = RecipeListViewModel(service: mockService)
    }
    
    // MARK: - Test Load Recipes Success
    
    func testLoadRecipesSuccess() async {
        let expectedRecipes = [Recipe.mockRecipeBanana]
        mockService.mockRecipes = expectedRecipes
        
        Task {
            await viewModel.loadRecipes()
            
            await MainActor.run {
                XCTAssertEqual(viewModel.recipes, expectedRecipes, "Recipes should match.")
                XCTAssertNil(viewModel.error, "Error should be nil on success.")
                XCTAssertFalse(viewModel.isLoading, "Loading should be false after loading is complete.")
            }
        }
    }
    
    // MARK: - Test Load Recipes Decoding Error
    
    func testLoadRecipesDecodingError() async {
        mockService.shouldReturnError = .decodingError
        
        Task {
            await viewModel.loadRecipes()
            
            await MainActor.run {
                XCTAssertNil(viewModel.recipes, "Recipes should be nil.")
                XCTAssertEqual(viewModel.error, RecipeServiceError.decodingError, "Errors should match.")
                XCTAssertFalse(viewModel.isLoading, "Loading should be false after loading is complete.")
            }
        }
    }
    
    // MARK: - Test Load Recipes Empty Data
    
    func testLoadRecipesEmptyData() async {
        mockService.shouldReturnError = .emptyData
        
        Task {
            await viewModel.loadRecipes()
            
            await MainActor.run {
                XCTAssertNil(viewModel.recipes, "Recipes should be nil.")
                XCTAssertEqual(viewModel.error, RecipeServiceError.emptyData, "Errors should match.")
                XCTAssertFalse(viewModel.isLoading, "Loading should be false after loading is complete.")
            }
        }
    }
    
    // MARK: - Test Load Recipes Unkown Error
    
    func testLoadRecipesUnkown() async {
        mockService.shouldReturnError = .unknown
        
        Task {
            await viewModel.loadRecipes()
            
            await MainActor.run {
                XCTAssertNil(viewModel.recipes, "Recipes should be nil.")
                XCTAssertEqual(viewModel.error, RecipeServiceError.unknown, "Errors should match.")
                XCTAssertFalse(viewModel.isLoading, "Loading should be false after loading is complete.")
            }
        }
    }

    
    // MARK: - Test Search Filter
    
    func testSearchFilter() async {
        Task {
            await MainActor.run {
                viewModel.recipes = [Recipe.mockRecipeBanana, Recipe.mockRecipeApam]
                viewModel.searchText = "Banana"
                
                let searchFilter = viewModel.filteredRecipes
                
                XCTAssertEqual(searchFilter.count, 1, "Filtered recipes count should be 1.")
                XCTAssertEqual(searchFilter.first?.name, "Banana", "Filtered recipe should match the search text.")
            }
        }
    }
}
