//
//  MockGhibliService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

/// Provides sample Studio Ghibli data for previews and tests.
struct MockGhibliService: GhibliService {
    /// Bundled sample payloads used by the mock service.
    private struct SampleData: Decodable {
        /// The sample films.
        let films: [Film]
        /// The sample people.
        let people: [Person]
    }
    
    /// Loads bundled sample data from the app bundle.
    ///
    /// - Returns: The decoded sample data.
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    /// Returns all sample films.
    ///
    /// - Returns: An array of sample films.
    func fetchFilms() throws -> [Film] {
        let sampleData = try loadSampleData()
        return sampleData.films
    }
    
    /// Returns a sample person for the requested URL string.
    ///
    /// - Parameter urlString: The person endpoint URL string.
    /// - Returns: A sample person.
    func fetchPerson(from urlString: String) throws -> Person {
        let data = try loadSampleData()
        return data.people.first!
    }
    
    /// Returns sample search results for the provided query.
    ///
    /// - Parameter query: The query string to match.
    /// - Returns: The matching sample films.
    func searchFilms(matching query: String) async throws -> [Film] {
        let prompt = query.lowercased()
        return try fetchFilms().filter { $0.title.lowercased().contains(prompt) }
    }
    
    // MARK: - for preview and testing only
    
    /// Returns a single sample film for previews and tests.
    func sampleFilm() -> Film {
        let data = try! loadSampleData()
        return data.films.first!
    }
}
