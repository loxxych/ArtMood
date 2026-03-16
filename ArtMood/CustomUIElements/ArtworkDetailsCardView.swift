//
//  ArtworkDetailsCardView.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class ArtworkDetailsCardView: UIView {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // Layout
        static let cornerRadius: CGFloat = 32
        static let borderWidth: CGFloat = 1
        
        static let imageTop: CGFloat = 10
        static let imageLeft: CGFloat = 10
        static let imageRight: CGFloat = 10
        static let imageHeight: CGFloat = 270
        static let imageCornerRadius: CGFloat = 28
        
        static let titleTop: CGFloat = 18
        static let titleLeft: CGFloat = 22
        
        static let artistTop: CGFloat = 8
        static let artistBottom: CGFloat = 22
        
        static let favouriteButtonSize: CGFloat = 40
        static let favouriteButtonRight: CGFloat = 20
        static let favouriteButtonBottom: CGFloat = 22
        
        // Fonts
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 44)
            ?? .systemFont(ofSize: 44, weight: .regular)
        static let artistFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 18)
            ?? .systemFont(ofSize: 18, weight: .regular)
        
        // Colors
        static let bgColor: UIColor = .white
        static let borderColor: UIColor = UIColor(named: "NeonGreen") ?? .systemGreen
        static let textColor: UIColor = .black
        static let tintColor: UIColor = .black
        
        // Images
        static let heartAssetName: String = "heartIcon"
        static let heartImage: UIImage = UIImage(named: heartAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let titleLabel: UILabel = UILabel()
    private let artistLabel: UILabel = UILabel()
    
    // Buttons
    private let favouriteButton: UIButton = UIButton(type: .system)
    
    // Views
    private let artworkImageView: UIImageView = UIImageView()
    
    // Closures
    var onFavouriteTapped: (() -> ())?
    
    // Other
    private var artwork: Artwork?
    
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
        backgroundColor = Const.bgColor
        layer.cornerRadius = Const.cornerRadius
        layer.borderWidth = Const.borderWidth
        layer.borderColor = Const.borderColor.cgColor
        
        configureArtworkImageView()
        configureFavouriteButton()
        configureTitleLabel()
        configureArtistLabel()
    }
    
    private func configureArtworkImageView() {
        addSubview(artworkImageView)
        
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        artworkImageView.layer.cornerRadius = Const.imageCornerRadius
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkImageView.topAnchor.constraint(equalTo: topAnchor, constant: Const.imageTop),
            artworkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.imageLeft),
            artworkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.imageRight),
            artworkImageView.heightAnchor.constraint(equalToConstant: Const.imageHeight)
        ])
    }
    
    private func configureFavouriteButton() {
        addSubview(favouriteButton)
        
        favouriteButton.tintColor = Const.tintColor
        favouriteButton.setImage(Const.heartImage.withRenderingMode(.alwaysTemplate), for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.widthAnchor.constraint(equalToConstant: Const.favouriteButtonSize),
            favouriteButton.heightAnchor.constraint(equalToConstant: Const.favouriteButtonSize),
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.favouriteButtonRight),
            favouriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.favouriteButtonBottom)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = Const.titleFont
        titleLabel.textColor = Const.textColor
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: artworkImageView.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.titleLeft),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: favouriteButton.leadingAnchor, constant: -12)
        ])
    }
    
    private func configureArtistLabel() {
        addSubview(artistLabel)
        
        artistLabel.font = Const.artistFont
        artistLabel.textColor = Const.textColor
        artistLabel.numberOfLines = 2
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.artistTop),
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.titleLeft),
            artistLabel.trailingAnchor.constraint(lessThanOrEqualTo: favouriteButton.leadingAnchor, constant: -12),
            artistLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.artistBottom)
        ])
    }
    
    // MARK: - Configuration
    func configure(with artwork: Artwork) {
        self.artwork = artwork
        
        titleLabel.text = artwork.title
        artistLabel.text = "\(artwork.artist)\n\(artwork.year)"
        artworkImageView.image = UIImage(named: artwork.imageName)
    }
    
    // MARK: - Actions
    @objc
    private func favouriteButtonTapped() {
        onFavouriteTapped?()
    }
}
