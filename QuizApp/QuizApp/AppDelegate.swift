//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Lorena Boroš on 25/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { 
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let shouldShowLogin = checkForAuthToken()
        var vc : UIViewController
        
        if shouldShowLogin {
            vc = InitialViewController()
        }else {
            vc = QuizViewController()
        }
        
        let navigationController = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func checkForAuthToken() -> Bool {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "authToken")
        if value == "" || value == nil {
            return true
        }else {
            return false
        }
    }
}
