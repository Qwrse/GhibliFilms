//
//  FilmsScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

/// Displays the main list of films.
struct FilmsScreen: View {
    /// The view model used to load films.
    let filmsViewModel: FilmsViewModel
    /// The favorites view model used to update favorite state.
    let favoritesViewModel: FavoritesViewModel

    // MARK: - Body
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
                case .error(let message):
                    Text(message)
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
