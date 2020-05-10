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
    
    @IBAction func keyboardDidFinish(_ sender: UITextField) {
    }
    
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
                }
                else {
                    //self.mapToEmptyStateView()
                }
            }
        }
    }
}
