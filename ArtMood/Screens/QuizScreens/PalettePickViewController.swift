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
        static let optionsHorizontalInset: CGFloat = 20
        static let optionHeight: CGFloat = 52
        static let optionSpacing: CGFloat = 28
        
        static let firstImageSize: CGFloat = 112
        static let secondImageWidth: CGFloat = 120
        static let secondImageHeight: CGFloat = 112
        static let thirdImageSize: CGFloat = 112
        
        static let buttonWidth: CGFloat = 190
        static let nextButtonBottom: CGFloat = 18
        static let nextButtonTopSpacing: CGFloat = 32
        
        static let optionCornerRadius: CGFloat = 26
        static let optionBorderWidth: CGFloat = 1
        
        // Fonts
        static let counterFont: UIFont = UIFont(name: "InstrumentSans-SemiBold", size: 22)
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
        static let arrowAssetName: String = "arrowLeft"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
        static let coolImage: UIImage = UIImage(named: "paletteCool") ?? UIImage()
        static let warmImage: UIImage = UIImage(named: "paletteWarm") ?? UIImage()
        static let contrastImage: UIImage = UIImage(named: "paletteContrast") ?? UIImage()
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
    
    // Views
    private let optionsContainerView: UIView = UIView()
    private let firstRowView: UIView = UIView()
    private let secondRowView: UIView = UIView()
    private let thirdRowView: UIView = UIView()
    
    // Closures
    var onPaletteSelected: ((Palette) -> ())?
    var onBackTapped: (() -> ())?
    
    // Other
    private var palette: Palette?
    
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
        configureOptionsContainerView()
        configureFirstRow()
        configureSecondRow()
        configureThirdRow()
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
            firstRowView.heightAnchor.constraint(equalToConstant: Const.firstImageSize)
        ])
        
        configurePaletteButton(
            button: coolButton,
            title: Const.coolText,
            isSelected: true,
            action: #selector(coolButtonTapped)
        )
        
        configurePaletteImageView(
            imageView: coolImageView,
            image: Const.coolImage
        )
        
        firstRowView.addSubview(coolButton)
        firstRowView.addSubview(coolImageView)
        
        NSLayoutConstraint.activate([
            coolButton.leadingAnchor.constraint(equalTo: firstRowView.leadingAnchor),
            coolButton.centerYAnchor.constraint(equalTo: firstRowView.centerYAnchor),
            coolButton.widthAnchor.constraint(equalToConstant: Const.buttonWidth),
            coolButton.heightAnchor.constraint(equalToConstant: Const.optionHeight),
            
            coolImageView.trailingAnchor.constraint(equalTo: firstRowView.trailingAnchor),
            coolImageView.centerYAnchor.constraint(equalTo: firstRowView.centerYAnchor),
            coolImageView.widthAnchor.constraint(equalToConstant: Const.firstImageSize),
            coolImageView.heightAnchor.constraint(equalToConstant: Const.firstImageSize)
        ])
    }
    
    private func configureSecondRow() {
        optionsContainerView.addSubview(secondRowView)
        
        secondRowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondRowView.topAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: Const.optionSpacing),
            secondRowView.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor),
            secondRowView.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor),
            secondRowView.heightAnchor.constraint(equalToConstant: Const.secondImageHeight)
        ])
        
        configurePaletteButton(
            button: warmButton,
            title: Const.warmText,
            isSelected: false,
            action: #selector(warmButtonTapped)
        )
        
        configurePaletteImageView(
            imageView: warmImageView,
            image: Const.warmImage
        )
        
        secondRowView.addSubview(warmImageView)
        secondRowView.addSubview(warmButton)
        
        NSLayoutConstraint.activate([
            warmImageView.leadingAnchor.constraint(equalTo: secondRowView.leadingAnchor),
            warmImageView.centerYAnchor.constraint(equalTo: secondRowView.centerYAnchor),
            warmImageView.widthAnchor.constraint(equalToConstant: Const.secondImageWidth),
            warmImageView.heightAnchor.constraint(equalToConstant: Const.secondImageHeight),
            
            warmButton.trailingAnchor.constraint(equalTo: secondRowView.trailingAnchor),
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
            thirdRowView.heightAnchor.constraint(equalToConstant: Const.thirdImageSize),
            thirdRowView.bottomAnchor.constraint(equalTo: optionsContainerView.bottomAnchor)
        ])
        
        configurePaletteButton(
            button: contrastButton,
            title: Const.contrastText,
            isSelected: false,
            action: #selector(contrastButtonTapped)
        )
        
        configurePaletteImageView(
            imageView: contrastImageView,
            image: Const.contrastImage
        )
        
        thirdRowView.addSubview(contrastButton)
        thirdRowView.addSubview(contrastImageView)
        
        NSLayoutConstraint.activate([
            contrastButton.leadingAnchor.constraint(equalTo: thirdRowView.leadingAnchor),
            contrastButton.centerYAnchor.constraint(equalTo: thirdRowView.centerYAnchor),
            contrastButton.widthAnchor.constraint(equalToConstant: Const.buttonWidth),
            contrastButton.heightAnchor.constraint(equalToConstant: Const.optionHeight),
            
            contrastImageView.trailingAnchor.constraint(equalTo: thirdRowView.trailingAnchor),
            contrastImageView.centerYAnchor.constraint(equalTo: thirdRowView.centerYAnchor),
            contrastImageView.widthAnchor.constraint(equalToConstant: Const.thirdImageSize),
            contrastImageView.heightAnchor.constraint(equalToConstant: Const.thirdImageSize)
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
        imageView.layer.cornerRadius = imageView === warmImageView ? 28 : imageView === contrastImageView ? Const.thirdImageSize / 2 : Const.firstImageSize / 2
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
    
    private func updateSelectionUI() {
        updatePaletteButton(button: coolButton, isSelected: palette == .cool)
        updatePaletteButton(button: warmButton, isSelected: palette == .warm)
        updatePaletteButton(button: contrastButton, isSelected: palette == .contrast)
        
        nextButton.isEnabled = palette != nil
        nextButton.alpha = palette == nil ? 0.6 : 1.0
    }
    
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
    
    private func selectCool() {
        palette = .cool
        updateSelectionUI()
    }
    
    private func selectWarm() {
        palette = .warm
        updateSelectionUI()
    }
    
    private func selectContrast() {
        palette = .contrast
        updateSelectionUI()
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
        guard let palette else { return }
        onPaletteSelected?(palette)
    }
    
    @objc
    private func backButtonTapped() {
        onBackTapped?()
    }
}
