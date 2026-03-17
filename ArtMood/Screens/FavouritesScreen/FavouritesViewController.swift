//
//  FavouritesViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//
import UIKit

final class FavouritesViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        static let fatalError: String = "init(coder:) has not been implemented"
        
        static let headerHeight: CGFloat = 60
        
        static let backButtonSize: CGFloat = 30
        static let backButtonLeft: CGFloat = 10
        static let backButtonBottom: CGFloat = 0
        
        static let logoWidth: CGFloat = 120
        static let logoHeight: CGFloat = 22
        static let logoLeft: CGFloat = 25
        static let logoTop: CGFloat = 5
        
        static let collectionTop: CGFloat = 24
        static let collectionLeft: CGFloat = 16
        static let collectionRight: CGFloat = 16
        
        static let itemSpacing: CGFloat = 14
        static let lineSpacing: CGFloat = 14
        
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        static let arrowImage: UIImage = UIImage(named: "arrowLeft") ?? UIImage()
    }
    
    // MARK: - Section
    private enum Section: Int, CaseIterable {
        case intro
        case artworks
    }
    
    // MARK: - Fields
    // Labels
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    
    // Views
    private let headerView: UIView = UIView()
    private let logoView: UIView = LogoView()
    private let collectionView: UICollectionView
    
    // Closures
    var onBackTapped: (() -> ())?
    var onArtworkTapped: ((Artwork) -> ())?
    
    // Other
    private let vm = FavouritesViewModel()
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Const.lineSpacing
        layout.minimumInteritemSpacing = Const.itemSpacing
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.loadArtworks()
        collectionView.reloadData()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureHeader()
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
    
    private func configureCollectionViewLayout() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Const.collectionTop),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.collectionLeft),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.collectionRight),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    private func configureCollectionView() {
        collectionView.register(
            GalleryCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier
        )
        
        collectionView.register(
            GalleryIntroCell.self,
            forCellWithReuseIdentifier: GalleryIntroCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
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
}

// MARK: - UICollectionViewDataSource
extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .intro:
            return 1
        case .artworks:
            return vm.artworks.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
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
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryIntroCell.reuseIdentifier,
                for: indexPath
            ) as? GalleryIntroCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: vm.introItem)
            return cell
            
        case .artworks:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? GalleryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let artwork = vm.artworks[indexPath.item]
            cell.configure(with: artwork)
            cell.setImageHeight(imageHeight(for: indexPath))
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return .zero}
        
        switch section {
        case .intro:
            return CGSize(width: collectionView.bounds.width, height: 150)
        case .artworks:
            let totalSpacing: CGFloat = Const.itemSpacing
            let availableWidth: CGFloat = collectionView.bounds.width - totalSpacing
            let itemWidth: CGFloat = availableWidth / 2
            
            let currentImageHeight: CGFloat = imageHeight(for: indexPath)
            let totalHeight: CGFloat = currentImageHeight + 10 + 10 + 40
            
            return CGSize(width: itemWidth, height: totalHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section),
              section == .artworks else { return }
        
        let artwork = vm.artworks[indexPath.item]
        onArtworkTapped?(artwork)
    }
}
