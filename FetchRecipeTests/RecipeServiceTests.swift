//
//  RecipeServiceTests.swift
//  FetchRecipeTests
//
//  Created by Lucas Knight on 4/24/25.
//

import XCTest
@testable import FetchRecipe

final class RecipeServiceTests: XCTestCase {

    func testFetchRecipesNormalModeReturnsRecipes() async throws {
        let service = RecipeService(mode: .normal)
        let recipes = try await service.fetchRecipes()
        XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty in normal mode")
    }

    func testFetchRecipesEmptyModeThrowsEmptyDataError() async {
        let service = RecipeService(mode: .empty)

        do {
            _ = try await service.fetchRecipes()
            XCTFail("Expected to throw emptyData error")
        } catch let error as RecipeServiceError {
            XCTAssertEqual(error, .emptyData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchRecipesMalformedModeThrowsDecodingError() async {
        let service = RecipeService(mode: .malformed)

        do {
            _ = try await service.fetchRecipes()
            XCTFail("Expected to throw decodingError")
        } catch let error as RecipeServiceError {
            XCTAssertEqual(error, .decodingError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchRecipesSlowServiceDelaysResponse() async throws {
        let service = RecipeService(mode: .slowService)
        let start = Date()
        _ = try await service.fetchRecipes()
        let duration = Date().timeIntervalSince(start)
        XCTAssertTrue(duration >= 5, "Expected slowService to delay for at least 5 seconds")
    }
}
