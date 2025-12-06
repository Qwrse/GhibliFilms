//
//  FilmsScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct FilmsScreen: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error)
                        .foregroundColor(.pink)
                }
            }
                .navigationTitle("Ghibli Movies")
        }
    }
}

#Preview {
    FilmsScreen(filmsViewModel: FilmsViewModel(service: MockGhibliService()),
                favoritesViewModel: FavoritesViewModel())
}
