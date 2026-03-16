//
//  BlackButton.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class BlackButton: UIButton {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // UI Constraint properties
        static let height: CGFloat = 40
        static let width: CGFloat = 211

        // Numbers
        // Fonts
        static let font: UIFont = UIFont(name: "circular-std-medium-500", size: 15) ?? .systemFont(ofSize: 15, weight: .medium)
        
        // Layout
        static let horizontalPadding: CGFloat = 16
        static let spacing: CGFloat = 8
        
        // Colors
        static let buttonColor: UIColor = .black
        static let foregroundColor: UIColor = .white
        
        // Images
        static let heartAssetName: String = "heartIcon"
        static let heart: UIImage = UIImage(named: heartAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Strings
    var titleText: String
    
    // MARK: - Lifecycle
    init(with title: String) {
        titleText = title
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        var config: UIButton.Configuration = .filled()

        var attributedTitle = AttributedString(titleText)
        attributedTitle.font = Const.font
        attributedTitle.foregroundColor = Const.foregroundColor
        config.attributedTitle = attributedTitle

        config.baseBackgroundColor = Const.buttonColor
        config.baseForegroundColor = Const.foregroundColor

        config.image = Const.heart.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .trailing
        config.imagePadding = Const.spacing

        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Const.horizontalPadding, bottom: 0, trailing: Const.horizontalPadding)

        config.cornerStyle = .capsule
        
        self.configuration = config

        self.tintColor = Const.foregroundColor

        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Const.height),
            self.widthAnchor.constraint(equalToConstant: Const.width)
        ])
    }
}
