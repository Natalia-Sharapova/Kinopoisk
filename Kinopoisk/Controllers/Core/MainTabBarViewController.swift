//
//  MainTabBarViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MediaViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.title = "Главное"
        vc2.title = "Медиа"
        vc3.title = "Поиск"
        vc4.title = "Сохраненное"
        
        tabBar.tintColor = .orange
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }
}
