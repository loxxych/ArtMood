//
//  GalleryCollectionViewCell.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let identifier: String = "GalleryCollectionViewCell"
        
        // Layout
        static let cornerRadius: CGFloat = 28
        static let borderWidth: CGFloat = 1
        
        static let imageTop: CGFloat = 10
        static let imageLeft: CGFloat = 10
        static let imageRight: CGFloat = 10
        static let imageHeight: CGFloat = 170
        
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
        static let imagePlaceholderColor: UIColor = UIColor(white: 0.9, alpha: 1)
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowAssetName: String = "arrowRight"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let titleLabel: UILabel = UILabel()
    
    // Views
    private let artworkImagePlaceholderView: UIView = UIView()
    private let arrowImageView: UIImageView = UIImageView()
    
    // Other
    private var imageHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        contentView.backgroundColor = Const.bgColor
        contentView.layer.cornerRadius = Const.cornerRadius
        contentView.layer.borderWidth = Const.borderWidth
        contentView.layer.borderColor = Const.borderColor.cgColor
        contentView.clipsToBounds = true
        
        configureArtworkImagePlaceholderView()
        configureTitleLabel()
        configureArrowImageView()
    }
    
    private func configureArtworkImagePlaceholderView() {
        contentView.addSubview(artworkImagePlaceholderView)
        
        artworkImagePlaceholderView.backgroundColor = Const.imagePlaceholderColor
        artworkImagePlaceholderView.layer.cornerRadius = 24
        
        artworkImagePlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        
        imageHeightConstraint = artworkImagePlaceholderView.heightAnchor.constraint(equalToConstant: Const.imageHeight)
        
        NSLayoutConstraint.activate([
            artworkImagePlaceholderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.imageTop),
            artworkImagePlaceholderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.imageLeft),
            artworkImagePlaceholderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.imageRight),
            imageHeightConstraint!
        ])
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.font = Const.titleFont
        titleLabel.textColor = Const.titleColor
        titleLabel.numberOfLines = 2
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: artworkImagePlaceholderView.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.titleLeft),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Const.titleBottom)
        ])
    }
    
    private func configureArrowImageView() {
        contentView.addSubview(arrowImageView)
        
        arrowImageView.image = Const.arrowImage.withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = Const.tintColor
        arrowImageView.contentMode = .scaleAspectFit
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arrowImageView.widthAnchor.constraint(equalToConstant: Const.arrowSize),
            arrowImageView.heightAnchor.constraint(equalToConstant: Const.arrowSize),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.arrowRight),
            arrowImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Const.arrowBottom),
            arrowImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
    }
    
    // MARK: - Configuration
    func configure(with artwork: Artwork) {
        titleLabel.text = artwork.title
    }
    
    func setPlaceholderHeight(_ height: CGFloat) {
        imageHeightConstraint?.constant = height
    }
}

// MARK: - Reuse identifier
extension GalleryCollectionViewCell {
    static let reuseIdentifier: String = "GalleryCollectionViewCell"
}
