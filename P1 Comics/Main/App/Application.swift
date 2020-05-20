//
//  Application.swift
//  P1 Comics
//
//  Created by HoaPQ on 5/20/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import UIKit

class Application {
    static let shared: Application = Application()
    
    private init() {
        
    }
    
    func initApplication(with window: UIWindow?) {
        guard let window = window else { return }
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: setUpTabbar())
    }
    
    private func setUpTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let userVC = UserViewController()
        userVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        tabbar.viewControllers = [homeVC, searchVC, userVC]
        
        return tabbar
    }
}
