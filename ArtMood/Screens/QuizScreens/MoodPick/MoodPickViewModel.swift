//
//  MoodPickViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import Foundation

final class MoodPickViewModel: SingleSelectionViewModel<Mood> {
    // MARK: - Fields
    // Services
    private let textMaker: TextMaker = TextMaker()
    
    // MARK: - Business logic
    func getTitleText() -> NSAttributedString {
        return textMaker.makeMoodPickText()
    }
}
