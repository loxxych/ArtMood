//
//  LogoView.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

class LogoView: UIView {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // Layout
        static let logoSize: CGFloat = 20
        static let titleRight: CGFloat = 2
        
        // Numbers
        static let fontSize: CGFloat = 20
        
        // Fonts
        // Colors
        // Images
        static let logoImage: UIImage = UIImage(named: "Logo") ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let titleLabel: UILabel = TitleLabel(fontSize: Const.fontSize)
    private let logoIcon: UIImageView = UIImageView()
    
    // Buttons
    // Views
    // Closures
    // Other
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureLogoImageView()
        configureTitleLabel()
    }
    
    private func configureLogoImageView() {
        addSubview(logoIcon)
        
        logoIcon.image = Const.logoImage
        
        logoIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoIcon.heightAnchor.constraint(equalToConstant: Const.logoSize),
            logoIcon.widthAnchor.constraint(equalToConstant: Const.logoSize),
            logoIcon.leftAnchor.constraint(equalTo: self.leftAnchor),
            logoIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: logoIcon.rightAnchor, constant: Const.titleRight),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
