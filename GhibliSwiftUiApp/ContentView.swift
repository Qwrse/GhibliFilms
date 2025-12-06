//
//  ContentView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 03/12/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen()
            }
            Tab("Favorites", systemImage: "heart") {
                FavouritesScreen()
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
