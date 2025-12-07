//
//  SearchViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

@Observable
class SearchViewModel {
    var state: LoadingState<[Film]> = .idle

    @ObservationIgnored
    private let service: GhibliService
    @ObservationIgnored
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
        } catch {
            state = .error("unknow error")
        }
    }
}
