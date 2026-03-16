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
        
        static let titleTop: CGFloat = 18
        static let titleLeft: CGFloat = 24
        static let titleRight: CGFloat = 24
        
        static let collectionTop: CGFloat = 24
        static let collectionLeft: CGFloat = 16
        static let collectionRight: CGFloat = 16
        
        static let itemSpacing: CGFloat = 14
        static let lineSpacing: CGFloat = 14
        
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 42)
            ?? .systemFont(ofSize: 42, weight: .regular)
        static let titleBoldFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 42)
            ?? .boldSystemFont(ofSize: 42)
        
        static let arrowImage: UIImage = UIImage(named: "arrowLeft") ?? UIImage()
    }
    
    // MARK: - Fields
    private let titleLabel: UILabel = UILabel()
    private let backButton: UIButton = UIButton(type: .system)
    
    private let headerView: UIView = UIView()
    private let logoView: UIView = LogoView()
    private let collectionView: UICollectionView
    
    var onBackTapped: (() -> ())?
    var onArtworkTapped: ((Artwork) -> ())?
    
    private let favouritesStore: FavouritesStore = FavouritesStore.shared
    private var favouriteArtworks: [Artwork] = []
    
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
        configureData()
        collectionView.reloadData()
    }
    
    // MARK: - Data
    private func configureData() {
        let favouriteIDs: [String] = favouritesStore.getFavouriteIDs()
        print("Favourite IDs:", favouriteIDs)

        favouriteArtworks = ArtworkMockData.artworks.filter { artwork in
            favouriteIDs.contains(artwork.id)
        }

        print("Favourite artworks count:", favouriteArtworks.count)
    }
    
    // MARK: - UI
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
            string: "The special\n",
            attributes: [
                .font: Const.titleFont,
                .foregroundColor: UIColor.black
            ]
        )
        
        attributedText.append(
            NSAttributedString(
                string: "ones",
                attributes: [
                    .font: Const.titleBoldFont,
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
}

extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favouriteArtworks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let artwork: Artwork = favouriteArtworks[indexPath.item]
        cell.configure(with: artwork)
        cell.setImageHeight(imageHeight(for: indexPath))
        
        return cell
    }
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artwork: Artwork = favouriteArtworks[indexPath.item]
        onArtworkTapped?(artwork)
    }
}
