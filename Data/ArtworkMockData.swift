//
//  ArtworkMockData.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import Foundation

internal enum ArtworkMockData {
    static let artworks: [Artwork] = [
        Artwork(
            id: UUID(),
            title: "Irises",
            artist: "Vincent van Gogh",
            imageName: "irises",
            moods: [.happy, .neutral],
            palettes: [.cool, .contrast],
            type: .stillLife
        ),
        Artwork(
            id: UUID(),
            title: "Squatting beggar",
            artist: "Pablo Picasso",
            imageName: "squattingBeggar",
            moods: [.sad],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "Feeling blue",
            artist: "Unknown",
            imageName: "feelingBlue",
            moods: [.sad, .neutral],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "Christina’s World",
            artist: "Andrew Wyeth",
            imageName: "christinasWorld",
            moods: [.neutral, .sad],
            palettes: [.warm],
            type: .landscape
        ),
        Artwork(
            id: UUID(),
            title: "Girl with a Pearl Earring",
            artist: "Johannes Vermeer",
            imageName: "girlWithPearlEarring",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "The Son of Man",
            artist: "René Magritte",
            imageName: "sonOfMan",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .portrait
        ),
        Artwork(
            id: UUID(),
            title: "Sunlit Field",
            artist: "Unknown",
            imageName: "sunlitField",
            moods: [.happy],
            palettes: [.warm],
            type: .landscape
        ),
        Artwork(
            id: UUID(),
            title: "Silent Table",
            artist: "Unknown",
            imageName: "silentTable",
            moods: [.neutral],
            palettes: [.warm, .contrast],
            type: .stillLife
        )
    ]
}
