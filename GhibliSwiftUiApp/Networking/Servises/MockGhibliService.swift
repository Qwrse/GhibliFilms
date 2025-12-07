//
//  MockGhibliService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

struct MockGhibliService: GhibliService {
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
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
    
    func fetchFilms() throws -> [Film] {
        let sampleData = try loadSampleData()
        return sampleData.films
    }
    
    func fetchPerson(from URLString: String) throws -> Person {
        let data = try loadSampleData()
        return data.people.first!
    }
    
    func searchFilms(for searchTerm: String) async throws -> [Film] {
        return []
    }
    
    // MARK: for preview and testing only
    
    func fetchFilm() -> Film {
        let data = try! loadSampleData()
        return data.films.first!
    }
}
