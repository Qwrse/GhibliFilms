//
//  FavoritesScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct FavoritesScreen: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var films: [Film] {
        return []
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No favorites yet", systemImage: "heart")
                } else {
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
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
