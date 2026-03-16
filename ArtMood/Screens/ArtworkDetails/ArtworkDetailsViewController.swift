//
//  ArtworkDetailsViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class ArtworkDetailsViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // Layout
        static let backButtonSize: CGFloat = 30
        static let backButtonLeft: CGFloat = 10
        static let backButtonTop: CGFloat = 16
        
        static let topDecorSize: CGFloat = 38
        static let topDecorTop: CGFloat = 18
        
        static let cardTop: CGFloat = 92
        static let cardLeft: CGFloat = 18
        static let cardRight: CGFloat = 18
        
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowAssetName: String = "arrowLeft"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
        
        static let topDecorAssetName: String = "Logo"
        static let topDecorImage: UIImage = UIImage(named: topDecorAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    
    // Views
    private let topDecorImageView: UIImageView = UIImageView()
    private let detailsCardView: ArtworkDetailsCardView = ArtworkDetailsCardView()
    
    // Closures
    var onBackTapped: (() -> ())?
    var onFavouriteTapped: ((Artwork) -> ())?
    
    // Other
    private let artwork: Artwork
    private let favouritesStore: FavouritesStore = FavouritesStore.shared
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init(artwork: Artwork) {
        self.artwork = artwork
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureContent()
        configureActions()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureBackButton()
        configureTopDecorImageView()
        configureDetailsCardView()
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        
        backButton.tintColor = Const.tintColor
        backButton.setImage(Const.arrowImage.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: Const.backButtonSize),
            backButton.heightAnchor.constraint(equalToConstant: Const.backButtonSize),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.backButtonLeft),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.backButtonTop)
        ])
    }
    
    private func configureTopDecorImageView() {
        view.addSubview(topDecorImageView)
        
        topDecorImageView.image = Const.topDecorImage
        topDecorImageView.contentMode = .scaleAspectFit
        topDecorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topDecorImageView.widthAnchor.constraint(equalToConstant: Const.topDecorSize),
            topDecorImageView.heightAnchor.constraint(equalToConstant: Const.topDecorSize),
            topDecorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topDecorImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.topDecorTop)
        ])
    }
    
    private func configureDetailsCardView() {
        view.addSubview(detailsCardView)
        
        detailsCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsCardView.topAnchor.constraint(equalTo: topDecorImageView.bottomAnchor, constant: Const.cardTop),
            detailsCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.cardLeft),
            detailsCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.cardRight)
        ])
    }
    
    private func configureContent() {
        let isFavourite: Bool = favouritesStore.isFavourite(id: artwork.id)
        detailsCardView.configure(with: artwork, isFavourite: isFavourite)
    }
    
    private func configureActions() {
        detailsCardView.onFavouriteTapped = { [weak self] in
            guard let self else { return }

            print("Before toggle:", self.favouritesStore.getFavouriteIDs())

            self.favouritesStore.toggleFavourite(id: self.artwork.id)

            print("After toggle:", self.favouritesStore.getFavouriteIDs())

            let isFavourite: Bool = self.favouritesStore.isFavourite(id: self.artwork.id)
            print("isFavourite:", isFavourite)

            self.detailsCardView.setFavourite(isFavourite)
            self.onFavouriteTapped?(self.artwork)
        }
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
}
