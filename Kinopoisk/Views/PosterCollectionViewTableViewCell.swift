//
//  PosterCollectionViewTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    
    func collectionViewCellDidTapCell(_ cell: PosterCollectionViewTableViewCell, with item: Item)
}

class PosterCollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var items = [Item]()
   
    private let posterCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.posterCollectionViewCell.rawValue)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(posterCollectionView)
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterCollectionView.frame = contentView.bounds
    }
    
    // Download the item to the DataBase
    private func downloadItemAt(indexPath: IndexPath) {
        
        DataPersistenceManager.shared.downloadItemFith(model: items[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func configureItems(with items: [Item]) {
        self.items = items
        
        DispatchQueue.main.async { [weak self] in
            self?.posterCollectionView.reloadData()
        }
    }
}

// MARK: - Extensions
extension PosterCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.posterCollectionViewCell.rawValue, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = (items[indexPath.row].posterUrlPreview != nil) ? items[indexPath.row].posterUrlPreview : items[indexPath.row].posterUrl else { return UICollectionViewCell() }
        
        // Configure the cell depends on the rating's type
        if let rating = items[indexPath.row].ratingKinopoisk {
            cell.configure(with: model, ratingDouble: rating)
            
        } else if let rating = items[indexPath.row].ratingImdb {
            cell.configure(with: model, ratingDouble: rating)
            
        } else if let rating = items[indexPath.row].rating {
            cell.configure(with: model, ratingString: rating)
            
        } else {
            cell.configure(with: model, ratingString: "Скоро")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = items[indexPath.row]
        self.delegate?.collectionViewCellDidTapCell(self, with: item)
    }
    
    // Set context menu
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) { _ in
            let action = UIAction(title: "Download",
                                  image: UIImage(systemName: "arrow.down.to.line"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  state: .off) { _ in
                self.downloadItemAt(indexPath: indexPath)
            }
                                                    
          return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [action])
        }
        return config
    }
}
