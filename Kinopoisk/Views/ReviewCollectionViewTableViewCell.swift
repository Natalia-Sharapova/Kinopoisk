//
//  ReviewCollectionViewTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 20.05.2022.
//

import UIKit

protocol ReviewCollectionViewTableViewCellDelegate: AnyObject {
    
    func collectionViewCellDidTapCell(_ cell: ReviewCollectionViewTableViewCell, with review: VideoReview)
}

class ReviewCollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var reviews = [VideoReview]()
    
    weak var delegate: ReviewCollectionViewTableViewCellDelegate?
    
    private let reviewCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: 300, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.reviewCollectionViewCell.rawValue)
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(reviewCollectionView)
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        reviewCollectionView.frame = contentView.bounds
    }
    
    func configure(with reviews: [VideoReview]) {
        self.reviews = reviews
        
        DispatchQueue.main.async { [weak self] in
            self?.reviewCollectionView.reloadData()
        }
    }
}
// MARK: - Extensions
extension ReviewCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.reviewCollectionViewCell.rawValue, for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
        
        let review = reviews[indexPath.row]
        cell.configure(with: review)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let review = reviews[indexPath.row]
        
        self.delegate?.collectionViewCellDidTapCell(self, with: review)
    }
}
