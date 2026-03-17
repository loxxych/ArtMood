//
//  TextMaker.swift
//  ArtMood
//
//  Created by loxxy on 17.03.2026.
//

import Foundation
import UIKit

final class TextMaker {
    // MARK: - Constants
    private enum Const {
        // Strings
        static let galleryIntroText1: String = "A gallery of\n"
        static let galleryIntroText2: String = "your"
        static let galleryIntroText3: String = " feelings"

        static let favIntroText1: String = "The "
        static let favIntroText2: String = "special"
        static let favIntroText3: String = " ones"

        static let moodPickText1: String = "What is your\n"
        static let moodPickText2: String = "mood"
        static let moodPickText3: String = "\ntoday?"

        // Fonts
        static let titleFont: UIFont = UIFont(name: "InstrumentSans-Regular", size: 42)
            ?? .systemFont(ofSize: 42, weight: .regular)
        static let titleBoldFont: UIFont = UIFont(name: "InstrumentSans-Bold", size: 42)
            ?? .boldSystemFont(ofSize: 42)
    }
        
    // MARK: - Text making logic
    func makeGalleryIntroText() -> NSAttributedString {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: Const.galleryIntroText1,
            attributes: [
                .font: Const.titleFont,
                .foregroundColor: UIColor.black
            ]
        )
        
        attributedText.append(
            NSAttributedString(
                string: Const.galleryIntroText2,
                attributes: [
                    .font: Const.titleBoldFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        attributedText.append(
            NSAttributedString(
                string: Const.galleryIntroText3,
                attributes: [
                    .font: Const.titleFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        return attributedText
    }
    
    func makeFavouritesIntroText() -> NSAttributedString {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: Const.favIntroText1,
            attributes: [
                .font: Const.titleFont,
                .foregroundColor: UIColor.black
            ]
        )
        
        attributedText.append(
            NSAttributedString(
                string: Const.favIntroText2,
                attributes: [
                    .font: Const.titleBoldFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        attributedText.append(
            NSAttributedString(
                string: Const.favIntroText3,
                attributes: [
                    .font: Const.titleFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        return attributedText
    }

    func makeMoodPickText() -> NSAttributedString {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: Const.moodPickText1,
            attributes: [
                .font: Const.titleFont,
                .foregroundColor: UIColor.black,
            ]
        )
        
        attributedText.append(
            NSAttributedString(
                string: Const.moodPickText2,
                attributes: [
                    .font: Const.titleBoldFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        attributedText.append(
            NSAttributedString(
                string: Const.moodPickText3,
                attributes: [
                    .font: Const.titleFont,
                    .foregroundColor: UIColor.black
                ]
            )
        )
        
        return attributedText
    }
}
