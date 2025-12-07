//
//  FilmDetailScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    @State var vm = FilmDetailViewModel()
    let favoritesViewModel: FavoritesViewModel
    
    private struct Info: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        
        init(_ title: String, _ description: String) {
            self.title = title
            self.description = description
        }
    }
    
    var body: some View {
        ScrollView {
            FilmImageView(urlPath: film.bannerImage)
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
                        Text("\(film.duration) minutes")
                    }
                    GridRow {
                        Text("Score").bold()
                        Text("\(film.score)/100")
                    }
                    
                }
                
                Divider()
                
                Text("Description").font(.title3).bold()
                    .padding(.bottom, 5)
                Text(film.description)
                
                switch vm.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView() {
                        Text("Loading...")
                    }
                case .loaded(let people):
                    ForEach(people) { person in
                        Text(person.name)
                    }
                case .error(let message):
                    Text(message).foregroundStyle(Color.pink)
                }
            }
            .padding()
        }
        .toolbar {
            FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
        }
        .task {
            await vm.fetch(for: film)
        }
    }
}

#Preview {
    let films = try! MockGhibliService().fetchFilms()
    FilmDetailScreen(film: films[1], favoritesViewModel: FavoritesViewModel())
}
