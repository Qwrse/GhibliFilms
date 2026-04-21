//
//  FilmsViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation


/// Manages the loading state for the film list.
@Observable
final class FilmsViewModel {
    /// The current loading state for the film list.
    var state: LoadingState<[Film]> = .idle
    /// Provides film data.
    private let service: GhibliService
    
    /// Creates a films view model.
    ///
    /// - Parameter service: The service used to fetch films.
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    /// Loads the list of films.
    func loadFilms() async {
        guard !state.isLoading else { return }
        state = .loading
        do {
            let films = try await service.fetchFilms()
            state = .loaded(films)
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            state = .error("Unknown error")
        }
    }
}
