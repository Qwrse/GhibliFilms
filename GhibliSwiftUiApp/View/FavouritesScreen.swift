//
//  FavouritesScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct FavouritesScreen: View {
    let filmsViewModel: FilmsViewModel

    var films: [Film] {
        return []
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No favourites yet", systemImage: "heart")
                } else {
                    FilmListView(films: films)
                }
            }
                .navigationTitle("Favourites")
        }
    }
}

#Preview {
    FavouritesScreen(filmsViewModel: FilmsViewModel(service: MockGhibliService()))
}
