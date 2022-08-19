//
//  UILabel+Extension.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 03.08.2022.
//

import UIKit

extension UILabel {
    
    convenience init(textColor: UIColor, font: UIFont, cornerRadius: CGFloat, numberOfLines: Int  = 0, textAlignment: NSTextAlignment) {
        self.init()
        self.textColor = textColor
        self.font = font
        self.layer.cornerRadius = cornerRadius
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
}
