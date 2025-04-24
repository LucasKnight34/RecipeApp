//
//  RecipeListView.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeListViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                } else if let error = viewModel.error {
                    VStack {
                        Group {
                            error.errorImage
                                .font(.system(size: 100))
                            Text(error.errorHeadline)
                                .font(.headline)
                            Text(error.errorSubHeadline)
                                .font(.subheadline)
                        }
                        .foregroundStyle(.gray)
                    }
                } else {
                    List(viewModel.filteredRecipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                    .listStyle(.insetGrouped)
                    .searchable(text: $viewModel.searchText, prompt: "Search recipes")
                }
            }
            .navigationTitle("Dessert Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.loadRecipes) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .accessibilityLabel("Refresh Recipes")
                }
            }
        }
        .onAppear {
            viewModel.loadRecipes()
        }
    }
}

// - MARK: Previews

#Preview("Recipe List View") {
    RecipeListView(viewModel: RecipeListViewModel())
}

#Preview("Recipe List View (Slow Service)") {
    let vm = RecipeListViewModel(service: RecipeService(mode: .slowService))
    return RecipeListView(viewModel: vm)
}

#Preview("Recipe List View (Error)") {
    let vm = RecipeListViewModel(service: RecipeService(mode: .malformed))
    return RecipeListView(viewModel: vm)
}

#Preview("Recipe List View (Empty)") {
    let vm = RecipeListViewModel(service: RecipeService(mode: .empty))
    return RecipeListView(viewModel: vm)
}
