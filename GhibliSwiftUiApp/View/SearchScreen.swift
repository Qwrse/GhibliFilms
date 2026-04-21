//
//  SearchScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

/// Displays film search results.
struct SearchScreen: View {
    /// The view model used to search films.
    let searchViewModel: SearchViewModel
    /// The favorites view model used to update favorite state.
    let favoritesViewModel: FavoritesViewModel
    /// The current search text.
    @State private var searchText: String = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                case .idle:
                    ContentUnavailableView("Show search here", systemImage: "magnifyingglass")
                case .loading:
                    ProgressView()
                case .loaded(let films):
                    if films.isEmpty {
                        ContentUnavailableView("No films found", systemImage: "questionmark.circle")
                    } else {
                        FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                    }
                case .error(_):
                    ContentUnavailableView("Something went wrong, try again", systemImage: "xmark.circle")
                }
            }
        }
        .searchable(text: $searchText)
        .task(id: searchText) {
            if let _ = try? await Task.sleep(for: .milliseconds(500)) {
                print("searchViewModel.searchFilms for: \(searchText)")
                await searchViewModel.searchFilms(matching: searchText)
            } else {
                print("Cancellation error")
            }
        }
    }
}

#Preview {
    SearchScreen(searchViewModel: SearchViewModel(), favoritesViewModel: FavoritesViewModel())
}
