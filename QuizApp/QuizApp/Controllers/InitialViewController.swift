//
//  InitialViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var loginFailedField: UILabel!
    
    @IBOutlet weak var loginButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordCenterConstraint: NSLayoutConstraint!
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        loginUser()
    }
    
    private func loginUser() {
        guard let username = usernameField.text else {
            return
        }
        
        guard let password = passwordField.text else {
            return
        }
        
        let loginService = LoginService()
        loginService.loginUser(password: password,username: username) { (loginResponse) in
            DispatchQueue.main.async {
                if let loginResponse = loginResponse {
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(loginResponse.token,forKey: "authToken")
                    userDefaults.set(loginResponse.user_id,forKey: "user_id")
                    let quizViewController = QuizViewController()
                    self.navigationController?.pushViewController(quizViewController, animated: true)
                }
                else {
                    self.loginFailedField.isHidden = false
                }
            }
        }
    }
}
