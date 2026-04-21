//
//  Person.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation
import Playgrounds

/// Represents a person associated with a film.
struct Person: Codable, Identifiable, Equatable {
    /// The unique identifier for the person.
    let id: String
    /// The display name of the person.
    let name: String
    /// The reported gender of the person.
    let gender: String
    /// The reported age of the person.
    let age: String
    /// The eye color of the person.
    let eyeColor: String
    /// The hair color of the person.
    let hairColor: String
    /// The related film endpoint URL strings.
    let filmURLs: [String]
    
    /// Maps API field names to `Person` property names.
    enum CodingKeys: String, CodingKey {
        /// The person identifier.
        case id
        /// The person name.
        case name
        /// The reported gender.
        case gender
        /// The reported age.
        case age
        /// The related film URL strings.
        case filmURLs = "films"
        /// The eye color.
        case eyeColor = "eye_color"
        /// The hair color.
        case hairColor = "hair_color"
    }
}

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/people")!
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        print(try JSONDecoder().decode([Person].self, from: data))
    } catch {
        print(error)
    }
}
