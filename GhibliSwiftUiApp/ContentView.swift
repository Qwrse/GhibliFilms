//
//  ContentView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 03/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var filmsViewModel = FilmsViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    @State private var searchViewModel = SearchViewModel()
    
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
            await filmsViewModel.fetch()
            favoritesViewModel.load()
        }
    }
}

#Preview {
    ContentView()
}
