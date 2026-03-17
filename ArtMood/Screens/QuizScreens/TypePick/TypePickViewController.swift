//
//  TypePickViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class TypePickViewController: UIViewController {
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
        
        static let buttonsTop: CGFloat = 45
        static let buttonsLeft: CGFloat = titleLeft
        static let buttonsSpacing: CGFloat = 16
        static let buttonWidth: CGFloat = 178
        static let buttonHeight: CGFloat = 46
        static let buttonCornerRadius: CGFloat = 23
        static let buttonBorderWidth: CGFloat = 1
        
        static let topImageTop: CGFloat = 230
        static let topImageRight: CGFloat = 50
        static let topImageSize: CGFloat = 224
        
        static let bottomImageRight: CGFloat = -14
        static let bottomImageWidth: CGFloat = 147
        static let bottomImageHeight: CGFloat = 273
        static let bottomImageCornerRadius: CGFloat = bottomImageWidth / 2
        
        static let nextButtonBottom: CGFloat = 18
        static let nextButtonTopSpacing: CGFloat = 36
        
        static let greenStarTop: CGFloat = 10
        static let greenStarSize: CGFloat = 112
        
        static let leftOrnamentLeft: CGFloat = -18
        static let leftOrnamentBottom: CGFloat = 62
        static let leftOrnamentSize: CGFloat = 120
        
        static let titleTranslationY: CGFloat = 24
        static let buttonTranslationY: CGFloat = 20
        static let nextButtonTranslationY: CGFloat = 40
        static let hiddenAlpha: CGFloat = 0
        static let visibleAlpha: CGFloat = 1
        static let decorationAnimationDuration: TimeInterval = 0.35
        
        // Animations
        static let titleAnimationDuration: TimeInterval = 0.45
        static let titleAnimationDelay: TimeInterval = 0.15
        static let portraitAnimationDelay: TimeInterval = 0.42
        static let landscapeAnimationDelay: TimeInterval = 0.54
        static let stillLifeAnimationDelay: TimeInterval = 0.66
        static let nextButtonAnimationDuration: TimeInterval = 0.4
        static let nextButtonAnimationDelay: TimeInterval = 0.82
        
        // Numbers
        static let titleNumOfLines: Int = 4
        
        // Fonts
        static let counterFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 22)
            ?? .systemFont(ofSize: 22, weight: .semibold)
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 43)
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
        static let arrowImage: UIImage = UIImage(named: "arrowLeft") ?? UIImage()
        static let portraitTopArtworkImage: UIImage = UIImage(named: "typePortrait") ?? UIImage()
        static let portraitBottomArtworkImage: UIImage = UIImage(named: "typePortraitBottom") ?? UIImage()
        static let landscapeTopArtworkImage: UIImage = UIImage(named: "typeLandscape") ?? UIImage()
        static let landscapeBottomArtworkImage: UIImage = UIImage(named: "typeLandscapeBottom") ?? UIImage()
        static let stillLifeTopArtworkImage: UIImage = UIImage(named: "typeStillLife") ?? UIImage()
        static let stillLifeBottomArtworkImage: UIImage = UIImage(named: "typeStillLifeBottom") ?? UIImage()
        static let greenStarImage: UIImage = UIImage(named: "greenStar") ?? UIImage()
        static let leftOrnamentImage: UIImage = UIImage(named: "flower") ?? UIImage()
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
    private let greenStarImageView: UIImageView = UIImageView()
    private let leftOrnamentImageView: UIImageView = UIImageView()
    
    // Views
    private let buttonsContainerView: UIView = UIView()
    
    // Closures
    var onTypeSelected: ((PaintingType) -> ())?
    var onBackTapped: (() -> ())?
    
    // Other
    private let vm: SingleSelectionViewModel = TypePickViewModel()
    
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
        
        bindViewModel()
        render()
        
        configureUI()
        prepareAnimationState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runAppearAnimations()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = Const.bgColor
        
        configureBackButton()
        configureCounterLabel()
        configureTitleLabel()
        configureDecorations()
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
    
    private func configureDecorations() {
        view.addSubview(greenStarImageView)
        view.addSubview(leftOrnamentImageView)
        
        greenStarImageView.image = Const.greenStarImage
        greenStarImageView.contentMode = .scaleAspectFit
        greenStarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        leftOrnamentImageView.image = Const.leftOrnamentImage
        leftOrnamentImageView.contentMode = .scaleAspectFit
        leftOrnamentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greenStarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.greenStarTop),
            greenStarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenStarImageView.widthAnchor.constraint(equalToConstant: Const.greenStarSize),
            greenStarImageView.heightAnchor.constraint(equalToConstant: Const.greenStarSize),
            
            leftOrnamentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftOrnamentLeft),
            leftOrnamentImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.leftOrnamentBottom),
            leftOrnamentImageView.widthAnchor.constraint(equalToConstant: Const.leftOrnamentSize),
            leftOrnamentImageView.heightAnchor.constraint(equalToConstant: Const.leftOrnamentSize)
        ])
        
        view.sendSubviewToBack(greenStarImageView)
        view.sendSubviewToBack(leftOrnamentImageView)
    }
    
    private func configureArtworkImageViews() {
        view.addSubview(topArtworkImageView)
        view.addSubview(bottomArtworkImageView)
        
        topArtworkImageView.image = Const.portraitTopArtworkImage
        topArtworkImageView.contentMode = .scaleAspectFill
        topArtworkImageView.clipsToBounds = true
        topArtworkImageView.layer.cornerRadius = Const.topImageSize / 2
        topArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomArtworkImageView.image = Const.portraitBottomArtworkImage
        bottomArtworkImageView.contentMode = .scaleAspectFill
        bottomArtworkImageView.clipsToBounds = true
        bottomArtworkImageView.layer.cornerRadius = Const.bottomImageCornerRadius
        bottomArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topArtworkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.topImageTop),
            topArtworkImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Const.topImageRight),
            topArtworkImageView.widthAnchor.constraint(equalToConstant: Const.topImageSize),
            topArtworkImageView.heightAnchor.constraint(equalToConstant: Const.topImageSize),
            
            bottomArtworkImageView.topAnchor.constraint(equalTo: topArtworkImageView.bottomAnchor),
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
        let topImage: UIImage
        let bottomImage: UIImage
        
        switch vm.selectedValue {
        case .portrait:
            topImage = Const.portraitTopArtworkImage
            bottomImage = Const.portraitBottomArtworkImage
        case .landscape:
            topImage = Const.landscapeTopArtworkImage
            bottomImage = Const.landscapeBottomArtworkImage
        case .stillLife:
            topImage = Const.stillLifeTopArtworkImage
            bottomImage = Const.stillLifeBottomArtworkImage
        case .none:
            topImage = Const.portraitTopArtworkImage
            bottomImage = Const.portraitBottomArtworkImage
        }
        
        UIView.transition(with: topArtworkImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.topArtworkImageView.image = topImage
        }
        
        UIView.transition(with: bottomArtworkImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.bottomArtworkImageView.image = bottomImage
        }
    }
    
    // MARK: - Selection logic
    private func selectPortrait() {
        vm.select(.portrait)
    }
    
    private func selectLandscape() {
        vm.select(.landscape)
    }
    
    private func selectStillLife() {
        vm.select(.stillLife)
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
        guard let paintingType = vm.selectedValue else { return }
        onTypeSelected?(paintingType)
    }
    
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
    
    // MARK: - Animations
    private func prepareAnimationState() {
        backButton.alpha = Const.hiddenAlpha
        counterLabel.alpha = Const.hiddenAlpha
        greenStarImageView.alpha = Const.hiddenAlpha
        leftOrnamentImageView.alpha = Const.hiddenAlpha
        
        titleLabel.alpha = Const.hiddenAlpha
        titleLabel.transform = CGAffineTransform(translationX: 0, y: Const.titleTranslationY)
        
        portraitButton.alpha = Const.hiddenAlpha
        portraitButton.transform = CGAffineTransform(translationX: 0, y: Const.buttonTranslationY)
        
        landscapeButton.alpha = Const.hiddenAlpha
        landscapeButton.transform = CGAffineTransform(translationX: 0, y: Const.buttonTranslationY)
        
        stillLifeButton.alpha = Const.hiddenAlpha
        stillLifeButton.transform = CGAffineTransform(translationX: 0, y: Const.buttonTranslationY)
        
        nextButton.alpha = Const.hiddenAlpha
        nextButton.transform = CGAffineTransform(translationX: 0, y: Const.nextButtonTranslationY)
    }

    private func runAppearAnimations() {
        UIView.animate(withDuration: Const.decorationAnimationDuration) {
            self.backButton.alpha = Const.visibleAlpha
            self.counterLabel.alpha = Const.visibleAlpha
            self.greenStarImageView.alpha = Const.visibleAlpha
            self.leftOrnamentImageView.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.titleAnimationDuration, delay: Const.titleAnimationDelay, options: [.curveEaseOut]) {
            self.titleLabel.alpha = Const.visibleAlpha
            self.titleLabel.transform = .identity
        }
        
        UIView.animate(withDuration: Const.decorationAnimationDuration, delay: Const.portraitAnimationDelay, options: [.curveEaseOut]) {
            self.portraitButton.alpha = Const.visibleAlpha
            self.portraitButton.transform = .identity
        }
        
        UIView.animate(withDuration: Const.decorationAnimationDuration, delay: Const.landscapeAnimationDelay, options: [.curveEaseOut]) {
            self.landscapeButton.alpha = Const.visibleAlpha
            self.landscapeButton.transform = .identity
        }
        
        UIView.animate(withDuration: Const.decorationAnimationDuration, delay: Const.stillLifeAnimationDelay, options: [.curveEaseOut]) {
            self.stillLifeButton.alpha = Const.visibleAlpha
            self.stillLifeButton.transform = .identity
        }
        
        UIView.animate(withDuration: Const.nextButtonAnimationDuration, delay: Const.nextButtonAnimationDelay, options: [.curveEaseOut]) {
            self.nextButton.alpha = Const.visibleAlpha
            self.nextButton.transform = .identity
        }
    }
    
    // MARK: - Configuration and render
    private func bindViewModel() {
        vm.onStateChanged = { [weak self] in
            self?.render()
        }
    }
    
    private func render() {
        updateTypeButton(button: portraitButton, isSelected: vm.selectedValue == .portrait)
        updateTypeButton(button: landscapeButton, isSelected: vm.selectedValue == .landscape)
        updateTypeButton(button: stillLifeButton, isSelected: vm.selectedValue == .stillLife)
        
        updateArtworkImages()
        
        nextButton.isEnabled = vm.isNextEnabled
        nextButton.alpha = vm.isNextEnabled ? 1.0 : 0.6
    }
}
