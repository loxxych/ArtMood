//
//  GalleryViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import UIKit
import Foundation

final class GalleryViewModel {
    // MARK: - Constants
    private enum Const {
        // Strings
        // Layout
        // Numbers
        // Fonts
        // Colors
        // Images
        static let introImage: UIImage = UIImage(named: "greenStarBurst") ?? UIImage()
    }
    
    // MARK: - Fields
    // Services
    private let textMaker: TextMaker = TextMaker()
    private let recommendationService = ArtworkRecommendationService()
    
    // Data
    private let answers: QuizAnswers
    private(set) var artworks: [Artwork] = []
    
    // MARK: - Computed properties
    var introItem: IntroItem {
        IntroItem(
            image: Const.introImage,
            title: textMaker.makeGalleryIntroText()
        )
    }
    
    // MARK: - Lifecycle
    init(answers: QuizAnswers) {
        self.answers = answers
    }
    
    // MARK: - Business logic
    func loadArtworks() {
        artworks = recommendationService.recommendArtworks(
            for: answers,
            from: ArtworkMockData.artworks
        )
    }
}
