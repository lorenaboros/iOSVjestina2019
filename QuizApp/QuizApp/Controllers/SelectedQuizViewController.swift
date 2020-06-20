//
//  SelectedQuizViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 06/05/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class SelectedQuizViewController: UIViewController, QuestionViewDelegate {

    @IBOutlet weak var quizTitleField: UILabel!
    @IBOutlet weak var quizDescriptionField: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var quiz: Quiz? = nil
    var questions: [QuestionView] = []
    var correctAnswersCounter: Int = 0
    var quizStartedTime: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let quiz = quiz else {
            return
        }
        quizTitleField.text = quiz.title
        quizDescriptionField.text = quiz.description
        
        guard let url = quiz.image else {
            quizImageView.isHidden = true
            return
        }
        let data = try? Data(contentsOf: url)
        quizImageView.image = UIImage(data: data!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        questions = createQuestions()
        setupQuestionScrollView(questions: questions)
        pageControl.numberOfPages = questions.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    @IBAction func leaderboardButtonClick(_ sender: Any) {
        let leaderboardViewController = LeaderboardViewController()
        leaderboardViewController.quizId = quiz?.id
        navigationController?.pushViewController(leaderboardViewController, animated: true)
    }
    
    @IBAction func onStartQuizButtonClicked(_ sender: UIButton) {
        scrollView.isHidden = false
        pageControl.isHidden = false
        quizStartedTime = Date()
    }
    
    private func createQuestions() -> [QuestionView] {
        var questions: [QuestionView] = []
        
        guard let quiz = quiz else{
            return []
        }
        for i in 0..<quiz.questions.count {
            
            guard let customView = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView else {
                return []
            }
            customView.correctAnswer = quiz.questions[i].correct_answer
            customView.questionField.text = quiz.questions[i].question
            customView.delegate = self
            
            customView.button0Answer.setTitle(quiz.questions[i].answers[0], for: .normal)
            customView.button1Answer.setTitle(quiz.questions[i].answers[1], for: .normal)
            customView.button2Answer.setTitle(quiz.questions[i].answers[2], for: .normal)
            customView.button3Answer.setTitle(quiz.questions[i].answers[3], for: .normal)
            
            questions.append(customView)
        }
        return questions
    }
    
    func setupQuestionScrollView(questions : [QuestionView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(questions.count+1), height: view.frame.height)
        
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< questions.count {
            questions[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(questions[i])
        }
    }
    
    func buttonTapped(answer: Int, correctAnswer: Int) {
        if  pageControl.currentPage == (pageControl.numberOfPages-1) {
            let quizService = QuizService()
            let userDefaults = UserDefaults.standard
            let value = userDefaults.integer(forKey: "user_id")
            guard let quiz = quiz else {
                return
            }
            let quizTime = quizStartedTime.timeIntervalSinceNow
            
            quizService.sendResults(quiz_id: quiz.id, user_id: value, time: quizTime, correctAnswers: correctAnswersCounter){ (statusCode) in
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        let offset = scrollView.contentOffset.x + scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: offset , y: 0), animated: true)
        pageControl.currentPage = pageControl.currentPage + 1
        
        if answer == correctAnswer {
            correctAnswersCounter = correctAnswersCounter + 1
        }
    }
}
