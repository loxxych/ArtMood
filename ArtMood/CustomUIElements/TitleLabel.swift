//
//  TitleLabel.swift
//  ArtMood
//
//  Created by loxxy on 15.03.2026.
//

import UIKit

final class TitleLabel: UILabel {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        static let titleText1: String = "Art"
        static let titleText2: String = "Mood"
        
        // Layout
        static let height: CGFloat = 45
        static let width: CGFloat = 296
        
        // Numbers
        // Fonts
        // Colors
        // Images
    }
    
    // MARK: - Fields
    // Numbers
    private var textSize: CGFloat
    
    // MARK: - Lifecycle
    init(fontSize: CGFloat = 70) {
        textSize = fontSize
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        numberOfLines = 1
        
        let text = NSMutableAttributedString(
            string: Const.titleText1,
            attributes: [
                .font: UIFont(name: "InstrumentSans-Medium", size: textSize) ?? UIFont(),
                .foregroundColor: UIColor.black
            ]
        )
        
        text.append(
            NSAttributedString(
                string: Const.titleText2,
                attributes: [
                    .font: UIFont(name: "InstrumentSans-Bold", size: textSize) ?? UIFont(),
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        attributedText = text
    }
}
