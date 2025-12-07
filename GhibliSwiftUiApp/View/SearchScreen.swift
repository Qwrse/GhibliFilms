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
                    Text("Show search here")
                case .loading:
                    ProgressView()
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error).foregroundStyle(Color.pink)
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
