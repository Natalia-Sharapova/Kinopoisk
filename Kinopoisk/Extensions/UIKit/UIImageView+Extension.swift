//
//  UIImageView+Extension.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 03.08.2022.
//

import UIKit

extension UIImageView {
    
    convenience init(contentMode: UIImageView.ContentMode, cornerRadius: CGFloat) {
        self.init()
        self.layer.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }
}
