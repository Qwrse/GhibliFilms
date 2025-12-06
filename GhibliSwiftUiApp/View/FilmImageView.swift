//
//  FilmImageView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

struct FilmImageView: View {
    var urlPath: String
    
    var body: some View {
        let name = urlPath.split(separator: "/").last?
            .split(separator: ".").first
        
        Image(String(name ?? "filmPlaceholder"))
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal)
        
        AsyncImage(url: URL(string: urlPath)) { phase in
            switch phase {
            case .empty:
                Color(white: 0.8).overlay {
                    ProgressView()
                        .controlSize(.large)
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                Image("filmPlaceholder")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                Image("filmPlaceholder")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    FilmImageView(urlPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
        .frame(maxHeight: 200)
    
}
