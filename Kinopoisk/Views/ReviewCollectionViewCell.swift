//
//  ReviewCollectionViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 21.05.2022.
//

import UIKit

enum Rating: String {
    case NEGATIVE
    case POSITIVE
    case NEUTRAL
}

class ReviewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let nameLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 14), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    private let dateLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    private let titleLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    private let descriptionLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    private let ratingLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 12), cornerRadius: 4, numberOfLines: 0, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.orange.cgColor
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.black.cgColor
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ratingLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setConstraints() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.minimumScaleFactor = 0.8
        nameLabel.clipsToBounds = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.minimumScaleFactor = 0.8
        dateLabel.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.minimumScaleFactor = 0.8
        titleLabel.clipsToBounds = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.minimumScaleFactor = 0.8
        descriptionLabel.clipsToBounds = true
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.minimumScaleFactor = 0.8
        ratingLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            titleLabel.widthAnchor.constraint(equalToConstant: 280),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            
            descriptionLabel.widthAnchor.constraint(equalToConstant: 280),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            ratingLabel.widthAnchor.constraint(equalToConstant: 5),
            ratingLabel.heightAnchor.constraint(equalToConstant: 40),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
        
        func configure(with review: VideoReview) {
            
            guard let name = review.author,
                  let date = review.date,
                  let title = review.title,
                  let description = review.description,
                  let rating = review.type
            else { return }
            
            nameLabel.text = name
            dateLabel.text = date.formattedDate(from: date)
            titleLabel.text = title
            descriptionLabel.text = description
            
            switch rating {
            
            case Rating.NEGATIVE.rawValue:
                ratingLabel.backgroundColor = .red
                
            case Rating.POSITIVE.rawValue:
                ratingLabel.backgroundColor = .systemGreen
                
            case Rating.NEUTRAL.rawValue:
                ratingLabel.backgroundColor = .systemGray
            default:
                break
            }
        }
    }

