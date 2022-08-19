//
//  UIStackView+Extension.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 19.08.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, spacing: CGFloat) {
        self.init()
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
