//
//  TrailerCollectionViewTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 16.05.2022.
//

import UIKit

class TrailerCollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TrailerCollectionViewTableViewCell"
    
    private var videos = [VideoKinopoisk]()
    
    private let trailerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TrailerCollectionViewCell.self, forCellWithReuseIdentifier: TrailerCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(trailerCollectionView)
        trailerCollectionView.delegate = self
        trailerCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trailerCollectionView.frame = contentView.bounds
    }
    
    func configure(with videos: [VideoKinopoisk]) {
        self.videos = videos
        
        DispatchQueue.main.async { [weak self] in
            self?.trailerCollectionView.reloadData()
        }
    }
}

// MARK: - Extensions

extension TrailerCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: TrailerCollectionViewCell.identifier, for: indexPath) as? TrailerCollectionViewCell else { return UICollectionViewCell() }
        
        let video = videos[indexPath.row]
        
        guard let url = video.url else { return UICollectionViewCell() }
        
        cell.configure(with: url)
        return cell
    }
}
