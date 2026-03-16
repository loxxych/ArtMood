//
//  GalleryCardView.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

class GalleryCardView: UIControl {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // Layout
        static let cornerRadius: CGFloat = 28
        static let borderWidth: CGFloat = 1
        
        static let imageTop: CGFloat = 10
        static let imageLeft: CGFloat = 10
        static let imageRight: CGFloat = 10
        
        static let titleTop: CGFloat = 10
        static let titleLeft: CGFloat = 14
        static let titleBottom: CGFloat = 12
        
        static let arrowSize: CGFloat = 18
        static let arrowRight: CGFloat = 14
        static let arrowBottom: CGFloat = 12
        
        // Fonts
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-SemiBold", size: 16)
            ?? .systemFont(ofSize: 16, weight: .semibold)
        
        // Colors
        static let bgColor: UIColor = .white
        static let borderColor: UIColor = .black
        static let titleColor: UIColor = .black
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowAssetName: String = "arrowRight"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let titleLabel: UILabel = UILabel()
    
    // Buttons
    // Views
    private let artworkImageView: UIImageView = UIImageView()
    private let arrowImageView: UIImageView = UIImageView()
    
    // Closures
    // Other
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init(model: ArtworkCardModel) {
        super.init(frame: .zero)
        configureUI()
        configure(with: model)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        backgroundColor = Const.bgColor
        layer.cornerRadius = Const.cornerRadius
        layer.borderWidth = Const.borderWidth
        layer.borderColor = Const.borderColor.cgColor
        clipsToBounds = true
        
        configureArtworkImageView()
        configureTitleLabel()
        configureArrowImageView()
    }
    
    private func configureArtworkImageView() {
        addSubview(artworkImageView)
        
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        artworkImageView.layer.cornerRadius = 24
        
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkImageView.topAnchor.constraint(equalTo: topAnchor, constant: Const.imageTop),
            artworkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.imageLeft),
            artworkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.imageRight)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = Const.titleFont
        titleLabel.textColor = Const.titleColor
        titleLabel.numberOfLines = 2
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: artworkImageView.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.titleLeft),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.titleBottom)
        ])
    }
    
    private func configureArrowImageView() {
        addSubview(arrowImageView)
        
        arrowImageView.image = Const.arrowImage.withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = Const.tintColor
        arrowImageView.contentMode = .scaleAspectFit
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arrowImageView.widthAnchor.constraint(equalToConstant: Const.arrowSize),
            arrowImageView.heightAnchor.constraint(equalToConstant: Const.arrowSize),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.arrowRight),
            arrowImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.arrowBottom),
            arrowImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
    }
    
    // MARK: - Configuration
    func configure(with model: ArtworkCardModel) {
        artworkImageView.image = model.image
        titleLabel.text = model.title
    }
    
    func setImageHeight(_ height: CGFloat) {
        if let oldConstraint = artworkImageView.constraints.first(where: {
            $0.firstAttribute == .height
        }) {
            artworkImageView.removeConstraint(oldConstraint)
        }
        
        let heightConstraint: NSLayoutConstraint = artworkImageView.heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = true
    }
}
