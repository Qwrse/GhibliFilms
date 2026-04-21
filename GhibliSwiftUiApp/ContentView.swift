//
//  ContentView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 03/12/2025.
//

import SwiftUI

/// Hosts the main tab interface for the app.
struct ContentView: View {
    /// Provides film data to the movies and favorites tabs.
    @State private var filmsViewModel = FilmsViewModel()
    /// Tracks the user's saved favorites.
    @State private var favoritesViewModel = FavoritesViewModel()
    /// Manages film search results.
    @State private var searchViewModel = SearchViewModel()
    
    /// Displays the app tabs and performs initial data loading.
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen(favoritesViewModel: favoritesViewModel)
            }
            Tab(role: .search) {
                SearchScreen(searchViewModel: searchViewModel, favoritesViewModel: favoritesViewModel)
            }
        }
        .task {
            await filmsViewModel.loadFilms()
            favoritesViewModel.loadFavorites()
        }
    }
}

#Preview {
    ContentView()
}
