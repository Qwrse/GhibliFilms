//
//  ContentView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 03/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel)
            }
            Tab("Favorites", systemImage: "heart") {
                FavouritesScreen(filmsViewModel: filmsViewModel)
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
