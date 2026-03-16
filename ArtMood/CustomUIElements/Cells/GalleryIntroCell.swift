//
//  GalleryIntroViewCell.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import UIKit

final class GalleryIntroCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Const {
        static let reuseIdentifier: String = "GalleryIntroCollectionViewCell"
        static let fatalError: String = "init(coder:) has not been implemented"

        static let starSize: CGFloat = 82
        static let starLeft: CGFloat = 6
        static let starTop: CGFloat = 34
        
        static let titleLeft: CGFloat = 60
        static let titleTop: CGFloat = 8
        static let titleRight: CGFloat = 0
        
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 42)
            ?? .systemFont(ofSize: 42, weight: .regular)
        static let titleBoldFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 42)
            ?? .boldSystemFont(ofSize: 42)
        
        static let starImage: UIImage = UIImage(named: "greenStarBurst") ?? UIImage()
    }
    
    // MARK: - Fields
    private let starImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Const.fatalError)
    }
    
    // MARK: - UI configuration
    private func configureUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        configureStarImageView()
        configureTitleLabel()
    }
    
    private func configureStarImageView() {
        contentView.addSubview(starImageView)
        
        starImageView.image = Const.starImage
        starImageView.contentMode = .scaleAspectFit
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.starLeft),
            starImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.starTop),
            starImageView.widthAnchor.constraint(equalToConstant: Const.starSize),
            starImageView.heightAnchor.constraint(equalToConstant: Const.starSize)
        ])
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.attributedText = makeTitleText()
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.titleLeft),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.titleTop),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.titleRight),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func makeTitleText() -> NSAttributedString {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: "A gallery of\n",
            attributes: [
                .font: Const.titleFont,
                .foregroundColor: UIColor.black
            ]
        )
        
        attributedText.append(
            NSAttributedString(
                string: "your",
                attributes: [
                    .font: Const.titleBoldFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        attributedText.append(
            NSAttributedString(
                string: " feelings",
                attributes: [
                    .font: Const.titleFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        return attributedText
    }
}

// MARK: - UICollectionViewCell
extension GalleryIntroCell {
    static let reuseIdentifier: String = Const.reuseIdentifier
}
