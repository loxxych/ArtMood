//
//  FavouritesViewController.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

class FavouritesViewController: UIViewController {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let fatalError: String = "init(coder:) has not been implemented"
        
        // Layout
        static let headerHeight: CGFloat = 80
        static let logoHeight: CGFloat = 22
        static let logoWidth: CGFloat = 130
        static let logoLeft: CGFloat = 10
        static let logoTop: CGFloat = 10
        static let backButtonSize: CGFloat = 30
        static let backButtonLeft: CGFloat = 10
        
        // Numbers
        // Fonts
        // Colors
        static let bgColor: UIColor = .white
        static let tintColor: UIColor = .black
        
        // Images
        static let arrowAssetName: String = "arrowLeft"
        static let arrowImage: UIImage = UIImage(named: arrowAssetName) ?? UIImage()
    }
    
    // MARK: - Fields
    // Labels
    // Buttons
    private let backButton: UIButton = UIButton(type: .system)
    
    // Views
    private let headerView: UIView = UIView()
    private let logoView: UIView = LogoView()
    
    // Closures
    var onBackTapped: (() -> ())?
    
    // Other
    
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
        
        configureHeader()
    }
    
    private func configureHeader() {
        view.addSubview(headerView)
        
        headerView.backgroundColor = Const.bgColor
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Const.headerHeight),
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
            logoView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Const.logoTop),
        ])
    }
    
    private func configureBackButton() {
        headerView.addSubview(backButton)
        
        backButton.tintColor = Const.tintColor
        backButton.setImage(Const.arrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: Const.backButtonSize),
            backButton.heightAnchor.constraint(equalToConstant: Const.backButtonSize),
            backButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: Const.backButtonLeft),
            backButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        onBackTapped?()
    }
}
