//
//  ArtworkRecommendationService.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import Foundation

final class ArtworkRecommendationService {
    // MARK: - Constants
    private enum Const {
        static let moodScore: Int = 3
        static let paletteScore: Int = 2
        static let typeScore: Int = 3
    }
    
    // MARK: - Recommendation
    func recommendArtworks(
        for answers: QuizAnswers,
        from artworks: [Artwork]
    ) -> [Artwork] {
        let scoredArtworks: [ScoredArtwork] = artworks.map { artwork in
            let score: Int = calculateScore(for: artwork, answers: answers)
            
            return ScoredArtwork(
                artwork: artwork,
                score: score
            )
        }
        
        return scoredArtworks
            .filter { $0.score > 0 }
            .sorted { lhs, rhs in
                if lhs.score == rhs.score {
                    return lhs.artwork.title < rhs.artwork.title
                }
                
                return lhs.score > rhs.score
            }
            .map { $0.artwork }
    }
    
    // MARK: - Score calculation
    private func calculateScore(
        for artwork: Artwork,
        answers: QuizAnswers
    ) -> Int {
        var score: Int = 0
        
        if artwork.type == answers.type {
            score += Const.typeScore
        }
        
        if artwork.moods.contains(answers.mood) {
            score += Const.moodScore
        }
        
        if artwork.palettes.contains(answers.palette) {
            score += Const.paletteScore
        }
        
        return score
    }
}
