//
//  GhibliSwiftUiAppTests.swift
//  GhibliSwiftUiAppTests
//
//  Created by dimss on 03/12/2025.
//

import Testing
@testable import GhibliSwiftUiApp

struct GhibliSwiftUiAppTests {
    let service = MockGhibliService()

    @MainActor
    @Test func testIdle() async throws {
        let viewModel = SearchViewModel(service: service)
        if case .idle = viewModel.state {
        } else {
            Issue.record("Expected idle state")
        }
    }

    @MainActor
    @Test func testTotoro() async throws {
        let viewModel = SearchViewModel(service: service)
        await viewModel.searchFilms(matching: "totoro")
        switch viewModel.state {
        case .loaded(let films):
            #expect(films.count >= 1)
        default:
            Issue.record("Expected loaded state with results, got: \(viewModel.state)")
        }
    }

}
