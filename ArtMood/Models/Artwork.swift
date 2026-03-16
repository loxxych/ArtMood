//
//  Artwork.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import Foundation

struct Artwork {
    let id: UUID
    let title: String
    let artist: String
    let year: String
    let imageName: String
    let moods: [Mood]
    let palettes: [Palette]
    let type: PaintingType
}
