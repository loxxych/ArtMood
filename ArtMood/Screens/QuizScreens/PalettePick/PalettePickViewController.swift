//
//  PalettePickViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class PalettePickViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        static let counterText: String = "2/3"
        static let titleText: String = "I’m craving…"
        static let coolText: String = "…a splash of cool"
        static let warmText: String = "…a dose of warmth"
        static let contrastText: String = "…pure contrast"
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
        
        static let optionsTop: CGFloat = 42
        static let optionsHorizontalInset: CGFloat = 0
        static let optionHeight: CGFloat = 52
        static let optionSpacing: CGFloat = 28
        
        static let coolImageWidth: CGFloat = 120
        static let coolImageHeight: CGFloat = 117
        
        static let warmImageWidth: CGFloat = 120
        static let warmImageHeight: CGFloat = 112
        
        static let contrastImageSize: CGFloat = 112
        
        static let buttonWidth: CGFloat = 190
        static let nextButtonBottom: CGFloat = 18
        static let nextButtonTopSpacing: CGFloat = 40
        
        static let dotsSize: CGFloat = 120
        static let dotsTop: CGFloat = 0
        static let dotsRight: CGFloat = 44
        
        static let starSize: CGFloat = 62
        static let starTop: CGFloat = 26
        static let starRight: CGFloat = 94
        
        static let leftSpiralSize: CGFloat = 120
        static let leftSpiralLeft: CGFloat = -50
        static let leftSpiralBottom: CGFloat = 180
        
        static let bottomSpiralHeight: CGFloat = 240
        static let bottomSpiralWidth: CGFloat = 120
        static let bottomSpiralBottom: CGFloat = 65
        
        static let blackStarSize: CGFloat = 48
        static let blackStarBottom: CGFloat = 125
        static let blackStarRight: CGFloat = 56
        
        static let buttonsIndent: CGFloat = 25
        
        static let optionCornerRadius: CGFloat = 78
        static let optionBorderWidth: CGFloat = 1
        static let titleTranslationY: CGFloat = 24
        static let rowTranslationX: CGFloat = 60
        static let nextButtonTranslationY: CGFloat = 40
        static let hiddenAlpha: CGFloat = 0
        static let visibleAlpha: CGFloat = 1
        static let decorationAnimationDuration: TimeInterval = 0.35
        static let titleAnimationDuration: TimeInterval = 0.45
        static let titleAnimationDelay: TimeInterval = 0.12
        static let firstRowAnimationDelay: TimeInterval = 0.3
        static let secondRowAnimationDelay: TimeInterval = 0.42
        static let thirdRowAnimationDelay: TimeInterval = 0.54
        static let nextButtonAnimationDuration: TimeInterval = 0.4
        static let nextButtonAnimationDelay: TimeInterval = 0.72
        
        // Fonts
        static let counterFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 22)
            ?? .systemFont(ofSize: 22, weight: .semibold)
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 42)
            ?? .boldSystemFont(ofSize: 42)
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
        static let coolImage: UIImage = UIImage(named: "paletteCool") ?? UIImage()
        static let warmImage: UIImage = UIImage(named: "paletteWarm") ?? UIImage()
        static let contrastImage: UIImage = UIImage(named: "paletteContrast") ?? UIImage()
        static let dotsImage: UIImage = UIImage(named: "dotsCircle") ?? UIImage()
        static let greenStarImage: UIImage = UIImage(named: "greenStar") ?? UIImage()
        static let leftSpiralImage: UIImage = UIImage(named: "leftSpiral") ?? UIImage()
        static let bottomSpiralImage: UIImage = UIImage(named: "bottomSpiral") ?? UIImage()
        static let blackStarImage: UIImage = UIImage(named: "blackStar") ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    private let counterLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    private let nextButton: UIButton = GreenButton(with: Const.nextButtonText)
    private let coolButton: UIButton = UIButton(type: .system)
    private let warmButton: UIButton = UIButton(type: .system)
    private let contrastButton: UIButton = UIButton(type: .system)
    
    // Images
    private let coolImageView: UIImageView = UIImageView()
    private let warmImageView: UIImageView = UIImageView()
    private let contrastImageView: UIImageView = UIImageView()
    private let dotsImageView: UIImageView = UIImageView()
    private let greenStarImageView: UIImageView = UIImageView()
    private let leftSpiralImageView: UIImageView = UIImageView()
    private let bottomSpiralImageView: UIImageView = UIImageView()
    private let blackStarImageView: UIImageView = UIImageView()

    // Views
    private let optionsContainerView: UIView = UIView()
    private let firstRowView: UIView = UIView()
    private let secondRowView: UIView = UIView()
    private let thirdRowView: UIView = UIView()
    
    // Closures
    var onPaletteSelected: ((Palette) -> ())?
    var onBackTapped: (() -> ())?
    
    // Other
    private let vm: SingleSelectionViewModel = PalettePickViewModel()
    private var hasAnimated: Bool = false
    
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
        
        guard !hasAnimated else { return }
        hasAnimated = true
        
        runAppearAnimations()
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        configureBackButton()
        configureCounterLabel()
        configureTitleLabel()
        configureOptionsContainerView()
        configureFirstRow()
        configureSecondRow()
        configureThirdRow()
        configureBackground()
        configureNextButton()
    }
    
    private func configureBackground() {
        view.backgroundColor = Const.bgColor

        configurePaletteImageView(imageView: dotsImageView, image: Const.dotsImage)
        configurePaletteImageView(imageView: greenStarImageView, image: Const.greenStarImage)
        configurePaletteImageView(imageView: leftSpiralImageView, image: Const.leftSpiralImage)
        configurePaletteImageView(imageView: bottomSpiralImageView, image: Const.bottomSpiralImage)
        configurePaletteImageView(imageView: blackStarImageView, image: Const.blackStarImage)
        
        view.addSubview(dotsImageView)
        view.addSubview(greenStarImageView)
        view.addSubview(leftSpiralImageView)
        view.addSubview(bottomSpiralImageView)
        view.addSubview(blackStarImageView)

        NSLayoutConstraint.activate([
            dotsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.dotsTop),
            dotsImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Const.dotsRight),
            dotsImageView.heightAnchor.constraint(equalToConstant: Const.dotsSize),
            dotsImageView.widthAnchor.constraint(equalToConstant: Const.dotsSize),
            
            greenStarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.starTop),
            greenStarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.starRight),
            greenStarImageView.widthAnchor.constraint(equalToConstant: Const.starSize),
            greenStarImageView.heightAnchor.constraint(equalToConstant: Const.starSize),
            
            leftSpiralImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftSpiralLeft),
            leftSpiralImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.leftSpiralBottom),
            leftSpiralImageView.widthAnchor.constraint(equalToConstant: Const.leftSpiralSize),
            leftSpiralImageView.heightAnchor.constraint(equalToConstant: Const.leftSpiralSize),
            
            bottomSpiralImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSpiralImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Const.bottomSpiralBottom),
            bottomSpiralImageView.widthAnchor.constraint(equalToConstant: Const.bottomSpiralWidth),
            bottomSpiralImageView.heightAnchor.constraint(equalToConstant: Const.bottomSpiralHeight),
            
            blackStarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.blackStarRight),
            blackStarImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.blackStarBottom),
            blackStarImageView.widthAnchor.constraint(equalToConstant: Const.blackStarSize),
            blackStarImageView.heightAnchor.constraint(equalToConstant: Const.blackStarSize)
        ])
        
        view.sendSubviewToBack(dotsImageView)
        view.sendSubviewToBack(greenStarImageView)
        view.sendSubviewToBack(leftSpiralImageView)
        view.sendSubviewToBack(bottomSpiralImageView)
        view.sendSubviewToBack(blackStarImageView)
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
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: Const.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.titleLeft),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.titleRight)
        ])
    }
    
    private func configureOptionsContainerView() {
        view.addSubview(optionsContainerView)
        
        optionsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionsContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.optionsTop),
            optionsContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.optionsHorizontalInset),
            optionsContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.optionsHorizontalInset)
        ])
    }
    
    private func configureFirstRow() {
        optionsContainerView.addSubview(firstRowView)
        
        firstRowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstRowView.topAnchor.constraint(equalTo: optionsContainerView.topAnchor),
            firstRowView.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor),
            firstRowView.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor),
            firstRowView.heightAnchor.constraint(equalToConstant: Const.coolImageHeight)
        ])
        
        configurePaletteButton(
            button: coolButton,
            title: Const.coolText,
            isSelected: true,
            action: #selector(coolButtonTapped)
        )
        
        configurePaletteImageView(imageView: coolImageView, image: Const.coolImage)
        
        firstRowView.addSubview(coolButton)
        firstRowView.addSubview(coolImageView)
        
        NSLayoutConstraint.activate([
            coolButton.leadingAnchor.constraint(equalTo: firstRowView.leadingAnchor, constant: Const.buttonsIndent),
            coolButton.centerYAnchor.constraint(equalTo: firstRowView.centerYAnchor),
            coolButton.widthAnchor.constraint(equalToConstant: Const.buttonWidth),
            coolButton.heightAnchor.constraint(equalToConstant: Const.optionHeight),
            
            coolImageView.trailingAnchor.constraint(equalTo: firstRowView.trailingAnchor),
            coolImageView.centerYAnchor.constraint(equalTo: firstRowView.centerYAnchor),
            coolImageView.widthAnchor.constraint(equalToConstant: Const.coolImageWidth),
            coolImageView.heightAnchor.constraint(equalToConstant: Const.coolImageHeight)
        ])
    }
    
    private func configureSecondRow() {
        optionsContainerView.addSubview(secondRowView)
        
        secondRowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondRowView.topAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: Const.optionSpacing),
            secondRowView.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor),
            secondRowView.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor),
            secondRowView.heightAnchor.constraint(equalToConstant: Const.warmImageHeight)
        ])
        
        configurePaletteButton(
            button: warmButton,
            title: Const.warmText,
            isSelected: false,
            action: #selector(warmButtonTapped)
        )
        
        configurePaletteImageView(imageView: warmImageView, image: Const.warmImage)
        
        secondRowView.addSubview(warmImageView)
        secondRowView.addSubview(warmButton)
        
        NSLayoutConstraint.activate([
            warmImageView.leadingAnchor.constraint(equalTo: secondRowView.leadingAnchor),
            warmImageView.centerYAnchor.constraint(equalTo: secondRowView.centerYAnchor),
            warmImageView.widthAnchor.constraint(equalToConstant: Const.warmImageWidth),
            warmImageView.heightAnchor.constraint(equalToConstant: Const.warmImageHeight),
            
            warmButton.trailingAnchor.constraint(equalTo: secondRowView.trailingAnchor, constant: -Const.buttonsIndent),
            warmButton.centerYAnchor.constraint(equalTo: secondRowView.centerYAnchor),
            warmButton.widthAnchor.constraint(equalToConstant: Const.buttonWidth),
            warmButton.heightAnchor.constraint(equalToConstant: Const.optionHeight)
        ])
    }
    
    private func configureThirdRow() {
        optionsContainerView.addSubview(thirdRowView)
        
        thirdRowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thirdRowView.topAnchor.constraint(equalTo: secondRowView.bottomAnchor, constant: Const.optionSpacing),
            thirdRowView.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor),
            thirdRowView.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor),
            thirdRowView.heightAnchor.constraint(equalToConstant: Const.contrastImageSize),
            thirdRowView.bottomAnchor.constraint(equalTo: optionsContainerView.bottomAnchor)
        ])
        
        configurePaletteButton(
            button: contrastButton,
            title: Const.contrastText,
            isSelected: false,
            action: #selector(contrastButtonTapped)
        )
        
        configurePaletteImageView(imageView: contrastImageView, image: Const.contrastImage)
        
        thirdRowView.addSubview(contrastButton)
        thirdRowView.addSubview(contrastImageView)
        
        NSLayoutConstraint.activate([
            contrastButton.leadingAnchor.constraint(equalTo: thirdRowView.leadingAnchor, constant: Const.buttonsIndent),
            contrastButton.centerYAnchor.constraint(equalTo: thirdRowView.centerYAnchor),
            contrastButton.widthAnchor.constraint(equalToConstant: Const.buttonWidth),
            contrastButton.heightAnchor.constraint(equalToConstant: Const.optionHeight),
            
            contrastImageView.trailingAnchor.constraint(equalTo: thirdRowView.trailingAnchor),
            contrastImageView.centerYAnchor.constraint(equalTo: thirdRowView.centerYAnchor),
            contrastImageView.widthAnchor.constraint(equalToConstant: Const.contrastImageSize),
            contrastImageView.heightAnchor.constraint(equalToConstant: Const.contrastImageSize)
        ])
    }
    
    private func configurePaletteButton(
        button: UIButton,
        title: String,
        isSelected: Bool,
        action: Selector
    ) {
        var config: UIButton.Configuration = .plain()
        var attributedTitle: AttributedString = AttributedString(title)
        attributedTitle.font = Const.optionFont
        attributedTitle.foregroundColor = isSelected ? Const.selectedButtonTextColor : Const.normalButtonTextColor
        config.attributedTitle = attributedTitle
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        
        button.configuration = config
        button.backgroundColor = isSelected ? Const.selectedButtonBgColor : Const.normalButtonBgColor
        button.layer.cornerRadius = Const.optionCornerRadius
        button.layer.borderWidth = Const.optionBorderWidth
        button.layer.borderColor = Const.borderColor.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePaletteImageView(
        imageView: UIImageView,
        image: UIImage
    ) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Const.nextButtonBottom),
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: optionsContainerView.bottomAnchor, constant: Const.nextButtonTopSpacing)
        ])
    }
    
    // MARK: - Update logic
    private func updatePaletteButton(
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
    
    // MARK: - Selection logic
    private func selectCool() {
        vm.select(.cool)
    }

    private func selectWarm() {
        vm.select(.warm)
    }

    private func selectContrast() {
        vm.select(.contrast)
    }
    
    // MARK: - Animations
    private func prepareAnimationState() {
        backButton.alpha = Const.hiddenAlpha
        counterLabel.alpha = Const.hiddenAlpha
        titleLabel.alpha = Const.hiddenAlpha
        
        dotsImageView.alpha = Const.hiddenAlpha
        leftSpiralImageView.alpha = Const.hiddenAlpha
        bottomSpiralImageView.alpha = Const.hiddenAlpha
        blackStarImageView.alpha = Const.hiddenAlpha
        
        titleLabel.transform = CGAffineTransform(translationX: 0, y: Const.titleTranslationY)
        
        firstRowView.alpha = Const.hiddenAlpha
        firstRowView.transform = CGAffineTransform(translationX: Const.rowTranslationX, y: 0)
        
        secondRowView.alpha = Const.hiddenAlpha
        secondRowView.transform = CGAffineTransform(translationX: -Const.rowTranslationX, y: 0)
        
        thirdRowView.alpha = Const.hiddenAlpha
        thirdRowView.transform = CGAffineTransform(translationX: Const.rowTranslationX, y: 0)
        
        nextButton.alpha = Const.hiddenAlpha
        nextButton.transform = CGAffineTransform(translationX: 0, y: Const.nextButtonTranslationY)
    }
    
    private func runAppearAnimations() {
        UIView.animate(withDuration: Const.decorationAnimationDuration) {
            self.backButton.alpha = Const.visibleAlpha
            self.counterLabel.alpha = Const.visibleAlpha
            self.dotsImageView.alpha = Const.visibleAlpha
            self.leftSpiralImageView.alpha = Const.visibleAlpha
            self.bottomSpiralImageView.alpha = Const.visibleAlpha
            self.blackStarImageView.alpha = Const.visibleAlpha
        }
        
        UIView.animate(withDuration: Const.titleAnimationDuration, delay: Const.titleAnimationDelay, options: [.curveEaseOut]) {
            self.titleLabel.alpha = Const.visibleAlpha
            self.titleLabel.transform = .identity
        }
        
        UIView.animate(withDuration: Const.titleAnimationDuration, delay: Const.firstRowAnimationDelay, options: [.curveEaseOut]) {
            self.firstRowView.alpha = Const.visibleAlpha
            self.firstRowView.transform = .identity
        }
        
        UIView.animate(withDuration: Const.titleAnimationDuration, delay: Const.secondRowAnimationDelay, options: [.curveEaseOut]) {
            self.secondRowView.alpha = Const.visibleAlpha
            self.secondRowView.transform = .identity
        }
        
        UIView.animate(withDuration: Const.titleAnimationDuration, delay: Const.thirdRowAnimationDelay, options: [.curveEaseOut]) {
            self.thirdRowView.alpha = Const.visibleAlpha
            self.thirdRowView.transform = .identity
        }
        
        UIView.animate(withDuration: Const.nextButtonAnimationDuration, delay: Const.nextButtonAnimationDelay, options: [.curveEaseOut]) {
            self.nextButton.alpha = Const.visibleAlpha
            self.nextButton.transform = .identity
        }
    }
    
    // MARK: - Actions
    @objc
    private func coolButtonTapped() {
        selectCool()
    }
    
    @objc
    private func warmButtonTapped() {
        selectWarm()
    }
    
    @objc
    private func contrastButtonTapped() {
        selectContrast()
    }
    
    @objc
    private func nextButtonTapped() {
        guard let palette = vm.selectedValue else { return }
        onPaletteSelected?(palette)
    }
    
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
    
    // MARK: - Configuration and render
    private func bindViewModel() {
        vm.onStateChanged = { [weak self] in
            self?.render()
        }
    }
    
    private func render() {
        updatePaletteButton(button: coolButton, isSelected: vm.selectedValue == .cool)
        updatePaletteButton(button: warmButton, isSelected: vm.selectedValue == .warm)
        updatePaletteButton(button: contrastButton, isSelected: vm.selectedValue == .contrast)
        
        nextButton.isEnabled = vm.isNextEnabled
        nextButton.alpha = vm.isNextEnabled ? 1.0 : 0.6
    }
}
