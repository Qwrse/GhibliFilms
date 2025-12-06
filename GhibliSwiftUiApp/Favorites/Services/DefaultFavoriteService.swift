//
//  DefaultFavoriteService.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

struct DefaultFavoriteService: FavoriteService {
    private var favoritesKey = "GhibliService.favoriteIds"

    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return Set(array)
    }
    
    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }
}
