//
//  ImageCollectionViewTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 20.05.2022.
//

import UIKit

final class ImageCollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var images = [VideoImages]()
    
    private let imageCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.imageCollectionViewCell.rawValue)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageCollectionView)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCollectionView.frame = contentView.bounds
    }
    
    func configure(with images: [VideoImages]) {
        self.images = images
        
        DispatchQueue.main.async { [weak self] in
            self?.imageCollectionView.reloadData()
        }
    }
}
// MARK: - Extensions
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ImageCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.imageCollectionViewCell.rawValue, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = images[indexPath.row].imageUrl else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
}

