//
//  RecipeDetailView.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                RecipeImageView(recipe: recipe, loadLargeImage: true)

                Text(recipe.name)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .bold()

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let sourceURL = recipe.sourceURL {
                    Link("View Source Recipe", destination: sourceURL)
                        .font(.body)
                        .foregroundStyle(.blue)
                        .accessibilityLabel(Text("View the source recipe for \(recipe.name)"))
                }

                if let youtubeURL = recipe.youtubeURL {
                    Link("Watch on YouTube", destination: youtubeURL)
                        .font(.body)
                        .foregroundStyle(.red)
                        .accessibilityLabel(Text("Watch \(recipe.name) on YouTube"))
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
}

// - MARK: Previews

#Preview("Recipe Detail View") {
    RecipeDetailView(recipe: Recipe.mockRecipeApam)
}

#Preview("Recipe Detail View (Image Error)") {
    RecipeDetailView(recipe: Recipe.mockRecipePhotoError)
}
