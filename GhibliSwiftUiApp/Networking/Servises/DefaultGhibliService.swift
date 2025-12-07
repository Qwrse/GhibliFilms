//
//  DefGhibliService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

struct DefaultGhibliService: GhibliService {
    static var allFilms: [Film]? = nil
    
    private func fetch<T: Decodable>(url: String, type: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
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
    
    func fetchFilms() async throws -> [Film] {
        if let films = Self.allFilms {
            return films
        }
        let films = try await fetch(url: "https://ghibliapi.vercel.app/films", type: [Film].self)
        Self.allFilms = films
        return films
    }
    
    private func isValuePersonURL(_ string: String) -> Bool {
        let prefix = "https://ghibliapi.vercel.app/people/"
        return string.hasPrefix(prefix) && string.count > prefix.count
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        guard isValuePersonURL(URLString) else {
            throw APIError.invalidURL
        }
        return try await fetch(url: URLString, type: Person.self)
    }
    
    func searchFilms(for searchTerm: String) async throws -> [Film] {
        let films = try await fetchFilms()
        return films.filter { $0.title.localizedStandardContains(searchTerm) }
    }
}
