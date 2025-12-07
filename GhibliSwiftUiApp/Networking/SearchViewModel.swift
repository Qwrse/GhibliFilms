//
//  SearchViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

class SearchViewModel {
    var state: LoadingState<[Film]> = .idle
    private let service: GhibliService
    private var lastSearchTerm = ""
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(for searchTerm: String) async {
        guard !searchTerm.isEmpty else {
            state = .idle
            return
        }
        state = .loading
        lastSearchTerm = searchTerm
        do {
            let films = try await service.searchFilms(for: searchTerm)
            state = .loaded(films)
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "unknow error")
        } catch let error as CancellationError {
            state = .idle
        } catch {
            state = .error("unknow error")
        }
    }
}
