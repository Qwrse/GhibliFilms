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
        #expect(viewModel.state.data == nil)
        if case .idle = viewModel.state {
        } else {
            Issue.record("Expected idle state")
        }
    }

    @MainActor
    @Test func testTotoro() async throws {
        let viewModel = SearchViewModel(service: service)
        await viewModel.fetch(for: "totoro")
        #expect(viewModel.state.data?.count ?? 0 >= 1)
    }

}
