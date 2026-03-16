//
//  ArtworkMockData.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import Foundation

enum ArtworkMockData {
    static let artworks: [Artwork] = [
        Artwork(
            id: UUID(),
            title: "Irises",
            artist: "Vincent van Gogh",
            year: "1950",
            imageName: "irises",
            moods: [.happy, .neutral],
            palettes: [.cool, .contrast],
            type: .stillLife
        ),
        Artwork(
            id: UUID(),
            title: "Squatting beggar",
            artist: "Pablo Picasso",
            year: "1950",
            imageName: "squattingBeggar",
            moods: [.sad],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "Feeling blue",
            artist: "Unknown",
            year: "1950",
            imageName: "feelingBlue",
            moods: [.sad, .neutral],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "Christina’s World",
            artist: "Andrew Wyeth",
            year: "1950",
            imageName: "christinasWorld",
            moods: [.neutral, .sad],
            palettes: [.warm],
            type: .landscape
        ),
        Artwork(
            id: UUID(),
            title: "Girl with a Pearl Earring",
            artist: "Johannes Vermeer",
            year: "1950",
            imageName: "girlWithPearlEarring",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "The Son of Man",
            artist: "René Magritte",
            year: "1950",
            imageName: "sonOfMan",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "Sunlit Field",
            artist: "Unknown",
            year: "1950",
            imageName: "sunlitField",
            moods: [.happy],
            palettes: [.warm],
            type: .landscape
        ),
        Artwork(
            id: UUID(),
            title: "Silent Table",
            artist: "Unknown",
            year: "1950",
            imageName: "silentTable",
            moods: [.neutral],
            palettes: [.warm, .contrast],
            type: .stillLife
        )
    ]
}
