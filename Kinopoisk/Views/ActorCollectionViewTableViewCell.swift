//
//  ActorCollectionViewTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 20.05.2022.
//

import UIKit

protocol ActorCollectionViewTableViewCellDelegate: AnyObject {
    
    func actorCollectionViewCellDidTapCell(_ cell: ActorCollectionViewTableViewCell, with personId: Int)
}

class ActorCollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ActorCollectionViewTableViewCell"
    private var actors = [Actors]()
    
    weak var delegate: ActorCollectionViewTableViewCellDelegate?
    var actorCollectionView = UICollectionView()
    var layout = UICollectionViewFlowLayout()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout = UICollectionViewFlowLayout(scrollDirection: .horizontal, itemSize: CGSize(width: 250, height: 90), minimumInteritemSpacing: 15, minimumLineSpacing: 15)
        
     //   layout.scrollDirection = .horizontal
       // layout.itemSize = CGSize(width: 250, height: 90)
        
        actorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout, showsHorizontalScrollIndicator: false)
        
        actorCollectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
        actorCollectionView.contentInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        
        contentView.addSubview(actorCollectionView)
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        actorCollectionView.frame = contentView.bounds
    }
    
    func configure(with actors: [Actors]) {
        self.actors = actors
        
        DispatchQueue.main.async {
            self.actorCollectionView.reloadData()
        }
    }
}

// MARK: - Extensions

extension ActorCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = actorCollectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier, for: indexPath) as? ActorCollectionViewCell else { return UICollectionViewCell() }
        
        let actor = actors[indexPath.row]
        cell.configure(with: actor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let actor = actors[indexPath.row]
        
        guard let personId = actor.staffId else { return }
        self.delegate?.actorCollectionViewCellDidTapCell(self, with: personId)
    }
}
