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
        
        static let rightDotsSize: CGFloat = 120
        static let rightDotsRight: CGFloat = 34
        static let rightDotsCenterY: CGFloat = 120

        static let hypnosisSize: CGFloat = 120
        static let hypnosisRight: CGFloat = rightDotsRight
        static let hypnosisCenterY: CGFloat = 170

        static let bottomStarSize: CGFloat = 120
        static let bottomStarBottom: CGFloat = 70

        static let leftOrnamentSize: CGFloat = 120
        static let leftOrnamentLeft: CGFloat = -20
        static let leftOrnamentBottom: CGFloat = 18
        static let hiddenAlpha: CGFloat = 0
        static let visibleAlpha: CGFloat = 1
        static let backButtonTranslationX: CGFloat = -12
        static let topDecorInitialScale: CGFloat = 0.9
        static let rightDecorationTranslationX: CGFloat = 20
        static let hypnosisTranslationY: CGFloat = 10
        static let bottomDecorationTranslationY: CGFloat = 20
        static let detailsCardTranslationY: CGFloat = 32
        static let primaryAnimationDuration: TimeInterval = 0.3
        static let secondaryAnimationDuration: TimeInterval = 0.4
        static let secondaryAnimationDelay: TimeInterval = 0.1
        static let cardAnimationDuration: TimeInterval = 0.45
        static let cardAnimationDelay: TimeInterval = 0.2

        // Images
        static let rightDotsImage: UIImage = UIImage(named: "dotsCircle") ?? UIImage()
        static let hypnosisImage: UIImage = UIImage(named: "hypnosis") ?? UIImage()
        static let bottomStarImage: UIImage = UIImage(named: "greenStar") ?? UIImage()
        static let leftOrnamentImage: UIImage = UIImage(named: "flower") ?? UIImage()
        
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowImage: UIImage = UIImage(named: "arrowLeft") ?? UIImage()
        static let topDecorImage: UIImage = UIImage(named: "Logo") ?? UIImage()
    }
    
    // MARK: - Fields
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    
    // Views
    private let topDecorImageView: UIImageView = UIImageView()
    private let detailsCardView: ArtworkDetailsCardView = ArtworkDetailsCardView()
    
    // Images
    private let rightDotsImageView: UIImageView = UIImageView()
    private let hypnosisImageView: UIImageView = UIImageView()
    private let bottomStarImageView: UIImageView = UIImageView()
    private let leftOrnamentImageView: UIImageView = UIImageView()
    
    // Closures
    var onBackTapped: (() -> ())?
    var onFavouriteTapped: ((Artwork) -> ())?
    
    // Other
    private let vm: ArtworkDetailsViewModel
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init(artwork: Artwork) {
        vm = ArtworkDetailsViewModel(artwork: artwork)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureContent()
        configureActions()
        prepareAnimationState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        runAppearAnimations()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureBackground()
        configureBackButton()
        configureTopDecorImageView()
        configureDetailsCardView()
    }
    
    private func configureBackground() {
        view.backgroundColor = Const.bgColor
        
        view.addSubview(rightDotsImageView)
        view.addSubview(hypnosisImageView)
        view.addSubview(bottomStarImageView)
        view.addSubview(leftOrnamentImageView)
        
        rightDotsImageView.image = Const.rightDotsImage
        hypnosisImageView.image = Const.hypnosisImage
        bottomStarImageView.image = Const.bottomStarImage
        leftOrnamentImageView.image = Const.leftOrnamentImage
        
        rightDotsImageView.contentMode = .scaleAspectFit
        hypnosisImageView.contentMode = .scaleAspectFit
        bottomStarImageView.contentMode = .scaleAspectFit
        leftOrnamentImageView.contentMode = .scaleAspectFit
        
        rightDotsImageView.translatesAutoresizingMaskIntoConstraints = false
        hypnosisImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomStarImageView.translatesAutoresizingMaskIntoConstraints = false
        leftOrnamentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightDotsImageView.widthAnchor.constraint(equalToConstant: Const.rightDotsSize),
            rightDotsImageView.heightAnchor.constraint(equalToConstant: Const.rightDotsSize),
            rightDotsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Const.rightDotsRight),
            rightDotsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            hypnosisImageView.widthAnchor.constraint(equalToConstant: Const.hypnosisSize),
            hypnosisImageView.heightAnchor.constraint(equalToConstant: Const.hypnosisSize),
            hypnosisImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Const.hypnosisRight),
            hypnosisImageView.topAnchor.constraint(equalTo: rightDotsImageView.bottomAnchor),
            
            bottomStarImageView.widthAnchor.constraint(equalToConstant: Const.bottomStarSize),
            bottomStarImageView.heightAnchor.constraint(equalToConstant: Const.bottomStarSize),
            bottomStarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStarImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.bottomStarBottom),
            
            leftOrnamentImageView.widthAnchor.constraint(equalToConstant: Const.leftOrnamentSize),
            leftOrnamentImageView.heightAnchor.constraint(equalToConstant: Const.leftOrnamentSize),
            leftOrnamentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftOrnamentLeft),
            leftOrnamentImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Const.leftOrnamentBottom)
        ])
        
        view.sendSubviewToBack(rightDotsImageView)
        view.sendSubviewToBack(hypnosisImageView)
        view.sendSubviewToBack(bottomStarImageView)
        view.sendSubviewToBack(leftOrnamentImageView)
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
        detailsCardView.configure(with: vm.artwork, isFavourite: vm.isFavourite)
    }
    
    private func configureActions() {
        detailsCardView.onFavouriteTapped = { [weak self] in
            guard let self else { return }
            
            vm.toggleFavourite()
            
            detailsCardView.setFavourite(vm.isFavourite)
            
            onFavouriteTapped?(vm.artwork)
        }
        
        detailsCardView.onImageTapped = { [weak self] in
            guard let self else { return }
            openFullScreenArtwork()
        }
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
    
    // MARK: - Display logic
    private func openFullScreenArtwork() {
        let viewController = FullScreenArtworkViewController(artwork: vm.artwork)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    // MARK: - Animations
    private func prepareAnimationState() {
        backButton.alpha = Const.hiddenAlpha
        topDecorImageView.alpha = Const.hiddenAlpha
        
        rightDotsImageView.alpha = Const.hiddenAlpha
        hypnosisImageView.alpha = Const.hiddenAlpha
        bottomStarImageView.alpha = Const.hiddenAlpha
        leftOrnamentImageView.alpha = Const.hiddenAlpha
        
        detailsCardView.alpha = Const.hiddenAlpha
        
        backButton.transform = CGAffineTransform(translationX: Const.backButtonTranslationX, y: 0)
        topDecorImageView.transform = CGAffineTransform(scaleX: Const.topDecorInitialScale, y: Const.topDecorInitialScale)
        
        rightDotsImageView.transform = CGAffineTransform(translationX: Const.rightDecorationTranslationX, y: 0)
        hypnosisImageView.transform = CGAffineTransform(translationX: Const.rightDecorationTranslationX, y: Const.hypnosisTranslationY)
        bottomStarImageView.transform = CGAffineTransform(translationX: 0, y: Const.bottomDecorationTranslationY)
        leftOrnamentImageView.transform = CGAffineTransform(translationX: -Const.rightDecorationTranslationX, y: Const.bottomDecorationTranslationY)
        
        detailsCardView.transform = CGAffineTransform(translationX: 0, y: Const.detailsCardTranslationY)
    }

    private func runAppearAnimations() {
        UIView.animate(withDuration: Const.primaryAnimationDuration, delay: 0, options: [.curveEaseOut]) {
            self.backButton.alpha = Const.visibleAlpha
            self.backButton.transform = .identity
            
            self.topDecorImageView.alpha = Const.visibleAlpha
            self.topDecorImageView.transform = .identity
        }
        
        UIView.animate(withDuration: Const.secondaryAnimationDuration, delay: Const.secondaryAnimationDelay, options: [.curveEaseOut]) {
            self.rightDotsImageView.alpha = Const.visibleAlpha
            self.rightDotsImageView.transform = .identity
            
            self.hypnosisImageView.alpha = Const.visibleAlpha
            self.hypnosisImageView.transform = .identity
            
            self.bottomStarImageView.alpha = Const.visibleAlpha
            self.bottomStarImageView.transform = .identity
            
            self.leftOrnamentImageView.alpha = Const.visibleAlpha
            self.leftOrnamentImageView.transform = .identity
        }
        
        UIView.animate(withDuration: Const.cardAnimationDuration, delay: Const.cardAnimationDelay, options: [.curveEaseOut]) {
            self.detailsCardView.alpha = Const.visibleAlpha
            self.detailsCardView.transform = .identity
        }
    }
}
