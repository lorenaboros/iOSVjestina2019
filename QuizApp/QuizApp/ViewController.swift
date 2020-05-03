//
//  ViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 25/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        print("\(sender.currentTitle) button tap! Username: " + usernameField.text! + ", Password: " + passwordField.text!)
    }
}
