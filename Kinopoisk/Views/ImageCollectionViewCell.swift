//
//  ImageCollectionViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 20.05.2022.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let posterImageView = UIImageView(contentMode: .scaleAspectFit, cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        posterImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        
        guard let url = URL(string: model) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
