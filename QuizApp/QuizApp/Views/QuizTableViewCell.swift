//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by Lorena Boroš on 03/05/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import UIKit

class QuizTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quizDescription: UILabel!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var oneRating: UIImageView!
    @IBOutlet weak var threeRating: UIImageView!
    @IBOutlet weak var twoRating: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        quizTitle.text = ""
        quizDescription.text = ""
        quizImage?.image = nil
    }
    
    func setup(withQuiz quiz: Quiz) {
        quizTitle.text = quiz.title
        quizDescription.text = quiz.description
        
        guard let url = quiz.image else {
            quizImage.isHidden = true
            return
        }
        let data = try? Data(contentsOf: url)
        self.quizImage.image = UIImage(data: data!)
        
        switch quiz.level {
        case 1:
            self.oneRating.isHidden = false
        case 2:
            self.oneRating.isHidden = false
            self.twoRating.isHidden = false
        case 3:
            self.oneRating.isHidden = false
            self.twoRating.isHidden = false
            self.threeRating.isHidden = false
        default:
            self.oneRating.isHidden = true
            self.twoRating.isHidden = true
            self.threeRating.isHidden = true
        }
    }
}
