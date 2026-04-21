//
//  FavoritesScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

/// Displays the user's favorited films.
struct FavoritesScreen: View {
    /// Provides the full film list used to derive favorites.
    let filmsViewModel: FilmsViewModel
    /// Provides favorite state for films.
    let favoritesViewModel: FavoritesViewModel

    /// The subset of films that are currently favorited.
    var favoriteFilms: [Film] {
        guard case let .loaded(allFilms) = filmsViewModel.state else {
            return []
        }
        return allFilms.filter {
            favoritesViewModel.isFavorite(filmID: $0.id)
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Group {
                if favoriteFilms.isEmpty {
                    ContentUnavailableView("No favorites yet", systemImage: "heart")
                } else {
                    FilmListView(films: favoriteFilms, favoritesViewModel: favoritesViewModel)
                }
            }
                .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(filmsViewModel: FilmsViewModel(service: MockGhibliService()),
                    favoritesViewModel: FavoritesViewModel())
}
