//
//  SearchScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct SearchScreen: View {
    let searchViewModel: SearchViewModel
    let favoritesViewModel: FavoritesViewModel
    @State private var text: String = ""
    
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
        .searchable(text: $text)
        .task(id: text) {
            if let _ = try? await Task.sleep(for: .milliseconds(500)) {
                print("searchViewMode.fetch for: \(text)")
                await searchViewModel.fetch(for: text)
            } else {
                print("Cantellation error")
            }
        }
    }
}

#Preview {
    SearchScreen(searchViewModel: SearchViewModel(), favoritesViewModel: FavoritesViewModel())
}
