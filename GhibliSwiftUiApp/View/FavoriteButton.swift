//
//  FavoriteButton.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

/// Toggles the favorite state for a film.
struct FavoriteButton: View {
    /// The identifier of the film to update.
    let filmID: String
    /// The favorites view model used to read and update favorite state.
    let favoritesViewModel: FavoritesViewModel
    
    /// Indicates whether the current film is favorited.
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: filmID)
    }
    
    // MARK: - Body
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(filmID: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .pink : .gray)
        }
        .buttonStyle(.plain)
        .controlSize(.large)
    }
}
