//
//  Film.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

/// Represents a Studio Ghibli film returned by the API.
struct Film: Codable, Identifiable, Equatable, Hashable {
    /// The unique identifier for the film.
    let id: String
    /// The localized title of the film.
    let title: String
    /// A short synopsis of the film.
    let synopsis: String
    /// The film producer.
    let producer: String
    /// The film director.
    let director: String
    
    /// The film release year.
    let releaseYear: String
    /// The Rotten Tomatoes score for the film.
    let rottenTomatoesScore: String
    /// The running time of the film, in minutes.
    let runningTime: String

    /// The poster image URL string for the film.
    let posterImageURL: String
    /// The banner image URL string for the film.
    let bannerImageURL: String
    /// The related people endpoint URL strings.
    let peopleURLs: [String]

    /// Maps API field names to `Film` property names.
    enum CodingKeys: String, CodingKey {
        /// The film identifier.
        case id
        /// The film title.
        case title
        /// The poster image URL string.
        case posterImageURL = "image"
        /// The film synopsis.
        case synopsis = "description"
        /// The director name.
        case director
        /// The producer name.
        case producer
        /// The related people URL strings.
        case peopleURLs = "people"
        
        /// The banner image URL string.
        case bannerImageURL = "movie_banner"
        /// The release year.
        case releaseYear = "release_date"
        /// The running time in minutes.
        case runningTime = "running_time"
        /// The Rotten Tomatoes score.
        case rottenTomatoesScore = "rt_score"
    }
    
    // MARK: - only for testing

    /// Returns sample film data for previews and tests.
    static var sample: Film {
        MockGhibliService().sampleFilm()
    }
}

import Playgrounds

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        print(try JSONDecoder().decode([Film].self, from: data))
    } catch {
        print(error)
    }
}
