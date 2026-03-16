//
//  StartViewController.swift
//  ArtMood
//
//  Created by loxxy on 15.03.2026.
//

import UIKit

class StartViewController: UIViewController {
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
        
        // Numbers
        static let descNumOfLines = 2
        
        // Fonts
        static let decriptionFont = UIFont(name: "InstrumentSans-Regular", size: 20)
        
        // Colors
        static let bgColor: UIColor = .white
        
        // Images
        static let logoImage: UIImage = UIImage(named: "Logo") ?? UIImage()
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
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureLogoImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureFavouritesButton()
        configureStartButton()
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
}

