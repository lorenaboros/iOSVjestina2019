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
    
    override func viewDidAppear(_ animated: Bool) {
        animateViewsIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameCenterConstraint.constant -= view.bounds.width
        passwordCenterConstraint.constant -= view.bounds.width
        loginButtonCenterConstraint.constant -= view.bounds.width
    }
    
    private func animateViewsIn() {
        appLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.7) {
            self.appLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        usernameCenterConstraint.constant = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
                        self?.usernameField.alpha = 1
            }, completion: nil)
        
        passwordCenterConstraint.constant = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0.6,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
                        self?.passwordField.alpha = 1
            }, completion: nil)
        
        loginButtonCenterConstraint.constant = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0.9,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
                        self?.loginButton.alpha = 1
            }, completion: nil)
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
                guard let loginResponse = loginResponse else {
                    self.loginFailedField.isHidden = false
                    return
                }
                self.loginFailedField.isHidden = true
                self.animateViewsOut()
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(loginResponse.token,forKey: "authToken")
                userDefaults.set(loginResponse.user_id,forKey: "user_id")
                let quizViewController = QuizViewController()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    self.navigationController?.pushViewController(quizViewController, animated: true)
                })
            }
        }
    }
    
    private func animateViewsOut() {
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.appLabel.center = CGPoint(x: self.view.frame.width/2, y: 0)
                        self.appLabel.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       animations: {
                        self.usernameField.center = CGPoint(x: self.view.frame.width/2, y: 0)
                        self.usernameField.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.6,
                       animations: {
                        self.passwordField.center = CGPoint(x: self.view.frame.width/2, y: 0)
                        self.passwordField.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.9,
                       animations: {
                        self.loginButton.center = CGPoint(x: self.view.frame.width/2, y: 0)
                        self.loginButton.alpha = 0.0
        }, completion: nil)
    }
}
