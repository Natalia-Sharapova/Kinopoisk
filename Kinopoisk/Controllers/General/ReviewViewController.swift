//
//  ReviewViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 25.05.2022.
//

import UIKit

private enum RatingReview: String {
    
    case NEGATIVE
    case POSITIVE
    case NEUTRAL
}

final class ReviewViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let nameLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 20), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let reviewLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 20), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    private let dateLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 14), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    
    private lazy var nameStackView = UIStackView(axis: .vertical, distribution: .fill, alignment: .leading, spacing: 5)
    private lazy var ratingStackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .leading, spacing: 5)
     
    private let positiveLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 15), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let negativeLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 15), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
   
    private let titleLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 25), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let descriptionLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 14), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    private let ratingLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 14), cornerRadius: 4, numberOfLines: 0, textAlignment: .center)
        
    private let cancelButton = UIButton(title: "", cornerRadius: 12.5, backgroundColor: .lightGray, titleColor: .blue)
        
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.adjustsFontSizeToFitWidth = true
        ratingLabel.clipsToBounds = true
            
        reviewLabel.text = "Отзыв"
        
        cancelButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        
        cancelButton.tintColor = .darkGray
        
        setupScrollView()
        setupViews()
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Methods
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupViews() {
        
        view.addSubview(ratingLabel)
        view.addSubview(cancelButton)
        view.addSubview(reviewLabel)
       
        view.addSubview(nameStackView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(dateLabel)
        
        view.addSubview(ratingStackView)
        ratingStackView.addArrangedSubview(positiveLabel)
        ratingStackView.addArrangedSubview(negativeLabel)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            ratingLabel.widthAnchor.constraint(equalToConstant: 5),
            ratingLabel.heightAnchor.constraint(equalToConstant: 40),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            ratingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            cancelButton.widthAnchor.constraint(equalToConstant: 25),
            cancelButton.heightAnchor.constraint(equalToConstant: 25),
            
            reviewLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            reviewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor),
            nameStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            nameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            ratingStackView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            ratingStackView.widthAnchor.constraint(equalToConstant: 90),
            ratingStackView.heightAnchor.constraint(equalToConstant: 40),
            ratingStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
   public func configure(with review: VideoReview) {
        
        if let name = review.author,
           let date = review.date,
           let rating = review.type {
            nameLabel.text = name
            dateLabel.text = date.formattedDate(from: date)
            
            switch rating {
            case RatingReview.NEGATIVE.rawValue:
                ratingLabel.backgroundColor = .red
                
            case RatingReview.POSITIVE.rawValue:
                ratingLabel.backgroundColor = .systemGreen
                
            case RatingReview.NEUTRAL.rawValue:
                ratingLabel.backgroundColor = .systemGray
            default:
                break
            }
            
            if let positive = review.positiveRating,
               let negative = review.negativeRating {
                positiveLabel.text = "👍" + String(positive)
                negativeLabel.text = "👎" + String(negative)
            }
            
            if let title = review.title,
               let description = review.description {
                titleLabel.text = title
                descriptionLabel.text = description
            }
        }
    }
}
