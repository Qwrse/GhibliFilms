//
//  FilmListView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

/// Displays a navigable list of films.
struct FilmListView: View {
    /// The films to display.
    var films: [Film]
    /// The favorites view model used to update favorite state.
    let favoritesViewModel: FavoritesViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(films) { film in
                NavigationLink(value: film) {
                    FilmRow(film: film, favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationDestination(for: Film.self) { film in
                FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
            }
        }
    }
}

/// Displays a single film row inside the film list.
private struct FilmRow: View {
    /// The film shown by the row.
    let film: Film
    /// The favorites view model used to update favorite state.
    let favoritesViewModel: FavoritesViewModel
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(imageURLString: film.posterImageURL)
                .frame(width: 100, height: 150)
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .bold()
                    Spacer()
                    FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
                }
                .padding(.bottom, 5)
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Text("Released: \(film.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.top)
        }
    }
}
