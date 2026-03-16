//
//  GreenButton.swift
//  ArtMood
//
//  Created by loxxy on 15.03.2026.
//

import UIKit

final class GreenButton: UIButton {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // UI Constraint properties
        static let height: CGFloat = 56
        static let width: CGFloat = 245

        // Numbers
        // Fonts
        static let font: UIFont = UIFont(name: "circular-std-medium-500", size: 19) ?? .systemFont(ofSize: 19, weight: .medium)
        
        // Layout
        static let horizontalPadding: CGFloat = 16
        static let spacing: CGFloat = 8
        
        // Colors
        static let buttonColor: UIColor = UIColor(named: "NeonGreen") ?? .green
        
        // Images
        static let arrowAssetName: String = "arrowRight"
        static let arrow: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
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
        attributedTitle.foregroundColor = .black
        config.attributedTitle = attributedTitle

        config.baseBackgroundColor = Const.buttonColor
        config.baseForegroundColor = .black

        config.image = Const.arrow.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .trailing
        config.imagePadding = Const.spacing

        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Const.horizontalPadding, bottom: 0, trailing: Const.horizontalPadding)

        config.cornerStyle = .capsule
        
        self.configuration = config

        self.tintColor = .white

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Const.height),
            self.widthAnchor.constraint(equalToConstant: Const.width)
        ])
    }
}
