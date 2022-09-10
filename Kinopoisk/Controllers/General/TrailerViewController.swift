//
//  TrailerViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 09.06.2022.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    //MARK: - Properties
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addSubview(nameLabel)
        
        setConstrains()
    }
    
    // MARK: - Methods
    
    private func setConstrains() {
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        webView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
    }
    
    func configure(with movieName: String, youtubeVideo: VideoElements) {
        
        nameLabel.text = movieName
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(youtubeVideo.id.videoId)") else { return }
        
        webView.load(URLRequest(url: url))
    }
}

