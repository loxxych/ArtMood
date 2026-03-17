//
//  TypePickViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import Foundation

final class TypePickViewModel: SingleSelectionViewModel<PaintingType> {
    // MARK: - State
    private(set) var selectedType: PaintingType? = .portrait
    
    // MARK: - Selection
    func selectType(_ type: PaintingType) {
        selectedType = type
        onStateChanged?()
    }
}
