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
    
    var body: some View {
        ScrollView {
            FilmImageView(urlPath: film.image)
                .containerRelativeFrame(.horizontal)
                .frame(minHeight: 200)

            VStack(alignment: .leading) {
                Text(film.title)
                    .font(.title3)
                Divider()
                
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
            .task {
                await vm.fetch(for: film)
            }
        }
    }
    
    
}

#Preview {
    let films = try! MockGhibliService().fetchFilms()
    FilmDetailScreen(film: films[1])
}
