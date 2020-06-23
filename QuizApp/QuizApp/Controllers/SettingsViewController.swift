//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 20/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameField: UILabel!
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        clearUserDefaults()
        UIApplication.shared.keyWindow?.rootViewController = InitialViewController()
    }
    
    func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "authToken")
        UserDefaults.standard.removeObject(forKey: "user_id")
    }
}
