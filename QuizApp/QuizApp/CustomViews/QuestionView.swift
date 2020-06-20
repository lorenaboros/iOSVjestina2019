//
//  QuestionView.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import UIKit

class QuestionView: UIView {
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button0Answer: UIButton!
    @IBOutlet weak var button1Answer: UIButton!
    @IBOutlet weak var button2Answer: UIButton!
    @IBOutlet weak var button3Answer: UIButton!
    
    var correctAnswer: Int = 0
    var delegate: QuestionViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func onAnswer0Clicked(_ sender: UIButton) {
        buttonClicked(sender,answer: 0)
    }
    
    @IBAction func onAnswer1Clicked(_ sender: UIButton) {
        buttonClicked(sender,answer: 1)
    }
    
    @IBAction func onAnswer2Clicked(_ sender: UIButton) {
        buttonClicked(sender,answer: 2)
    }
    
    @IBAction func onAnswer3Clicked(_ sender: UIButton) {
        buttonClicked(sender, answer: 3)
    }
    
    @objc private func buttonClicked(_ sender: AnyObject?,  answer: Int){
        guard let button: UIButton = sender as? UIButton else {
            return
        }
        if answer == correctAnswer {
            button.backgroundColor = UIColor.green
        } else {
            button.backgroundColor = UIColor.red
        }
        delegate?.buttonTapped(answer: answer, correctAnswer: self.correctAnswer)
    }
}
