//
//  TypePickViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

class TypePickViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        static let counterText: String = "3/3"
        static let titleText: String = "What would\nyou like to\npeek into\ntoday?"
        static let portraitText: String = "A soul’s story"
        static let landscapeText: String = "A world unseen"
        static let stillLifeText: String = "A Silent Moment"
        static let nextButtonText: String = "Next"
        
        // Layout
        static let backButtonSize: CGFloat = 30
        static let backButtonLeft: CGFloat = 10
        static let backButtonTop: CGFloat = 16
        
        static let counterTop: CGFloat = 26
        static let counterLeft: CGFloat = 24
        
        static let titleTop: CGFloat = 18
        static let titleLeft: CGFloat = 24
        static let titleRight: CGFloat = 24
        
        static let buttonsTop: CGFloat = 36
        static let buttonsLeft: CGFloat = 16
        static let buttonsSpacing: CGFloat = 18
        static let buttonWidth: CGFloat = 178
        static let buttonHeight: CGFloat = 46
        static let buttonCornerRadius: CGFloat = 23
        static let buttonBorderWidth: CGFloat = 1
        
        static let topImageTop: CGFloat = 320
        static let topImageRight: CGFloat = 0
        static let topImageSize: CGFloat = 168
        
        static let bottomImageTop: CGFloat = 530
        static let bottomImageRight: CGFloat = 18
        static let bottomImageWidth: CGFloat = 114
        static let bottomImageHeight: CGFloat = 188
        static let bottomImageCornerRadius: CGFloat = 57
        
        static let nextButtonBottom: CGFloat = 18
        static let nextButtonTopSpacing: CGFloat = 36
        
        // Numbers
        static let titleNumOfLines: Int = 4
        
        // Fonts
        static let counterFont: UIFont = UIFont(name: "InstrumentSans-SemiBold", size: 22)
            ?? .systemFont(ofSize: 22, weight: .semibold)
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 38)
            ?? .systemFont(ofSize: 38, weight: .regular)
        static let optionFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 16)
            ?? .systemFont(ofSize: 16, weight: .regular)
        
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        static let selectedButtonBgColor: UIColor = .black
        static let selectedButtonTextColor: UIColor = .white
        static let normalButtonBgColor: UIColor = .white
        static let normalButtonTextColor: UIColor = .black
        static let borderColor: UIColor = .black
        
        // Images
        static let arrowAssetName: String = "arrowLeft"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
        static let topArtworkImage: UIImage = UIImage(named: "typePortrait") ?? UIImage()
        static let bottomArtworkImage: UIImage = UIImage(named: "typeStillLife") ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let counterLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    private let nextButton: UIButton = GreenButton(with: Const.nextButtonText)
    private let portraitButton: UIButton = UIButton(type: .system)
    private let landscapeButton: UIButton = UIButton(type: .system)
    private let stillLifeButton: UIButton = UIButton(type: .system)
    
    // Images
    private let topArtworkImageView: UIImageView = UIImageView()
    private let bottomArtworkImageView: UIImageView = UIImageView()
    
    // Views
    private let buttonsContainerView: UIView = UIView()
    
    // Closures
    var onTypeSelected: ((PaintingType) -> ())?
    var onBackTapped: (() -> ())?
    
    // Other
    private var paintingType: PaintingType?
    
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
        updateSelectionUI()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureBackButton()
        configureCounterLabel()
        configureTitleLabel()
        configureArtworkImageViews()
        configureButtonsContainerView()
        configurePortraitButton()
        configureLandscapeButton()
        configureStillLifeButton()
        configureNextButton()
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
    
    private func configureCounterLabel() {
        view.addSubview(counterLabel)
        
        counterLabel.text = Const.counterText
        counterLabel.font = Const.counterFont
        counterLabel.textColor = .black
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            counterLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Const.counterTop),
            counterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.counterLeft)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = Const.titleText
        titleLabel.font = Const.titleFont
        titleLabel.textColor = .black
        titleLabel.numberOfLines = Const.titleNumOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.titleLeft),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.titleRight)
        ])
    }
    
    private func configureArtworkImageViews() {
        view.addSubview(topArtworkImageView)
        view.addSubview(bottomArtworkImageView)
        
        topArtworkImageView.image = Const.topArtworkImage
        topArtworkImageView.contentMode = .scaleAspectFill
        topArtworkImageView.clipsToBounds = true
        topArtworkImageView.layer.cornerRadius = Const.topImageSize / 2
        topArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomArtworkImageView.image = Const.bottomArtworkImage
        bottomArtworkImageView.contentMode = .scaleAspectFill
        bottomArtworkImageView.clipsToBounds = true
        bottomArtworkImageView.layer.cornerRadius = Const.bottomImageCornerRadius
        bottomArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topArtworkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.topImageTop),
            topArtworkImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.topImageRight),
            topArtworkImageView.widthAnchor.constraint(equalToConstant: Const.topImageSize),
            topArtworkImageView.heightAnchor.constraint(equalToConstant: Const.topImageSize),
            
            bottomArtworkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.bottomImageTop),
            bottomArtworkImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.bottomImageRight),
            bottomArtworkImageView.widthAnchor.constraint(equalToConstant: Const.bottomImageWidth),
            bottomArtworkImageView.heightAnchor.constraint(equalToConstant: Const.bottomImageHeight)
        ])
    }
    
    private func configureButtonsContainerView() {
        view.addSubview(buttonsContainerView)
        
        buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonsContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.buttonsTop),
            buttonsContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.buttonsLeft),
            buttonsContainerView.widthAnchor.constraint(equalToConstant: Const.buttonWidth)
        ])
    }
    
    private func configurePortraitButton() {
        buttonsContainerView.addSubview(portraitButton)
        
        configureTypeButton(
            button: portraitButton,
            title: Const.portraitText,
            action: #selector(portraitButtonTapped)
        )
        
        NSLayoutConstraint.activate([
            portraitButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor),
            portraitButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
            portraitButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor),
            portraitButton.heightAnchor.constraint(equalToConstant: Const.buttonHeight)
        ])
    }
    
    private func configureLandscapeButton() {
        buttonsContainerView.addSubview(landscapeButton)
        
        configureTypeButton(
            button: landscapeButton,
            title: Const.landscapeText,
            action: #selector(landscapeButtonTapped)
        )
        
        NSLayoutConstraint.activate([
            landscapeButton.topAnchor.constraint(equalTo: portraitButton.bottomAnchor, constant: Const.buttonsSpacing),
            landscapeButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
            landscapeButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor),
            landscapeButton.heightAnchor.constraint(equalToConstant: Const.buttonHeight)
        ])
    }
    
    private func configureStillLifeButton() {
        buttonsContainerView.addSubview(stillLifeButton)
        
        configureTypeButton(
            button: stillLifeButton,
            title: Const.stillLifeText,
            action: #selector(stillLifeButtonTapped)
        )
        
        NSLayoutConstraint.activate([
            stillLifeButton.topAnchor.constraint(equalTo: landscapeButton.bottomAnchor, constant: Const.buttonsSpacing),
            stillLifeButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
            stillLifeButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor),
            stillLifeButton.heightAnchor.constraint(equalToConstant: Const.buttonHeight),
            stillLifeButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor)
        ])
    }
    
    private func configureTypeButton(
        button: UIButton,
        title: String,
        action: Selector
    ) {
        var config: UIButton.Configuration = .plain()
        var attributedTitle: AttributedString = AttributedString(title)
        attributedTitle.font = Const.optionFont
        attributedTitle.foregroundColor = Const.normalButtonTextColor
        config.attributedTitle = attributedTitle
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        
        button.configuration = config
        button.backgroundColor = Const.normalButtonBgColor
        button.layer.cornerRadius = Const.buttonCornerRadius
        button.layer.borderWidth = Const.buttonBorderWidth
        button.layer.borderColor = Const.borderColor.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.nextButtonBottom),
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: buttonsContainerView.bottomAnchor, constant: Const.nextButtonTopSpacing)
        ])
    }
    
    private func updateSelectionUI() {
        updateTypeButton(button: portraitButton, isSelected: paintingType == .portrait)
        updateTypeButton(button: landscapeButton, isSelected: paintingType == .landscape)
        updateTypeButton(button: stillLifeButton, isSelected: paintingType == .stillLife)
        
        updateArtworkImages()
        
        nextButton.isEnabled = paintingType != nil
        nextButton.alpha = paintingType == nil ? 0.6 : 1.0
    }
    
    private func updateTypeButton(
        button: UIButton,
        isSelected: Bool
    ) {
        guard var config: UIButton.Configuration = button.configuration else { return }
        guard var title: AttributedString = config.attributedTitle else { return }
        
        title.foregroundColor = isSelected ? Const.selectedButtonTextColor : Const.normalButtonTextColor
        config.attributedTitle = title
        button.configuration = config
        button.backgroundColor = isSelected ? Const.selectedButtonBgColor : Const.normalButtonBgColor
    }
    
    private func updateArtworkImages() {
        switch paintingType {
        case .portrait:
            topArtworkImageView.image = UIImage(named: "typePortrait") ?? UIImage()
            bottomArtworkImageView.image = UIImage(named: "typePortraitBottom") ?? UIImage()
        case .landscape:
            topArtworkImageView.image = UIImage(named: "typeLandscape") ?? UIImage()
            bottomArtworkImageView.image = UIImage(named: "typeLandscapeBottom") ?? UIImage()
        case .stillLife:
            topArtworkImageView.image = UIImage(named: "typeStillLife") ?? UIImage()
            bottomArtworkImageView.image = UIImage(named: "typeStillLifeBottom") ?? UIImage()
        case .none:
            topArtworkImageView.image = UIImage(named: "typePortrait") ?? UIImage()
            bottomArtworkImageView.image = UIImage(named: "typePortraitBottom") ?? UIImage()
        }
    }
    
    private func selectPortrait() {
        paintingType = .portrait
        updateSelectionUI()
    }
    
    private func selectLandscape() {
        paintingType = .landscape
        updateSelectionUI()
    }
    
    private func selectStillLife() {
        paintingType = .stillLife
        updateSelectionUI()
    }
    
    // MARK: - Actions
    @objc
    private func portraitButtonTapped() {
        selectPortrait()
    }
    
    @objc
    private func landscapeButtonTapped() {
        selectLandscape()
    }
    
    @objc
    private func stillLifeButtonTapped() {
        selectStillLife()
    }
    
    @objc
    private func nextButtonTapped() {
        guard let paintingType else { return }
        onTypeSelected?(paintingType)
    }
    
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
}
