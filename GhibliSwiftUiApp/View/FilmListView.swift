//
//  FilmListView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

struct FilmListView: View {
    var films: [Film]
    
    var body: some View {
        NavigationStack {
            List(films) { film in
                NavigationLink(value: film) {
                    HStack {
                        FilmImageView(urlPath: film.image)
                            .frame(width: 100, height: 150)
                        Text(film.title)
                    }
                }
            }
            .navigationDestination(for: Film.self) { film in
                FilmDetailScreen(film: film)
            }
        }
    }
}

//#Preview {
//    @State @Previewable var vm = FilmsViewModel(service: MockGhibliService())
//    
//    FilmListView(filmsViewModel: vm)
//}
