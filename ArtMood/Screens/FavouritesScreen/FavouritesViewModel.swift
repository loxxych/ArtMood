//
//  GalleryViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import UIKit
import Foundation

final class FavouritesViewModel {
    // MARK: - Constants
    private enum Const {
        // Strings        
        // Layout
        // Numbers
        // Fonts
        // Colors
        // Images
        static let introImage: UIImage = UIImage(named: "greenFilledHeart") ?? UIImage()
    }
    
    // MARK: - Fields
    // Services
    private let textMaker: TextMaker = TextMaker()
    private let favouritesStore = FavouritesStore.shared

    // Data
    private(set) var artworks: [Artwork] = []

    // MARK: - Computed properties
    var introItem: IntroItem {
        IntroItem(
            image: Const.introImage,
            title: textMaker.makeFavouritesIntroText()
        )
    }
    
    // MARK: - Business logic
        func loadArtworks() {
            let favouriteIDs = favouritesStore.getFavouriteIDs()
            
            artworks = ArtworkMockData.artworks.filter {
                favouriteIDs.contains($0.id)
            }
        }
}
