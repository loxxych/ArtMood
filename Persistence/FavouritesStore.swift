//
//  FavouritesStore.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import Foundation

final class FavouritesStore {
    // MARK: - Constants
    private enum Const {
        static let favouritesKey: String = "favourite_artwork_ids"
    }
    
    // MARK: - Fields
    static let shared: FavouritesStore = FavouritesStore()
    
    private let userDefaults: UserDefaults = .standard
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Public
    func getFavouriteIDs() -> [String] {
        userDefaults.stringArray(forKey: Const.favouritesKey) ?? []
    }
    
    func isFavourite(id: String) -> Bool {
        getFavouriteIDs().contains(id)
    }
    
    func addToFavourites(id: String) {
        var ids: [String] = getFavouriteIDs()
        
        guard !ids.contains(id) else { return }
        
        ids.append(id)
        userDefaults.set(ids, forKey: Const.favouritesKey)
    }
    
    func removeFromFavourites(id: String) {
        var ids: [String] = getFavouriteIDs()
        ids.removeAll { $0 == id }
        userDefaults.set(ids, forKey: Const.favouritesKey)
    }
    
    func toggleFavourite(id: String) {
        if isFavourite(id: id) {
            removeFromFavourites(id: id)
        } else {
            addToFavourites(id: id)
        }
    }
}
