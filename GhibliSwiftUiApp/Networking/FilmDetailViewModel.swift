//
//  FilmDetailViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation


/// Manages people related to a selected film.
@Observable
class FilmDetailViewModel {
    /// Provides film and person data.
    let service: GhibliService
    
    /// The current loading state for the film's people.
    var state: LoadingState<[Person]> = .idle
    
    /// Creates a film detail view model.
    ///
    /// - Parameter service: The service used to load related people.
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    /// Loads the people related to the specified film.
    ///
    /// - Parameter film: The film whose people should be loaded.
    func loadPeople(for film: Film) async {
        guard !state.isLoading else {
            return
        }
        state = .loading
        var people: [Person] = []
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personURLString in film.peopleURLs {
                    group.addTask {
                        try await self.service.fetchPerson(from: personURLString)
                    }
                }
                for try await person in group {
                    people.append(person)
                }
                state = .loaded(people)
            }
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            state = .error("Unknown error")
        }
    }
}

import Playgrounds

#Playground {
    let viewModel = FilmDetailViewModel()
    let films = try MockGhibliService().fetchFilms()
    let film = films[1]
    await viewModel.loadPeople(for: film)
    if case let .loaded(people) = viewModel.state {
        for person in people {
            print(person)
        }
    } else if case let .error(message) = viewModel.state {
        print(message)
    }
}
