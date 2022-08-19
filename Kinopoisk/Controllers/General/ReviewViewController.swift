//
//  ReviewViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 25.05.2022.
//

import UIKit

enum RatingReview: String {
    
    case NEGATIVE
    case POSITIVE
    case NEUTRAL
}

class ReviewViewController: UIViewController {
    
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
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let reviewLabel: UILabel = {
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Отзыв"
        return label
    }()
    
    private let dateLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var nameStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let positiveLabel: UILabel = {
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let negativeLabel: UILabel = {
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let cancelButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12.5
        button.tintColor = .darkGray
        return button
    }()
    
    private let ratingLabel: UILabel = {
        
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - VC methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
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
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupViews() {
        
        view.addSubview(ratingLabel)
        ratingLabel.widthAnchor.constraint(equalToConstant: 5).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(reviewLabel)
        reviewLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        reviewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reviewLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(nameStackView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(dateLabel)
        
        nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nameStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor).isActive = true
        nameStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        nameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        view.addSubview(ratingStackView)
        ratingStackView.addArrangedSubview(positiveLabel)
        ratingStackView.addArrangedSubview(negativeLabel)
        
        ratingStackView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120).isActive = true
        ratingStackView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        ratingStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ratingStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configure(with review: VideoReview) {
        
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
