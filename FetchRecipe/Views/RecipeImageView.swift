//
//  RecipeImageView.swift
//  FetchRecipe
//
//  Created by Lucas Knight on 4/24/25.
//

import SwiftUI

// - MARK: Image extension for consistent image modifiers

extension Image {
    
    func imageSmallModifier() -> some View {
        self
            .resizable()
            .frame(width: 80, height: 80)
            .cornerRadius(12)
    }
    
    func imageLargeModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct RecipeImageView: View {
    @State private var image: Image? = nil
    let recipe: Recipe
    let loadLargeImage: Bool
    
    init(recipe: Recipe, loadLargeImage: Bool = false) {
        self.recipe = recipe
        self.loadLargeImage = loadLargeImage
    }
    
    var body: some View {
        VStack {
            if let imageView = image {
                    if loadLargeImage {
                        imageView
                            .imageLargeModifier()
                            .accessibilityLabel(Text(recipe.name))
                    } else {
                        imageView
                            .imageSmallModifier()
                            .accessibilityLabel(Text(recipe.name))
                    }
            } else {
                Group {
                    if loadLargeImage {
                        Image(systemName: "photo")
                            .imageLargeModifier()
                    } else {
                        Image(systemName: "photo")
                            .imageSmallModifier()
                    }
                }
                .accessibilityHidden(true)
                .foregroundStyle(.gray)
            }
        }
        .onAppear {
            Task {
                do {
                    let recipeImage = loadLargeImage ? recipe.photoURLLarge : recipe.photoURLSmall
                    self.image = try await ImageCache.shared.image(for: recipeImage)
                } catch {
                    print("Image loading error: \(error)")
                }
            }
        }
    }
}

// - MARK: Previews

#Preview("Recipe Image View") {
    VStack {
        RecipeImageView(recipe: Recipe.mockRecipeApam)
        RecipeImageView(recipe: Recipe.mockRecipeApam, loadLargeImage: true)
        RecipeImageView(recipe: Recipe.mockRecipePhotoError)
        RecipeImageView(recipe: Recipe.mockRecipePhotoError, loadLargeImage: true)
    }
}
