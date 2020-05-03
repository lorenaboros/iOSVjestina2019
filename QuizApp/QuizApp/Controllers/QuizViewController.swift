//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    

    @IBOutlet weak var quizTableView: UITableView!
    
    @IBOutlet weak var errorMessageField: UILabel!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var getQuizButton: UIButton!
    @IBOutlet weak var NBAfunFactView: UILabel!
    
    var quizzes: [Quiz]?
    var refreshControl: UIRefreshControl!
     let cellReuseIdentifier = "cellReuseIdentifier"
    
    @IBAction func getQuizzesButtonClicked(_ sender: UIButton) {
        setupTableView()
        setupData()
    }
    
    
    func setupTableView() {
        refreshControl = UIRefreshControl()
        quizTableView.dataSource = self
        quizTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(QuizViewController.refresh), for: UIControl.Event.valueChanged)
        quizTableView.refreshControl = refreshControl
        
        
        quizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
    }
    
    func setupData() {
        let quizService = QuizService()
          quizService.fetchQuizes() { [weak self] (quizzes) in
          guard let self = self else { return }
            DispatchQueue.main.async {
              if let quizzes = quizzes {
                self.quizzes = quizzes.quizzes
                self.refresh()
                 self.computeNBAcount(quizzes: quizzes.quizzes)
            }else {
                self.mapToEmptyStateView()
            }
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
           
            self.quizTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.quizTableView.isHidden = false
        }
    }
    
    private func mapToEmptyStateView() {
        errorTitle.isHidden = false
        errorImageView.isHidden = false
        errorMessageField.isHidden = false
    }
    
    func quiz(atIndex index: Int) -> Quiz? {
        guard let quizzes = quizzes else {
            return nil
        }
        
        return quizzes[index]
    }
    
    func numberOfQuizzes() -> Int {
        return quizzes?.count ?? 0
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
    
    func createQuiz(withText title: String, description: String, image: URL, category: QuizCategory, level: Int, questions: [Question], id: Int) -> Void {
        let quiz = Quiz(title: title,description: description,image: image,category: category,level: level,questions: questions,id: id)
        quizzes?.append(quiz)
    }   
}

extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        if let quiz = quiz(atIndex: indexPath.row) {
            cell.setup(withQuiz: quiz)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfQuizzes()
    }
}






