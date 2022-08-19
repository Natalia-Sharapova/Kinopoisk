//
//  UIButton+Extension.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 03.08.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String?,
                     cornerRadius: CGFloat = 5,
                     backgroundColor: UIColor,
                     titleColor: UIColor) {
        
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
}
