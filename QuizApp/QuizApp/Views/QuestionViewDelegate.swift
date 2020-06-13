//
//  QuestionViewDelegate.swift
//  QuizApp
//
//  Created by Lorena Boroš on 10/05/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import UIKit

public protocol QuestionViewDelegate {
    func buttonTapped(answer: Int, correctAnswer: Int)
}
