//
//  FilmsViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation


@Observable
final class FilmsViewModel {
    var state: LoadingState<[Film]> = .idle
    private let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch() async {
        guard !state.isLoading else { return }
        state = .loading
        do {
            let films = try await service.fetchFilms()
            state = .loaded(films)
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "unknow error")
        } catch {
            state = .error("unknow error")
        }
    }
}
