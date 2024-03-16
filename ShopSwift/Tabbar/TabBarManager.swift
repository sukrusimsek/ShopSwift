//
//  TabBarManager.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 16.03.2024.
//

import UIKit

class TabBarManager: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.selectedIndex = 0
        self.tabBar.barTintColor = .systemGray6
        self.tabBar.tintColor = .link
        
    }
    
    private func setupTabs() {
        let homeView = self.createNav(with: "Home", image: UIImage(systemName: "house.fill"), vcName: HomeView())
        let profileView = self.createNav(with: "Profile", image: UIImage(systemName: "person.crop.circle"), vcName: ProfileView())
        let cartView = self.createNav(with: "Cart", image: UIImage(systemName: "cart"), vcName: CartView())
        let favoriteView = self.createNav(with: "Favorites", image: UIImage(systemName: "heart.fill"), vcName: FavoriteView())
        
        
        self.setViewControllers([homeView, cartView, favoriteView, profileView], animated: true)
    }
    private func createNav(with title: String, image: UIImage?, vcName: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vcName)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        
        return nav
    }

}
