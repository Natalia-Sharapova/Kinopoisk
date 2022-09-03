//
//  PosterCollectionViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 08.05.2022.
//

import UIKit
import SDWebImage

class PosterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Propeties
    private let posterImageView = UIImageView(contentMode: .scaleAspectFill, cornerRadius: 8)
    private let ratingKinopoiskLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 12), cornerRadius: 4, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        ratingKinopoiskLabel.clipsToBounds = true
        posterImageView.clipsToBounds = true
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(ratingKinopoiskLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.frame = CGRect(x: 0, y: 0, width: 130, height: 200)
        ratingKinopoiskLabel.frame = CGRect(x: -5, y: 5, width: 48, height: 20)
    }
    
    // Configure the cell if fetched rating is string
    public func configure(with model: String, ratingString: String) {
        
        guard let url = URL(string: model) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        
        let ratingDouble = Double(ratingString) ?? 0.0
        
        // Set the label's color depends on the rating
        if ratingDouble < 7 {
            ratingKinopoiskLabel.backgroundColor = .systemGray
        } else {
            ratingKinopoiskLabel.backgroundColor = .systemGreen
        }
        ratingKinopoiskLabel.text = ratingString
    }
    
    // Configure the cell if fetched rating is double
    public func configure(with model: String, ratingDouble: Double) {
        
        guard let url = URL(string: model) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        
        if ratingDouble < 7 {
            ratingKinopoiskLabel.backgroundColor = .systemGray
        } else {
            ratingKinopoiskLabel.backgroundColor = .systemGreen
        }
        ratingKinopoiskLabel.text = String(format: "%.1f", ratingDouble)
    }
    
    // Configure the cell with the poster
    public func configure(with model: String) {
        
        guard let url = URL(string: model) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
