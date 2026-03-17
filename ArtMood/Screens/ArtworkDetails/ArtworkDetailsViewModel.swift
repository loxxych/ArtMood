//
//  ArtworkDetailsViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import Foundation

final class ArtworkDetailsViewModel {
    // MARK: - Fields
    // Services
    private let favouritesStore = FavouritesStore.shared
    
    // Data
    let artwork: Artwork
    private(set) var isFavourite: Bool = false
    
    // MARK: - Lifecycle
    init(artwork: Artwork) {
        self.artwork = artwork
        updateFavouriteState()
    }
    
    // MARK: - Actions
    func toggleFavourite() {
        favouritesStore.toggleFavourite(id: artwork.id)
        updateFavouriteState()
    }
    
    // MARK: - Helpers
    private func updateFavouriteState() {
        isFavourite = favouritesStore.isFavourite(id: artwork.id)
    }
}
