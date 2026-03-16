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
            artist: "Vincent van Gogh",
            year: "1889",
            imageName: "irises",
            moods: [.happy, .neutral],
            palettes: [.cool, .contrast],
            type: .stillLife
        ),
        Artwork(
            id: "squattingBeggar",
            title: "Squatting Beggar",
            artist: "Pablo Picasso",
            year: "1902",
            imageName: "squattingBeggar",
            moods: [.sad],
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
        ),
        Artwork(
            id: "fieldOfPoppies",
            title: "Field of Poppies",
            artist: "Claude Monet",
            year: "1873",
            imageName: "fieldOfPoppies",
            moods: [.happy],
            palettes: [.warm],
            type: .landscape
        ),
        Artwork(
            id: "vanitasStillLife",
            title: "Vanitas Still Life",
            artist: "Pieter Claesz",
            year: "1630",
            imageName: "vanitasStillLife",
            moods: [.neutral, .sad],
            palettes: [.contrast, .warm],
            type: .stillLife
        ),
        Artwork(
            id: "girlWithPearlEarring",
            title: "Girl with a Pearl Earring",
            artist: "Johannes Vermeer",
            year: "1665",
            imageName: "girlWithPearlEarring",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .portrait
        ),
        Artwork(
            id: "sunflowers",
            title: "Sunflowers",
            artist: "Vincent van Gogh",
            year: "1888",
            imageName: "sunflowers",
            moods: [.happy],
            palettes: [.warm, .contrast],
            type: .stillLife
        ),
        Artwork(
            id: "waterLilies",
            title: "Water Lilies",
            artist: "Claude Monet",
            year: "1916",
            imageName: "waterLilies",
            moods: [.neutral, .happy],
            palettes: [.cool],
            type: .landscape
        ),
        Artwork(
            id: "starryNightOverTheRhine",
            title: "Starry Night Over the Rhône",
            artist: "Vincent van Gogh",
            year: "1888",
            imageName: "starryNightOverTheRhone",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .landscape
        ),
        Artwork(
            id: "theHayWain",
            title: "The Hay Wain",
            artist: "John Constable",
            year: "1821",
            imageName: "theHayWain",
            moods: [.happy, .neutral],
            palettes: [.warm],
            type: .landscape
        ),
        Artwork(
            id: "wandererAboveTheSeaOfFog",
            title: "Wanderer Above the Sea of Fog",
            artist: "Caspar David Friedrich",
            year: "1818",
            imageName: "wandererAboveTheSeaOfFog",
            moods: [.neutral],
            palettes: [.cool, .contrast],
            type: .landscape
        ),
        Artwork(
            id: "theScream",
            title: "The Scream",
            artist: "Edvard Munch",
            year: "1893",
            imageName: "theScream",
            moods: [.sad],
            palettes: [.contrast, .warm],
            type: .portrait
        ),
        Artwork(
            id: "whistlersMother",
            title: "Whistler’s Mother",
            artist: "James McNeill Whistler",
            year: "1871",
            imageName: "whistlersMother",
            moods: [.neutral, .sad],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: "theBlueBoy",
            title: "The Blue Boy",
            artist: "Thomas Gainsborough",
            year: "1770",
            imageName: "theBlueBoy",
            moods: [.neutral],
            palettes: [.cool],
            type: .portrait
        ),
        Artwork(
            id: "theKissKlimt",
            title: "The Kiss",
            artist: "Gustav Klimt",
            year: "1908",
            imageName: "theKissKlimt",
            moods: [.happy, .neutral],
            palettes: [.warm, .contrast],
            type: .portrait
        ),
        Artwork(
            id: "americanGothic",
            title: "American Gothic",
            artist: "Grant Wood",
            year: "1930",
            imageName: "americanGothic",
            moods: [.neutral],
            palettes: [.contrast],
            type: .portrait
        ),
        Artwork(
            id: "ophelia",
            title: "Ophelia",
            artist: "John Everett Millais",
            year: "1851",
            imageName: "ophelia",
            moods: [.sad],
            palettes: [.cool, .contrast],
            type: .portrait
        ),
        Artwork(
            id: "cafeTerraceAtNight",
            title: "Café Terrace at Night",
            artist: "Vincent van Gogh",
            year: "1888",
            imageName: "cafeTerraceAtNight",
            moods: [.happy, .neutral],
            palettes: [.warm, .contrast],
            type: .landscape
        ),
        Artwork(
            id: "theBasketOfApples",
            title: "The Basket of Apples",
            artist: "Paul Cézanne",
            year: "1895",
            imageName: "theBasketOfApples",
            moods: [.neutral],
            palettes: [.warm],
            type: .stillLife
        ),
        Artwork(
            id: "fruitDishOnATable",
            title: "Fruit Dish on a Table",
            artist: "Henri Matisse",
            year: "1899",
            imageName: "fruitDishOnATable",
            moods: [.happy],
            palettes: [.warm, .contrast],
            type: .stillLife
        ),
        Artwork(
            id: "theSleepingGypsy",
            title: "The Sleeping Gypsy",
            artist: "Henri Rousseau",
            year: "1897",
            imageName: "theSleepingGypsy",
            moods: [.neutral],
            palettes: [.warm, .contrast],
            type: .landscape
        )
    ]
}
