//
//  GalleryViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class GalleryViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // Layout
        static let headerHeight: CGFloat = 60
        
        static let backButtonSize: CGFloat = 30
        static let backButtonLeft: CGFloat = 10
        static let backButtonBottom: CGFloat = 6
        
        static let logoWidth: CGFloat = 106
        static let logoHeight: CGFloat = 22
        static let logoLeft: CGFloat = 10
        static let logoTop: CGFloat = 10
        
        static let favouriteButtonSize: CGFloat = 28
        static let favouriteButtonRight: CGFloat = 16
        static let favouriteButtonTop: CGFloat = 10
        
        static let titleTop: CGFloat = 18
        static let titleLeft: CGFloat = 24
        static let titleRight: CGFloat = 24
        
        static let collectionTop: CGFloat = 24
        static let collectionLeft: CGFloat = 16
        static let collectionRight: CGFloat = 16
        static let collectionBottom: CGFloat = 0
        
        static let itemSpacing: CGFloat = 14
        static let lineSpacing: CGFloat = 14
        
        // Fonts
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 42)
            ?? .systemFont(ofSize: 42, weight: .regular)
        static let titleBoldFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 42)
            ?? .boldSystemFont(ofSize: 42)
        
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowAssetName: String = "arrowLeft"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
        
        static let heartAssetName: String = "heart"
        static let heartImage: UIImage = UIImage(named: heartAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let titleLabel: UILabel = UILabel()
    
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    private let favouritesButton: UIButton = UIButton(type: .system)
    
    // Views
    private let headerView: UIView = UIView()
    private let logoView: UIView = LogoView()
    private let collectionView: UICollectionView
    
    // Closures
    var onBackTapped: (() -> ())?
    var onFavouritesTapped: (() -> ())?
    var onArtworkTapped: ((Artwork) -> ())?
    
    // Other
    private let answers: QuizAnswers
    private let recommendationService: ArtworkRecommendationService = ArtworkRecommendationService()
    private var artworks: [Artwork] = []
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init(answers: QuizAnswers) {
        self.answers = answers
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Const.lineSpacing
        layout.minimumInteritemSpacing = Const.itemSpacing
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
        configureCollectionView()
    }
    
    // MARK: - Data configuration
    private func configureData() {
        artworks = recommendationService.recommendArtworks(
            for: answers,
            from: ArtworkMockData.artworks
        )
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureHeader()
        configureTitleLabel()
        configureCollectionViewLayout()
    }
    
    private func configureHeader() {
        view.addSubview(headerView)
        
        headerView.backgroundColor = Const.bgColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Const.headerHeight)
        ])
        
        configureLogoView()
        configureBackButton()
        configureFavouritesButton()
    }
    
    private func configureLogoView() {
        headerView.addSubview(logoView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: Const.logoWidth),
            logoView.heightAnchor.constraint(equalToConstant: Const.logoHeight),
            logoView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Const.logoLeft),
            logoView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Const.logoTop)
        ])
    }
    
    private func configureBackButton() {
        headerView.addSubview(backButton)
        
        backButton.tintColor = Const.tintColor
        backButton.setImage(Const.arrowImage.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: Const.backButtonSize),
            backButton.heightAnchor.constraint(equalToConstant: Const.backButtonSize),
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Const.backButtonLeft),
            backButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Const.backButtonBottom)
        ])
    }
    
    private func configureFavouritesButton() {
        headerView.addSubview(favouritesButton)
        
        favouritesButton.tintColor = Const.tintColor
        favouritesButton.setImage(Const.heartImage.withRenderingMode(.alwaysTemplate), for: .normal)
        favouritesButton.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        
        favouritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouritesButton.widthAnchor.constraint(equalToConstant: Const.favouriteButtonSize),
            favouritesButton.heightAnchor.constraint(equalToConstant: Const.favouriteButtonSize),
            favouritesButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Const.favouriteButtonRight),
            favouritesButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Const.favouriteButtonTop)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.attributedText = makeTitleText()
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.titleLeft),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.titleRight)
        ])
    }
    
    private func configureCollectionViewLayout() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.collectionTop),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.collectionLeft),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.collectionRight),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Const.collectionBottom)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(
            GalleryCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func makeTitleText() -> NSAttributedString {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: "A gallery of\n",
            attributes: [
                .font: Const.titleFont,
                .foregroundColor: UIColor.black
            ]
        )
        
        attributedText.append(
            NSAttributedString(
                string: "your",
                attributes: [
                    .font: Const.titleBoldFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        attributedText.append(
            NSAttributedString(
                string: " feelings",
                attributes: [
                    .font: Const.titleFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        return attributedText
    }
    
    private func imageHeight(for indexPath: IndexPath) -> CGFloat {
        switch indexPath.item % 4 {
        case 0:
            return 165
        case 1:
            return 235
        case 2:
            return 170
        default:
            return 180
        }
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
    
    @objc
    private func favouritesButtonTapped() {
        onFavouritesTapped?()
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        artworks.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let artwork: Artwork = artworks[indexPath.item]
        cell.configure(with: artwork)
        cell.setImageHeight(imageHeight(for: indexPath))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let totalSpacing: CGFloat = Const.itemSpacing
        let availableWidth: CGFloat = collectionView.bounds.width - totalSpacing
        let itemWidth: CGFloat = availableWidth / 2
        
        let currentImageHeight: CGFloat = imageHeight(for: indexPath)
        let totalHeight: CGFloat = currentImageHeight + 10 + 10 + 40
        
        return CGSize(width: itemWidth, height: totalHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let artwork: Artwork = artworks[indexPath.item]
        onArtworkTapped?(artwork)
    }
}
