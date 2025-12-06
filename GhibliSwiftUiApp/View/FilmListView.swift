//
//  FilmListView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

struct FilmListView: View {
    var films: [Film]
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            List(films) { film in
                NavigationLink(value: film) {
                    FilmRaw(film: film, favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationDestination(for: Film.self) { film in
                FilmDetailScreen(film: film)
            }
        }
    }
}

private struct FilmRaw: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        return favoritesViewModel.isFavorite(filmID: film.id)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .bold()
                    Spacer()
                    Button {
                        favoritesViewModel.toggleFavorite(filmID: film.id)
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorite ? .pink : .gray)
                    }
                }
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
