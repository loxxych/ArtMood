//
//  OutlineLabel.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

final class OutlineLabel: UILabel {
    // MARK: - Constants
    private enum Const {
        static let strokeColor: UIColor = UIColor(named: "NeonGreen") ?? .systemGreen
        static let fillColor: UIColor = .clear
        static let strokeWidth: CGFloat = -4
        static let outlineWidth: CGFloat = 1
    }
    
    override func drawText(in rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            super.drawText(in: rect)
            return
        }
        
        let textColor = self.textColor
        
        context.setLineWidth(Const.outlineWidth)
        context.setLineJoin(.round)
        
        context.setTextDrawingMode(.stroke)
        self.textColor = Const.strokeColor
        super.drawText(in: rect)
        
        context.setTextDrawingMode(.fill)
        self.textColor = Const.fillColor
        super.drawText(in: rect)
        
        self.textColor = textColor
    }
}
