//
//  RatingKinipoiskTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 22.05.2022.
//

import UIKit

class RatingKinipoiskTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var item: Item!
    
    private let ratingKinopoiskLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 60), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let ratingCountLabel = UILabel(textColor: .systemGray, font: .systemFont(ofSize: 15), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.orange.cgColor
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.black.cgColor
        
        contentView.addSubview(ratingKinopoiskLabel)
        contentView.addSubview(ratingCountLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureRating(with rating: String) {
        
        guard let ratingDouble = Double(rating) else {
            ratingKinopoiskLabel.text = rating
            return }
        
        if ratingDouble < 7 {
            ratingKinopoiskLabel.textColor = .systemGray
        } else {
            ratingKinopoiskLabel.textColor = .systemGreen
        }
        ratingKinopoiskLabel.text = String(format: "%.1f", ratingDouble)
    }
    
    func configureRatingCount(with ratingCount: Int) {
        ratingCountLabel.text = String(ratingCount) + " оценок"
    }
    
    private func setConstraints() {
        
        ratingKinopoiskLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingKinopoiskLabel.adjustsFontSizeToFitWidth = true
        ratingKinopoiskLabel.minimumScaleFactor = 0.5
        ratingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingKinopoiskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        ratingKinopoiskLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ratingKinopoiskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        ratingKinopoiskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        ratingCountLabel.topAnchor.constraint(equalTo: ratingKinopoiskLabel.bottomAnchor, constant: 15).isActive = true
        ratingCountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
