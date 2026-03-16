//
//  QuizAnswers.swift
//  ArtMood
//
//  Created by loxxy on 15.03.2026.
//

enum Mood {
    case happy
    case sad
    case neutral
}

enum Palette {
    case warm
    case cool
    case contrast
}

enum PaintingType {
    case portrait
    case landscape
    case stillLife
}

struct QuizDraftAnswers {
    var mood: Mood?
    var palette: Palette?
    var type: PaintingType?
}

struct QuizAnswers {
    var mood: Mood
    var palette: Palette
    var type: PaintingType
}
