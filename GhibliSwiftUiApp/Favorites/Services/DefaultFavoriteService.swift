//
//  DefaultFavoriteService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

/// Stores favorite film identifiers in `UserDefaults`.
struct DefaultFavoriteService: FavoriteService {
    /// The storage key used for favorite identifiers.
    private let favoritesStorageKey = "GhibliService.favoriteIds"

    /// Loads favorite film identifiers from `UserDefaults`.
    func loadFavoriteIDs() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesStorageKey) ?? []
        return Set(array)
    }
    
    /// Saves favorite film identifiers to `UserDefaults`.
    func saveFavoriteIDs(_ favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesStorageKey)
    }
}
