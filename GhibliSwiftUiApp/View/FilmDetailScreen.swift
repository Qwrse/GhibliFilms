//
//  FilmDetailScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

/// Displays detailed information for a selected film.
struct FilmDetailScreen: View {
    /// The film being displayed.
    let film: Film
    /// The view model used to load related people.
    @State var viewModel = FilmDetailViewModel()
    /// The favorites view model used to update favorite state.
    let favoritesViewModel: FavoritesViewModel
    
    /// Represents a label-value pair shown in the details grid.
    private struct Info: Identifiable {
        /// The unique identifier for the item.
        let id = UUID()
        /// The label displayed for the item.
        let title: String
        /// The value displayed for the item.
        let value: String
        
        /// Creates a detail item.
        ///
        /// - Parameters:
        ///   - title: The display title.
        ///   - value: The display value.
        init(_ title: String, _ value: String) {
            self.title = title
            self.value = value
        }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            FilmImageView(imageURLString: film.bannerImageURL)
                .containerRelativeFrame(.horizontal)
                .frame(minHeight: 200)
            
            VStack(alignment: .leading) {
                Text(film.title)
                    .font(.title).bold()
                    .padding(.bottom, 10)
                
                Grid(alignment: .leading) {
                    GridRow {
                        Text("Name").bold()
                        Text(film.title)
                    }
                    GridRow {
                        Text("Director").bold()
                        Text(film.director)
                    }
                    GridRow {
                        Text("Producer").bold()
                        Text(film.producer)
                    }
                    GridRow {
                        Text("Release Date").bold()
                        Text(film.releaseYear)
                    }
                    GridRow {
                        Text("Running Time").bold()
                        Text("\(film.runningTime) minutes")
                    }
                    GridRow {
                        Text("Score").bold()
                        Text("\(film.rottenTomatoesScore)/100")
                    }
                    
                }
                
                Divider()
                
                Text("Description").font(.title3).bold()
                    .padding(.bottom, 5)
                Text(film.synopsis)
                
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView() {
                        Text("Loading...")
                    }
                case .loaded(let people):
                    Divider()
                    Text("People").font(.title3).bold()
                        .padding(.bottom, 5)
                    ForEach(people) { person in
                        Text(person.name)
                    }
                case .error:
                    EmptyView()
                }
            }
            .padding()
        }
        .toolbar {
            FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
        }
        .task {
            await viewModel.loadPeople(for: film)
        }
    }
}

#Preview {
    let films = try! MockGhibliService().fetchFilms()
    FilmDetailScreen(film: films[0], favoritesViewModel: FavoritesViewModel())
}
