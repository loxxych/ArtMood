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
        
        static let hypnosisViewSize: CGFloat = 172
        static let hypnosisViewBottom: CGFloat = 20
        static let hypnosisViewRight: CGFloat = 20

        static let backButtonSize: CGFloat = 30
        static let backButtonLeft: CGFloat = 10
        static let backButtonBottom: CGFloat = 0
        
        static let logoWidth: CGFloat = 120
        static let logoHeight: CGFloat = 22
        static let logoLeft: CGFloat = 25
        static let logoTop: CGFloat = 5
        
        static let favouriteButtonSize: CGFloat = 28
        static let favouriteButtonRight: CGFloat = 16
        static let favouriteButtonTop: CGFloat = 15
        
        static let collectionTop: CGFloat = 6
        static let collectionLeft: CGFloat = 16
        static let collectionRight: CGFloat = 16
        static let collectionBottom: CGFloat = 0
        
        static let itemSpacing: CGFloat = 14
        static let lineSpacing: CGFloat = 16
        
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowImage: UIImage = UIImage(named: "arrowLeft") ?? UIImage()
        static let heartImage: UIImage = UIImage(named: "heartIcon") ?? UIImage()
        static let hypnosisImage: UIImage = UIImage(named: "hypnosis") ?? UIImage()
    }
    
    // MARK: - Section
    private enum Section: Int, CaseIterable {
        case intro
        case artworks
    }
    
    // MARK: - Fields
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    private let favouritesButton: UIButton = UIButton(type: .system)
    
    // Images
    private let hypnosisImageView: UIImageView = UIImageView()

    // Views
    private let headerView: UIView = UIView()
    private let logoView: UIView = LogoView()
    private let collectionView: UICollectionView
    
    // Closures
    var onBackTapped: (() -> ())?
    var onFavouritesTapped: (() -> ())?
    var onArtworkTapped: ((Artwork) -> ())?
    
    // Other
    private let vm: GalleryViewModel
    private var hasAnimated: Bool = false
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init(answers: QuizAnswers) {
        vm = GalleryViewModel(answers: answers)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Const.lineSpacing
        layout.minimumInteritemSpacing = Const.itemSpacing
        layout.sectionInset = .zero
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.loadArtworks()
        configureUI()
        configureCollectionView()
        
        prepareAnimationState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !hasAnimated else { return }
        hasAnimated = true
        
        runAppearAnimations()
    }

    // MARK: - UI configuration
    private func configureUI() {
        configureBackground()
        configureHeader()
        configureCollectionViewLayout()
    }
    
    private func configureBackground() {
        view.backgroundColor = Const.bgColor

        view.addSubview(hypnosisImageView)
        
        hypnosisImageView.image = Const.hypnosisImage
        hypnosisImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hypnosisImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Const.hypnosisViewRight),
            hypnosisImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Const.hypnosisViewBottom),
            hypnosisImageView.widthAnchor.constraint(equalToConstant: Const.hypnosisViewSize),
            hypnosisImageView.heightAnchor.constraint(equalToConstant: Const.hypnosisViewSize),
        ])
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
    
    private func configureCollectionViewLayout() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Const.collectionTop),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.collectionLeft),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.collectionRight),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Const.collectionBottom)
        ])
    }
    

    // MARK: - Configuration
    private func configureCollectionView() {
        collectionView.register(
            GalleryIntroCell.self,
            forCellWithReuseIdentifier: GalleryIntroCell.reuseIdentifier
        )
        
        collectionView.register(
            GalleryCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.bottom = 24
    }
    
    private func imageHeight(for artworkIndex: Int) -> CGFloat {
        switch artworkIndex % 4 {
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
    
    // MARK: - Animations
    private func prepareAnimationState() {
        headerView.alpha = 0
        hypnosisImageView.alpha = 0
        collectionView.alpha = 0
        
        headerView.transform = CGAffineTransform(translationX: 0, y: -12)
        hypnosisImageView.transform = CGAffineTransform(translationX: 0, y: 24)
        collectionView.transform = CGAffineTransform(translationX: 24, y: 0)
    }

    private func runAppearAnimations() {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut]) {
            self.headerView.alpha = 1
            self.headerView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.35, delay: 0.12, options: [.curveEaseOut]) {
            self.hypnosisImageView.alpha = 1
            self.hypnosisImageView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.45, delay: 0.2, options: [.curveEaseOut]) {
            self.collectionView.alpha = 1
            self.collectionView.transform = .identity
        }
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .intro:
            return 1
        case .artworks:
            return vm.artworks.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .intro:
            guard let cell: GalleryIntroCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryIntroCell.reuseIdentifier,
                for: indexPath
            ) as? GalleryIntroCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: vm.introItem)
            
            cell.alpha = 1
            cell.transform = .identity
            return cell
            
        case .artworks:
            guard let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? GalleryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let artwork: Artwork = vm.artworks[indexPath.item]
            cell.configure(with: artwork)
            cell.setImageHeight(imageHeight(for: indexPath.item))
            
            cell.alpha = 1
            cell.transform = .identity
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else {
            return .zero
        }
        
        switch section {
        case .intro:
            return CGSize(width: collectionView.bounds.width, height: 150)
            
        case .artworks:
            let totalSpacing: CGFloat = Const.itemSpacing
            let availableWidth: CGFloat = collectionView.bounds.width - totalSpacing
            let itemWidth: CGFloat = availableWidth / 2
            
            let currentImageHeight: CGFloat = imageHeight(for: indexPath.item)
            let totalHeight: CGFloat = currentImageHeight + 10 + 10 + 40
            
            return CGSize(width: itemWidth, height: totalHeight)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        guard let section = Section(rawValue: section) else { return Const.lineSpacing }
        
        switch section {
        case .intro:
            return 8
        case .artworks:
            return Const.lineSpacing
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        guard let section = Section(rawValue: section) else { return Const.itemSpacing }
        
        switch section {
        case .intro:
            return 0
        case .artworks:
            return Const.itemSpacing
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        guard section == .artworks else { return }
        
        let artwork: Artwork = vm.artworks[indexPath.item]
        onArtworkTapped?(artwork)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard hasAnimated else { return }
        
        if cell.alpha == 1, cell.transform == .identity {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: 16)
            
            UIView.animate(withDuration: 0.3, delay: 0.03 * Double(indexPath.item), options: [.curveEaseOut]) {
                cell.alpha = 1
                cell.transform = .identity
            }
        }
    }
}
