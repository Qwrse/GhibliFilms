//
//  FilmImageView.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import SwiftUI

/// Displays a local film image derived from a remote image URL string.
struct FilmImageView: View {
    /// The remote image URL string used to derive the bundled asset name.
    var imageURLString: String
    
    // MARK: - Body
    var body: some View {
        let imageName = imageURLString.split(separator: "/").last?
            .split(separator: ".").first
        
        Image(String(imageName ?? "filmPlaceholder"))
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal)
    }
}

#Preview {
    FilmImageView(imageURLString: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
        .frame(maxHeight: 300)
}
