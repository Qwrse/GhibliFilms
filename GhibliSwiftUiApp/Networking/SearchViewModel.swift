//
//  SearchViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

/// Manages film search results.
@Observable
class SearchViewModel {
    /// The current loading state for search results.
    var state: LoadingState<[Film]> = .idle

    /// Provides film data for searching.
    @ObservationIgnored
    private let service: GhibliService
    /// Stores the most recent query.
    @ObservationIgnored
    private var lastQuery = ""
    
    /// Creates a search view model.
    ///
    /// - Parameter service: The service used to search films.
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    /// Searches films that match the provided query.
    ///
    /// - Parameter query: The query string to match.
    func searchFilms(matching query: String) async {
        guard !query.isEmpty else {
            if case .loaded = state {
            } else {
                state = .idle
            }
            return
        }
        state = .loading
        lastQuery = query
        do {
            let films = try await service.searchFilms(matching: query)
            state = .loaded(films)
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            state = .error("Unknown error")
        }
    }
}
