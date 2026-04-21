//
//  FavoritesViewModel.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation
import Observation

/// Manages the user's favorite film identifiers.
@Observable
class FavoritesViewModel {
    /// The set of favorited film identifiers.
    private(set) var favoriteIDs: Set<String> = []
    
    /// Provides favorite film persistence.
    @ObservationIgnored
    private let service: FavoriteService
    
    /// Creates a favorites view model.
    ///
    /// - Parameter service: The persistence service used to load and save favorites.
    init(service: FavoriteService = DefaultFavoriteService()) {
        self.service = service
    }
    
    /// Loads favorite film identifiers from storage.
    func loadFavorites() {
        favoriteIDs = service.loadFavoriteIDs()
    }
    
    /// Saves the current favorite film identifiers.
    func saveFavorites() {
        service.saveFavoriteIDs(favoriteIDs)
    }
    
    /// Toggles the favorite state for the specified film identifier.
    ///
    /// - Parameter filmID: The identifier of the film to update.
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        saveFavorites()
    }
    
    /// Returns a Boolean value indicating whether the specified film is favorited.
    ///
    /// - Parameter filmID: The identifier of the film to check.
    /// - Returns: `true` if the film is a favorite; otherwise, `false`.
    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }
    
    /// Removes all saved favorites.
    func removeAllFavorites() {
        favoriteIDs.removeAll()
        saveFavorites()
    }
}
