//
//  Person.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation
import Playgrounds

struct Person: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/people")!
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        try JSONDecoder().decode([Person].self, from: data)
    } catch {
        print(error)
    }
}
