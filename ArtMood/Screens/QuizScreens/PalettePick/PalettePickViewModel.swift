//
//  PalettePickViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import Foundation

final class PalettePickViewModel: SingleSelectionViewModel<Palette> {
    // MARK: - Fields
    private(set) var selectedPalette: Palette? = .cool

    // MARK: - Selection
    func selectPalette(_ palette: Palette) {
        selectedPalette = palette
        onStateChanged?()
    }
}
