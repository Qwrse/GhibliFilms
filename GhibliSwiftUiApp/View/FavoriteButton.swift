//
//  FavoriteButton.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct FavoriteButton: View {
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        return favoritesViewModel.isFavorite(filmID: filmID)
    }
    
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
