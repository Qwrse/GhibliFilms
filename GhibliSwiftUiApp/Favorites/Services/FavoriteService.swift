//
//  FavoriteService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

/// Defines persistence operations for favorite film identifiers.
protocol FavoriteService {
    /// Loads the saved favorite film identifiers.
    func loadFavoriteIDs() -> Set<String>
    /// Persists the provided favorite film identifiers.
    func saveFavoriteIDs(_ favoriteIDs: Set<String>)
}
