//
//  FilmDetailViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation


@Observable
class FilmDetailViewModel {
    let service: GhibliService
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        guard state != .loading else {
            return
        }
        state = .loading
        var loadedPeople: [Person] = []
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personUrl in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personUrl)
                    }
                }
                for try await person in group {
                    loadedPeople.append(person)
                }
                state = .loaded(loadedPeople)
            }
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "unknow error")
        } catch {
            state = .error("unknow error")
        }
    }
}

import Playgrounds

#Playground {
    let vm: FilmDetailViewModel = FilmDetailViewModel()
    let film = try await MockGhibliService().fetchFilm()
    try await vm.fetch(for: film)
    if case let .loaded(people) = vm.state {
        for person in people {
            print(person)
        }
    }
}
