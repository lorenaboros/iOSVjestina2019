//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionViewContrainer: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var quizCategory: UILabel!
    @IBOutlet weak var funFactView: UILabel!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var getQuizButton: UIButton!
    @IBOutlet weak var NBAfunFactView: UILabel!
    @IBOutlet weak var errorMessageField: UILabel!
    
    var correctAnswer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        fetchQuiz()
    }
    
    private func fetchQuiz() {
        let quizService = QuizService()
        quizService.fetchQuizes() { [weak self] (quizzes) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.mapToView(quiz: quizzes.quizzes[0])
                    self.computeNBAcount(quizzes: quizzes.quizzes)
                } else {
                    self.mapToEmptyStateView()
                }
            }
        }
    }
    
    private func mapToEmptyStateView() {
        errorTitle.isHidden = false
        errorImageView.isHidden = false
        errorMessageField.isHidden = false
    }
    
    private func mapToView(quiz: Quiz){
        addCustomView(question: quiz.questions[0])
        quizTitle.text = quiz.title
        
       if let url = quiz.image {
           let data = try? Data(contentsOf: url)
           self.quizImageView.image = UIImage(data: data!)
        }
        
        switch quiz.category {
            case .SCIENCE:
                quizCategory.text = "SCIENCE"
                quizTitle.backgroundColor = .green
                quizImageView.backgroundColor = .green
            case .SPORTS:
                quizCategory.text = "SPORTS"
                quizTitle.backgroundColor = UIColor.blue
                quizImageView.backgroundColor = UIColor.blue
        }
        
        NBAfunFactView.isHidden = false
        quizCategory.isHidden = false
        quizTitle.isHidden = false
        quizImageView.isHidden = false
    }
    
    private func computeNBAcount(quizzes: [Quiz]) {
        let NBAcount = quizzes
            .map{ $0.questions }
            .flatMap { $0 }
            .map{ $0.question }
            .filter{$0.contains("NBA")}
            .count
        NBAfunFactView.text = "There are \(NBAcount) questions that contain the word “NBA.”"
        NBAfunFactView.isHidden = false
    }
    
    func addCustomView(question: Question) {
        guard let customView = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView else {
            return
        }
        questionViewContrainer.addSubview(customView)
        customView.questionField.text = question.question
        customView.button0Answer.setTitle(question.answers[0], for: .normal)
        customView.button1Answer.setTitle(question.answers[1], for: .normal)
        customView.button2Answer.setTitle(question.answers[2], for: .normal)
        customView.button3Answer.setTitle(question.answers[3], for: .normal)
        
        correctAnswer = question.answers[question.correct_answer]
        
        customView.button0Answer.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        customView.button1Answer.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        customView.button2Answer.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        customView.button3Answer.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc private func buttonClicked(_ sender: AnyObject?){
        guard let button: UIButton = sender as? UIButton else {
            return
        }
        if button.title(for: .normal) == correctAnswer {
            button.backgroundColor = UIColor.green
        } else {
            button.backgroundColor = UIColor.red
        }
    }
}
