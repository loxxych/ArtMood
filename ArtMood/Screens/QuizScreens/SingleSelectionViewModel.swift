//
//  QuizSelectionViewModel.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import Foundation

class SingleSelectionViewModel<Value> {
    // MARK: - Fields
    var onStateChanged: (() -> ())?
    private(set) var selectedValue: Value?
    
    var isNextEnabled: Bool {
        selectedValue != nil
    }
    
    // MARK: - Lifecycle
    init(initialValue: Value? = nil) {
        selectedValue = initialValue
    }
    
    // MARK: - Selection logic
    func select(_ value: Value) {
        selectedValue = value
        onStateChanged?()
    }
}
