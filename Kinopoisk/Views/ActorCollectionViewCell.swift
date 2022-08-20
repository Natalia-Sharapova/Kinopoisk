//
//  ActorCollectionViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 17.05.2022.
//

import UIKit
import SDWebImage

enum Identifier: String {
    case actorCollectionViewCell
    case actorCollectionViewTableViewCell
    case posterCollectionViewCell
    case posterCollectionViewTableViewCell
    case trailerCollectionViewCell
    case trailerCollectionViewTableViewCell
    case imageCollectionViewTableViewCell
    case imageCollectionViewCell
    case reviewCollectionViewTableViewCell
    case reviewCollectionViewCell
    case ratingKinipoiskTableViewCell
    case actorsFilmTableViewCell
    case movieTableViewCell
}

class ActorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let actorImageView = UIImageView(contentMode: .scaleAspectFill, cornerRadius: 8)
    private let nameRuLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 14), cornerRadius: 0, textAlignment: .left)
    private let nameEnLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 12), cornerRadius: 0, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        actorImageView.clipsToBounds = true
        nameRuLabel.clipsToBounds = true
        nameEnLabel.clipsToBounds = true
        
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.orange.cgColor
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.black.cgColor
        
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameRuLabel)
        contentView.addSubview(nameEnLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        actorImageView.frame = CGRect(x: 5, y: 10, width: 50, height: 70)
        nameRuLabel.frame = CGRect(x: 65, y: 30, width: 150, height: 20)
        nameEnLabel.frame = CGRect(x: 65, y: 55, width: 150, height: 20)
    }
    
    func configure(with actor: Actors) {
        guard let urlString = actor.posterUrl else { return }
        guard let url = URL(string: urlString) else { return }
        guard let nameRu = actor.nameRu, let nameEn = actor.nameEn else { return }
        
        actorImageView.sd_setImage(with: url, completed: nil)
        nameRuLabel.text = nameRu
        nameEnLabel.text = nameEn
    }
}
