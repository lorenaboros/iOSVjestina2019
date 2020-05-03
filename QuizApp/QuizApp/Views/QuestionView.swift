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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
