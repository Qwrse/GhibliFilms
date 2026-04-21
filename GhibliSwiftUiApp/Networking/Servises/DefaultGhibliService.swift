//
//  DefGhibliService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

/// Fetches Studio Ghibli data from the live API.
struct DefaultGhibliService: GhibliService {
    /// A simple in-memory cache of all loaded films.
    static var allFilms: [Film]? = nil
    
    /// Fetches and decodes a value from the given endpoint.
    ///
    /// - Parameters:
    ///   - urlString: The endpoint URL string to request.
    ///   - type: The expected decoded type.
    /// - Returns: A decoded value of the requested type.
    private func fetch<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    /// Fetches all films, using cached results when available.
    func fetchFilms() async throws -> [Film] {
        if let films = Self.allFilms {
            return films
        }
        let films = try await fetch(from: "https://ghibliapi.vercel.app/films", as: [Film].self)
        Self.allFilms = films
        return films
    }
    
    /// Returns a Boolean value indicating whether the string is a valid person endpoint.
    ///
    /// - Parameter string: The URL string to validate.
    /// - Returns: `true` if the URL string points to a person endpoint; otherwise, `false`.
    private func isValidPersonURL(_ string: String) -> Bool {
        let prefix = "https://ghibliapi.vercel.app/people/"
        return string.hasPrefix(prefix) && string.count > prefix.count
    }
    
    /// Fetches a person from the given endpoint URL string.
    ///
    /// - Parameter urlString: The endpoint URL string for the person.
    /// - Returns: The decoded person.
    func fetchPerson(from urlString: String) async throws -> Person {
        guard isValidPersonURL(urlString) else {
            throw APIError.invalidURL
        }
        return try await fetch(from: urlString, as: Person.self)
    }
    
    /// Searches films whose titles match the provided query.
    ///
    /// - Parameter query: The query string to match.
    /// - Returns: The films whose titles match the query.
    func searchFilms(matching query: String) async throws -> [Film] {
        let films = try await fetchFilms()
        return films.filter { $0.title.localizedStandardContains(query) }
    }
}
