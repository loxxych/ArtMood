//
//  StartViewController.swift
//  ArtMood
//
//  Created by loxxy on 15.03.2026.
//

import UIKit

final class StartViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        static let descText: String = "Pick your mood. Discover the art that feels like you."
        static let startButtonText: String = "Get started"
        static let favouritesButtontext: String = "My favourites"
        
        // Layout
        static let descTop: CGFloat = 3
        static let logoImageTop: CGFloat = 50
        static let titleTop: CGFloat = 7
        static let logoImageSize: CGFloat = 60
        static let descHorizontal: CGFloat = 20
        static let startButtonBottom: CGFloat = 25
        static let favButtonBottom: CGFloat = 30
        
        static let rightDotsSize: CGFloat = 120
        static let rightDotsRight: CGFloat = 20
        static let rightDotsCenterY: CGFloat = 120

        static let hypnosisSize: CGFloat = 120
        static let hypnosisBottom: CGFloat = 140

        static let leftArtworkHeight: CGFloat = 240
        static let leftArtworkWidth: CGFloat = 120

        static let rightArtworkSize: CGFloat = 120
        static let rightArtworkBottom: CGFloat = 26

        static let ornamentWidth: CGFloat = 120
        static let ornamentHeight: CGFloat = 120
        static let ornamentCenterX: CGFloat = 30
        static let ornamentBottom: CGFloat = 0
        
        // Animations
        static let hiddenAlpha: CGFloat = 0
        static let visibleAlpha: CGFloat = 1
        static let rightDotsTranslationX: CGFloat = 80
        static let hypnosisTranslationY: CGFloat = 50
        static let artworkTranslationY: CGFloat = 80
        static let buttonTranslationY: CGFloat = 60
        static let logoInitialScale: CGFloat = 0.92
        static let textTranslationY: CGFloat = 12
        static let primaryAnimationDuration: TimeInterval = 0.5
        static let titleAnimationDelay: TimeInterval = 0.15
        static let descriptionAnimationDelay: TimeInterval = 0.28
        static let decorationsAnimationDuration: TimeInterval = 0.55
        static let decorationsAnimationDelay: TimeInterval = 0.4
        static let hypnosisRotationDuration: CFTimeInterval = 4
                
        // Numbers
        static let descNumOfLines = 2
        
        // Fonts
        static let decriptionFont = UIFont(name: "InstrumentSans-Regular", size: 20)
        
        // Colors
        static let bgColor: UIColor = .white
        
        // Images
        static let logoImage: UIImage = UIImage(named: "Logo") ?? UIImage()
        static let rightDotsImage: UIImage = UIImage(named: "dotsCircle") ?? UIImage()
        static let hypnosisImage: UIImage = UIImage(named: "hypnosis") ?? UIImage()
        static let flowerImage: UIImage = UIImage(named: "flower") ?? UIImage()
        static let artwork1: UIImage = UIImage(named: "startArtwork1") ?? UIImage()
        static let artwork2: UIImage = UIImage(named: "startArtwork2") ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let titleLabel: UILabel = TitleLabel()
    private let descriptionLabel: UILabel = UILabel()
    
    // Buttons
    private let startButton: UIButton = GreenButton(with: Const.startButtonText)
    private let favouritesButton: UIButton = BlackButton(with: Const.favouritesButtontext)
    
    // Images
    private let logoImageView: UIImageView = UIImageView()
    private let rightDotsImageView: UIImageView = UIImageView()
    private let hypnosisImageView: UIImageView = UIImageView()
    private let bottomLeftArtworkImageView: UIImageView = UIImageView()
    private let bottomOrnamentImageView: UIImageView = UIImageView()
    private let bottomRightArtworkImageView: UIImageView = UIImageView()
    
    // Closures
    var onGetStarted: (()->())?
    var onFavouritesTapped: (()->())?
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        prepareAnimationState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runAppearAnimations()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureBackground()
        configureLogoImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureFavouritesButton()
        configureStartButton()
    }
    
    private func configureBackground() {
        view.backgroundColor = Const.bgColor
        
        rightDotsImageView.image = Const.rightDotsImage
        hypnosisImageView.image = Const.hypnosisImage
        bottomOrnamentImageView.image = Const.flowerImage
        bottomLeftArtworkImageView.image = Const.artwork1
        bottomRightArtworkImageView.image = Const.artwork2
        
        rightDotsImageView.contentMode = .scaleAspectFit
        hypnosisImageView.contentMode = .scaleAspectFit
        bottomOrnamentImageView.contentMode = .scaleAspectFit
        bottomLeftArtworkImageView.contentMode = .scaleAspectFill
        bottomRightArtworkImageView.contentMode = .scaleAspectFill
        
        bottomLeftArtworkImageView.clipsToBounds = true
        bottomRightArtworkImageView.clipsToBounds = true
        
        view.addSubview(rightDotsImageView)
        view.addSubview(hypnosisImageView)
        view.addSubview(bottomLeftArtworkImageView)
        view.addSubview(bottomRightArtworkImageView)
        view.addSubview(bottomOrnamentImageView)
        
        rightDotsImageView.translatesAutoresizingMaskIntoConstraints = false
        hypnosisImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomRightArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomOrnamentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightDotsImageView.widthAnchor.constraint(equalToConstant: Const.rightDotsSize),
            rightDotsImageView.heightAnchor.constraint(equalToConstant: Const.rightDotsSize),
            rightDotsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Const.rightDotsRight),
            rightDotsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Const.rightDotsCenterY),
            
            hypnosisImageView.widthAnchor.constraint(equalToConstant: Const.hypnosisSize),
            hypnosisImageView.heightAnchor.constraint(equalToConstant: Const.hypnosisSize),
            hypnosisImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hypnosisImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.hypnosisBottom),
            
            bottomLeftArtworkImageView.widthAnchor.constraint(equalToConstant: Const.leftArtworkWidth),
            bottomLeftArtworkImageView.heightAnchor.constraint(equalToConstant: Const.leftArtworkHeight),
            bottomLeftArtworkImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLeftArtworkImageView.topAnchor.constraint(equalTo: hypnosisImageView.bottomAnchor),
            
            bottomRightArtworkImageView.widthAnchor.constraint(equalToConstant: Const.rightArtworkSize),
            bottomRightArtworkImageView.heightAnchor.constraint(equalToConstant: Const.rightArtworkSize),
            bottomRightArtworkImageView.leadingAnchor.constraint(equalTo: bottomLeftArtworkImageView.trailingAnchor),
            bottomRightArtworkImageView.topAnchor.constraint(equalTo: bottomLeftArtworkImageView.topAnchor),
            
            bottomOrnamentImageView.widthAnchor.constraint(equalToConstant: Const.ornamentWidth),
            bottomOrnamentImageView.heightAnchor.constraint(equalToConstant: Const.ornamentHeight),
            bottomOrnamentImageView.topAnchor.constraint(equalTo: bottomRightArtworkImageView.bottomAnchor),
            bottomOrnamentImageView.leadingAnchor.constraint(equalTo: bottomRightArtworkImageView.leadingAnchor)
        ])
        
        view.sendSubviewToBack(rightDotsImageView)
        view.sendSubviewToBack(hypnosisImageView)
        view.sendSubviewToBack(bottomLeftArtworkImageView)
        view.sendSubviewToBack(bottomRightArtworkImageView)
        view.sendSubviewToBack(bottomOrnamentImageView)
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.image = Const.logoImage
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: Const.logoImageSize),
            logoImageView.widthAnchor.constraint(equalToConstant: Const.logoImageSize),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.logoImageTop),
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Const.titleTop),
        ])
    }
    
    private func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.text = Const.descText
        descriptionLabel.font = Const.decriptionFont
        descriptionLabel.numberOfLines = Const.descNumOfLines
        descriptionLabel.textAlignment = .center
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.descTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.descHorizontal),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.descHorizontal),
        ])
    }
    
    private func configureFavouritesButton() {
        view.addSubview(favouritesButton)
        
        favouritesButton.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        
        favouritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favouritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.favButtonBottom)
        ])
    }
    
    private func configureStartButton() {
        view.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: favouritesButton.topAnchor, constant: -Const.startButtonBottom)
        ])
    }
    
    
    // MARK: - Actions
    @objc
    private func startButtonTapped() {
        onGetStarted?()
    }
    
    @objc
    private func favouritesButtonTapped() {
        onFavouritesTapped?()
    }
    
    // MARK: - Animations
    private func prepareAnimationState() {
        logoImageView.alpha = Const.hiddenAlpha
        titleLabel.alpha = Const.hiddenAlpha
        descriptionLabel.alpha = Const.hiddenAlpha
        
        rightDotsImageView.alpha = Const.hiddenAlpha
        hypnosisImageView.alpha = Const.hiddenAlpha
        bottomLeftArtworkImageView.alpha = Const.hiddenAlpha
        bottomRightArtworkImageView.alpha = Const.hiddenAlpha
        bottomOrnamentImageView.alpha = Const.hiddenAlpha
        startButton.alpha = Const.hiddenAlpha
        favouritesButton.alpha = Const.hiddenAlpha
        
        rightDotsImageView.transform = CGAffineTransform(translationX: Const.rightDotsTranslationX, y: 0)
        hypnosisImageView.transform = CGAffineTransform(translationX: 0, y: Const.hypnosisTranslationY)
        bottomLeftArtworkImageView.transform = CGAffineTransform(translationX: 0, y: Const.artworkTranslationY)
        bottomRightArtworkImageView.transform = CGAffineTransform(translationX: 0, y: Const.artworkTranslationY)
        bottomOrnamentImageView.transform = CGAffineTransform(translationX: 0, y: Const.artworkTranslationY)
        startButton.transform = CGAffineTransform(translationX: 0, y: Const.buttonTranslationY)
        favouritesButton.transform = CGAffineTransform(translationX: 0, y: Const.buttonTranslationY)
        logoImageView.transform = CGAffineTransform(scaleX: Const.logoInitialScale, y: Const.logoInitialScale)
        titleLabel.transform = CGAffineTransform(translationX: 0, y: Const.textTranslationY)
        descriptionLabel.transform = CGAffineTransform(translationX: 0, y: Const.textTranslationY)
    }
    
    private func runAppearAnimations() {
        UIView.animate(withDuration: Const.primaryAnimationDuration) {
            self.logoImageView.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.primaryAnimationDuration, delay: Const.titleAnimationDelay, options: [.curveEaseOut]) {
            self.titleLabel.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.primaryAnimationDuration, delay: Const.descriptionAnimationDelay, options: [.curveEaseOut]) {
            self.descriptionLabel.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.primaryAnimationDuration) {
            self.logoImageView.alpha = Const.visibleAlpha
            self.logoImageView.transform = .identity
        }

        UIView.animate(withDuration: Const.primaryAnimationDuration, delay: Const.titleAnimationDelay, options: [.curveEaseOut]) {
            self.titleLabel.alpha = Const.visibleAlpha
            self.titleLabel.transform = .identity
        }

        UIView.animate(withDuration: Const.primaryAnimationDuration, delay: Const.descriptionAnimationDelay, options: [.curveEaseOut]) {
            self.descriptionLabel.alpha = Const.visibleAlpha
            self.descriptionLabel.transform = .identity
        }
        
        UIView.animate(withDuration: Const.decorationsAnimationDuration, delay: Const.decorationsAnimationDelay, options: [.curveEaseOut]) {
            self.rightDotsImageView.alpha = Const.visibleAlpha
            self.rightDotsImageView.transform = .identity
            
            self.hypnosisImageView.alpha = Const.visibleAlpha
            self.hypnosisImageView.transform = .identity
            
            self.bottomLeftArtworkImageView.alpha = Const.visibleAlpha
            self.bottomLeftArtworkImageView.transform = .identity
            
            self.bottomRightArtworkImageView.alpha = Const.visibleAlpha
            self.bottomRightArtworkImageView.transform = .identity
            
            self.bottomOrnamentImageView.alpha = Const.visibleAlpha
            self.bottomOrnamentImageView.transform = .identity
            
            self.startButton.alpha = Const.visibleAlpha
            self.startButton.transform = .identity
            
            self.favouritesButton.alpha = Const.visibleAlpha
            self.favouritesButton.transform = .identity

        } completion: { _ in
            self.startHypnosisRotation()
        }
    }
    
    private func startHypnosisRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = Const.hypnosisRotationDuration
        rotation.isCumulative = true
        rotation.repeatCount = .infinity
        hypnosisImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
}
