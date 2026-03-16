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
            id: "irises",
            title: "Irises",
            artist: "Van Gogh",
            year: "1889",
            imageName: "irises",
            moods: [.happy, .neutral],
            palettes: [.cool, .contrast],
            type: .stillLife
        ),
        Artwork(
            id: "squattingBeggar",
            title: "Squatting beggar",
            artist: "Pablo Picasso",
            year: "1902",
            imageName: "squattingBeggar",
            moods: [.sad],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: "feelingBlue",
            title: "Feeling blue",
            artist: "Unknown",
            year: "2020",
            imageName: "feelingBlue",
            moods: [.sad, .neutral],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: "christinasWorld",
            title: "Christina’s World",
            artist: "Andrew Wyeth",
            year: "1948",
            imageName: "christinasWorld",
            moods: [.neutral, .sad],
            palettes: [.warm],
            type: .landscape
        )
    ]
}
