//
//  TabBarViewController.swift
//  Instagram
//
//  Created by Babak Kiaie on 6/9/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let email = UserDefaults.standard.string(forKey: "email"),
              let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        let currentUser = User(username: username, email: email)
        
        // Define VCs
        let home = HomeViewController()
        let competition = CompetitionVC()
       
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: competition)
        
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label

        
        //Define tab items
        nav1.tabBarItem = UITabBarItem(title: currentUser.username, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Competition", image: UIImage(systemName: "safari"), tag: 1)
        
        
        self.setViewControllers([nav1, nav2], animated: false)
        
    }

}
