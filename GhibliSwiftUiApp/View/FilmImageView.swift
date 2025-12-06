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
    }
}

#Preview {
    FilmImageView(urlPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
        .frame(maxHeight: 300)
}
