//
//  FetchRecipeApp.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import SwiftUI

@main
struct FetchRecipeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: RecipeListViewModel())
        }
    }
}
