//
//  FavoritesViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    private(set) var favoriteIDs: Set<String> = []
    
    @ObservationIgnored
    private let service: FavoriteService
    
    init(service: FavoriteService = DefaultFavoriteService()) {
        self.service = service
    }
    
    func load() {
        self.favoriteIDs = service.load()
    }
    
    func save() {
        self.service.save(favoriteIDs: favoriteIDs)
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        save()
    }
    
    func isFavorite(filmID: String) -> Bool {
        return favoriteIDs.contains(filmID)
    }
    
    func removeAll() {
        self.favoriteIDs.removeAll()
        save()
    }
}
