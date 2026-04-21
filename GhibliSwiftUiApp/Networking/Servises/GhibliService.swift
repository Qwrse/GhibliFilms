//
//  GhibliService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

/// Defines the operations required to load Studio Ghibli data.
protocol GhibliService: Sendable {
    /// Fetches all available films.
    ///
    /// - Returns: An array of films.
    func fetchFilms() async throws -> [Film]
    
    /// Fetches a person from the provided endpoint URL string.
    ///
    /// - Parameter urlString: The endpoint URL string for the person.
    /// - Returns: The matching person.
    func fetchPerson(from urlString: String) async throws -> Person
    
    /// Searches films that match the provided query.
    ///
    /// - Parameter query: The query string to match.
    /// - Returns: The films whose titles match the query.
    func searchFilms(matching query: String) async throws -> [Film]
}
