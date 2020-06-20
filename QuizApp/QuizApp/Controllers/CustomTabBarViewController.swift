//
//  CustomTabBarViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 16/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarViewController: UITabBarController {
    
    func initTabBar() {
        let firstViewController = QuizViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Quizzes", image: UIImage(named: "quiz.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        let secondViewController = SearchViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
         let thirdViewController = SettingsViewController()
         thirdViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        let controllers = [UINavigationController(rootViewController: firstViewController),
                           UINavigationController(rootViewController: secondViewController), thirdViewController]
        self.viewControllers = controllers
    }
}
