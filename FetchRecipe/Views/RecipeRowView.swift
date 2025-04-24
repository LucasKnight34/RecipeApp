//
//  RecipeRowView.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/22/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        NavigationLink {
            RecipeDetailView(recipe: recipe)
        } label : {
            HStack {
                RecipeImageView(recipe: recipe)

                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 2)
        }
    }
}

// - MARK: Previews

#Preview("Recipe Row View") {
    RecipeRowView(recipe: Recipe.mockRecipeBanana)
}

#Preview("Recipe Row View (Error)") {
    RecipeRowView(recipe: Recipe.mockRecipePhotoError)
}
