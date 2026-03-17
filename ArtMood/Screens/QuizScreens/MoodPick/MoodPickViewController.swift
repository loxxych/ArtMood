//
//  MoodPickViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class MoodPickViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        static let counterText: String = "1/3"
        static let titleText: String = "What is your\nmood\ntoday?"
        static let sadText: String = "Sad"
        static let happyText: String = "Happy"
        static let neutralText: String = "Neutral"
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
        
        static let optionsTop: CGFloat = 36
        static let optionsHorizontalInset: CGFloat = 18
        static let optionsSpacing: CGFloat = 22
        static let optionsBottomSpacing: CGFloat = 26
        
        static let moodButtonWidth: CGFloat = 140
        static let moodButtonHeight: CGFloat = 140
        static let neutralButtonWidth: CGFloat = 140
        static let neutralButtonHeight: CGFloat = 140
        
        static let nextButtonBottom: CGFloat = 18
        
        static let moodImageSize: CGFloat = 76
        static let moodButtonCornerRadius: CGFloat = 30
        static let moodButtonBorderWidth: CGFloat = 1
        static let moodFaceTop: CGFloat = 16
        static let moodTitleTop: CGFloat = 10
        static let moodTitleHorizontalInset: CGFloat = 8
        static let moodTitleBottom: CGFloat = 14
        static let titleTranslationY: CGFloat = 24
        static let nextButtonTranslationY: CGFloat = 40
        static let hiddenAlpha: CGFloat = 0
        static let visibleAlpha: CGFloat = 1
        static let decorationAnimationDuration: TimeInterval = 0.35
        static let titleAnimationDuration: TimeInterval = 0.45
        static let titleAnimationDelay: TimeInterval = 0.15
        static let buttonsAnimationDelay: TimeInterval = 0.45
        static let nextButtonAnimationDelay: TimeInterval = 0.62
        
        static let artworkTop: CGFloat = 10
        static let artworkSize: CGFloat = 120

        static let ornamentLeft: CGFloat = 10
        static let ornamentBottom: CGFloat = artworkTop
        static let ornamentSize: CGFloat = 120

        static let starRight: CGFloat = 25
        static let starTop: CGFloat = 150
        static let starSize: CGFloat = 143

        // Numbers
        static let titleNumOfLines: Int = 3
        
        // Fonts
        static let counterFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 22)
            ?? .systemFont(ofSize: 22, weight: .semibold)
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 55)
            ?? .systemFont(ofSize: 60, weight: .regular)
        static let titleBoldFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 55)
            ?? .boldSystemFont(ofSize: 60)
        static let optionFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 15)
            ?? .systemFont(ofSize: 18, weight: .regular)
        
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        static let buttonBorderColor: UIColor = .black
        static let selectedButtonColor: UIColor = UIColor(named: "NeonGreen") ?? .systemGreen
        static let sadColor: UIColor = UIColor(red: 0.78, green: 0.84, blue: 0.93, alpha: 1.0)
        static let happyColor: UIColor = UIColor(red: 0.91, green: 0.80, blue: 0.54, alpha: 1.0)
        static let neutralColor: UIColor = UIColor(white: 0.82, alpha: 1.0)
        
        // Images
        static let arrowImage: UIImage = UIImage(named: "arrowLeft") ?? UIImage()
        static let artworkImage: UIImage = UIImage(named: "moodPickArtwork") ?? UIImage()
        static let greenStarImage: UIImage = UIImage(named: "greenStar") ?? UIImage()
        static let ornamentImage: UIImage = UIImage(named: "flower") ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let counterLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    private let nextButton: UIButton = GreenButton(with: Const.nextButtonText)
    private let sadButton: UIButton = UIButton(type: .system)
    private let happyButton: UIButton = UIButton(type: .system)
    private let neutralButton: UIButton = UIButton(type: .system)

    // Views
    private let optionsContainerView: UIView = UIView()
    private let topOptionsStackView: UIStackView = UIStackView()
    private let rightTopArtworkImageView: UIImageView = UIImageView()
    private let greenStarImageView: UIImageView = UIImageView()
    private let ornamentImageView: UIImageView = UIImageView()

    // Closures
    var onMoodSelected: ((Mood) -> ())?
    var onBackTapped: (() -> ())?
    
    // Other
    private let vm = MoodPickViewModel()
    
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
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureBackground()
        configureBackButton()
        configureCounterLabel()
        configureTitleLabel()
        configureOptions()
        configureNextButton()
        
        prepareAnimationState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runAppearAnimations()
    }
    
    private func configureBackground() {
        view.backgroundColor = Const.bgColor

        view.addSubview(rightTopArtworkImageView)
        view.addSubview(greenStarImageView)
        view.addSubview(ornamentImageView)
        
        rightTopArtworkImageView.image = Const.artworkImage
        greenStarImageView.image = Const.greenStarImage
        ornamentImageView.image = Const.ornamentImage

        rightTopArtworkImageView.translatesAutoresizingMaskIntoConstraints = false
        greenStarImageView.translatesAutoresizingMaskIntoConstraints = false
        ornamentImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rightTopArtworkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.artworkTop),
            rightTopArtworkImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rightTopArtworkImageView.heightAnchor.constraint(equalToConstant: Const.artworkSize),
            rightTopArtworkImageView.widthAnchor.constraint(equalToConstant: Const.artworkSize),
            
            greenStarImageView.heightAnchor.constraint(equalToConstant: Const.starSize),
            greenStarImageView.widthAnchor.constraint(equalToConstant: Const.starSize),
            greenStarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.starRight),
            greenStarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.starTop),
            
            ornamentImageView.heightAnchor.constraint(equalToConstant: Const.ornamentSize),
            ornamentImageView.widthAnchor.constraint(equalToConstant: Const.ornamentSize),
            ornamentImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.ornamentLeft),
            ornamentImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.ornamentBottom),
        ])
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
        
        titleLabel.attributedText = vm.getTitleText()
        titleLabel.numberOfLines = Const.titleNumOfLines
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.titleLeft),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.titleRight)
        ])
    }
    
    private func configureOptions() {
        view.addSubview(optionsContainerView)
        
        optionsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionsContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.optionsTop),
            optionsContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.optionsHorizontalInset),
            optionsContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.optionsHorizontalInset)
        ])
        
        configureTopOptionsStackView()
        configureSadButton()
        configureHappyButton()
        configureNeutralButton()
    }
    
    private func configureTopOptionsStackView() {
        optionsContainerView.addSubview(topOptionsStackView)
        
        topOptionsStackView.axis = .horizontal
        topOptionsStackView.distribution = .equalSpacing
        topOptionsStackView.alignment = .fill
        topOptionsStackView.spacing = Const.optionsSpacing
        
        topOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topOptionsStackView.topAnchor.constraint(equalTo: optionsContainerView.topAnchor),
            topOptionsStackView.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor),
            topOptionsStackView.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor)
        ])
    }
    
    private func configureSadButton() {
        configureMoodButton(
            button: sadButton,
            title: Const.sadText,
            faceText: "☹️",
            bgColor: Const.sadColor,
            action: #selector(sadButtonTapped)
        )
        
        topOptionsStackView.addArrangedSubview(sadButton)
        
        NSLayoutConstraint.activate([
            sadButton.widthAnchor.constraint(equalToConstant: Const.moodButtonWidth),
            sadButton.heightAnchor.constraint(equalToConstant: Const.moodButtonHeight)
        ])
    }
    
    private func configureHappyButton() {
        configureMoodButton(
            button: happyButton,
            title: Const.happyText,
            faceText: "🙂",
            bgColor: Const.happyColor,
            action: #selector(happyButtonTapped)
        )
        
        topOptionsStackView.addArrangedSubview(happyButton)
        
        NSLayoutConstraint.activate([
            happyButton.widthAnchor.constraint(equalToConstant: Const.moodButtonWidth),
            happyButton.heightAnchor.constraint(equalToConstant: Const.moodButtonHeight)
        ])
    }
    
    private func configureNeutralButton() {
        configureMoodButton(
            button: neutralButton,
            title: Const.neutralText,
            faceText: "😐",
            bgColor: Const.neutralColor,
            action: #selector(neutralButtonTapped)
        )
        
        optionsContainerView.addSubview(neutralButton)
        
        neutralButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            neutralButton.topAnchor.constraint(equalTo: topOptionsStackView.bottomAnchor, constant: Const.optionsSpacing),
            neutralButton.centerXAnchor.constraint(equalTo: optionsContainerView.centerXAnchor),
            neutralButton.widthAnchor.constraint(equalToConstant: Const.neutralButtonWidth),
            neutralButton.heightAnchor.constraint(equalToConstant: Const.neutralButtonHeight),
            neutralButton.bottomAnchor.constraint(equalTo: optionsContainerView.bottomAnchor)
        ])
    }
    
    private func configureMoodButton(
        button: UIButton,
        title: String,
        faceText: String,
        bgColor: UIColor,
        action: Selector
    ) {
        let containerView: UIView = UIView()
        let faceLabel: UILabel = UILabel()
        let titleLabel: UILabel = UILabel()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        faceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.isUserInteractionEnabled = false
        faceLabel.isUserInteractionEnabled = false
        titleLabel.isUserInteractionEnabled = false
        
        button.addSubview(containerView)
        containerView.addSubview(faceLabel)
        containerView.addSubview(titleLabel)
        
        button.backgroundColor = .white
        button.layer.cornerRadius = Const.moodButtonCornerRadius
        button.layer.borderWidth = Const.moodButtonBorderWidth
        button.layer.borderColor = UIColor.clear.cgColor
        button.clipsToBounds = true
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        faceLabel.text = faceText
        faceLabel.textAlignment = .center
        faceLabel.font = .systemFont(ofSize: 58)
        faceLabel.backgroundColor = bgColor
        faceLabel.layer.cornerRadius = Const.moodImageSize / 2
        faceLabel.clipsToBounds = true
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = Const.optionFont
        titleLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: button.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            
            faceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Const.moodFaceTop),
            faceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            faceLabel.widthAnchor.constraint(equalToConstant: Const.moodImageSize),
            faceLabel.heightAnchor.constraint(equalToConstant: Const.moodImageSize),
            
            titleLabel.topAnchor.constraint(equalTo: faceLabel.bottomAnchor, constant: Const.moodTitleTop),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Const.moodTitleHorizontalInset),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Const.moodTitleHorizontalInset),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Const.moodTitleBottom)
        ])
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.nextButtonBottom),
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: optionsContainerView.bottomAnchor, constant: Const.optionsBottomSpacing)
        ])
    }
    
    // MARK: - Selection logic
    private func selectHappy() {
        vm.select(.happy)
    }

    private func selectSad() {
        vm.select(.sad)
    }

    private func selectNeutral() {
        vm.select(.neutral)
    }
    
    // MARK: - Actions
    @objc
    private func sadButtonTapped() {
        selectSad()
    }
    
    @objc
    private func happyButtonTapped() {
        selectHappy()
    }
    
    @objc
    private func neutralButtonTapped() {
        selectNeutral()
    }
    
    @objc
    private func nextButtonTapped() {
        guard let mood = vm.selectedValue else { return }
        onMoodSelected?(mood)
    }
    
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
    
    // MARK: - Animations
    private func prepareAnimationState() {
        counterLabel.alpha = Const.hiddenAlpha
        rightTopArtworkImageView.alpha = Const.hiddenAlpha
        ornamentImageView.alpha = Const.hiddenAlpha
        greenStarImageView.alpha = Const.hiddenAlpha
        
        titleLabel.alpha = Const.hiddenAlpha
        titleLabel.transform = CGAffineTransform(translationX: 0, y: Const.titleTranslationY)
   
        sadButton.alpha = Const.hiddenAlpha
        happyButton.alpha = Const.hiddenAlpha
        neutralButton.alpha = Const.hiddenAlpha
        
        nextButton.alpha = Const.hiddenAlpha
        nextButton.transform = CGAffineTransform(translationX: 0, y: Const.nextButtonTranslationY)
    }
    
    private func runAppearAnimations() {
        UIView.animate(withDuration: Const.decorationAnimationDuration) {
            self.counterLabel.alpha = Const.visibleAlpha
            self.rightTopArtworkImageView.alpha = Const.visibleAlpha
            self.ornamentImageView.alpha = Const.visibleAlpha
            self.greenStarImageView.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.titleAnimationDuration, delay: Const.titleAnimationDelay, options: [.curveEaseOut]) {
            self.titleLabel.alpha = Const.visibleAlpha
            self.titleLabel.transform = .identity
        }
        
        UIView.animate(withDuration: Const.decorationAnimationDuration, delay: Const.buttonsAnimationDelay, options: [.curveEaseOut]) {
            self.sadButton.alpha = Const.visibleAlpha
            self.happyButton.alpha = Const.visibleAlpha
            self.neutralButton.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.decorationAnimationDuration, delay: Const.nextButtonAnimationDelay, options: [.curveEaseOut]) {
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
        sadButton.layer.borderColor = UIColor.clear.cgColor
        happyButton.layer.borderColor = UIColor.clear.cgColor
        neutralButton.layer.borderColor = UIColor.clear.cgColor
        
        sadButton.backgroundColor = .white
        happyButton.backgroundColor = .white
        neutralButton.backgroundColor = .white
        
        switch vm.selectedValue {
        case .sad:
            sadButton.layer.borderColor = Const.buttonBorderColor.cgColor
            sadButton.backgroundColor = Const.selectedButtonColor.withAlphaComponent(0.12)
        case .happy:
            happyButton.layer.borderColor = Const.buttonBorderColor.cgColor
            happyButton.backgroundColor = Const.selectedButtonColor.withAlphaComponent(0.12)
        case .neutral:
            neutralButton.layer.borderColor = Const.buttonBorderColor.cgColor
            neutralButton.backgroundColor = Const.selectedButtonColor.withAlphaComponent(0.12)
        case .none:
            break
        }
        
        nextButton.isEnabled = vm.isNextEnabled
        nextButton.alpha = vm.isNextEnabled ? 1.0 : 0.6
    }
}
