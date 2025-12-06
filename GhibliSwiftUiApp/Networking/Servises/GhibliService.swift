//
//  GhibliService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//

import Foundation

protocol GhibliService: Sendable {
    func fetchFilms() async throws -> [Film]
    
    func fetchPerson(from URLString: String) async throws -> Person
}
