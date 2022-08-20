//
//  TrailerCollectionViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 16.05.2022.
//

import UIKit
import WebKit

class TrailerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
  private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.contentMode = .scaleToFill
        webView.layer.cornerRadius = 8
        webView.clipsToBounds = true
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        webView.frame = contentView.bounds
    }
    
    func configure(with url: String) {
        
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
}
