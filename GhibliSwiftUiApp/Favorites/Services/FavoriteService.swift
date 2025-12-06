//
//  FavoriteService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

protocol FavoriteService {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
