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
    var sections: Set<QuizCategory>!
    
    @IBAction func getQuizzesButtonClicked(_ sender: UIButton) {
        setupTableView()
        setupData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizTableView.register(QuizSectionHeader.self,forHeaderFooterViewReuseIdentifier: "sectionHeader")
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
            if let quizzes = quizzes {
                self.quizzes = quizzes.quizzes
                self.sections = self.getSelections()
                self.refresh()
                self.computeNBAcount(quizzes: quizzes.quizzes)
            }
            else {
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
    
    func quiz(section: Int, row: Int) -> Quiz? {
        guard let quizzes = quizzes else {
            return nil
        }
        if (section==0){
            return quizzes.filter{$0.category == QuizCategory.SPORTS}[row]
        }
        else {
            return quizzes.filter{$0.category == QuizCategory.SCIENCE}[row]
        }
    }
    
    func getSelections() -> Set<QuizCategory> {
        if let pom = quizzes {
            return Set(pom.map{$0.category})
        }
        else {
            return Set<QuizCategory>()
        }
    }
    
    func numberOfQuizzes() -> Int {
        if let pom = quizzes {
            return Set(pom.map{$0.category}).count
        }
        else {
            return 0
        }
    }
    
    private func computeNBAcount(quizzes: [Quiz]) {
        DispatchQueue.main.async {
            let NBAcount = quizzes.map({$0.questions}).flatMap { $0 }.map{$0.question}.filter{$0.contains("NBA")}.count
            self.NBAfunFactView.text = "There are " + String(NBAcount) + " questions that contain the word “NBA.”"
            self.NBAfunFactView.isHidden = false
        }
    }
    
    func createQuiz(withText title: String, description: String, image: URL, category: QuizCategory, level: Int, questions: [Question], id: Int) -> Void {
        let quiz = Quiz(title: title,description: description,image: image,category: category,level: level,questions: questions,id: id)
        quizzes?.append(quiz)
    }   
}

extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = quizTableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as! QuizSectionHeader
        view.title.text = Array(sections)[section].rawValue
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let quiz = quiz(section: indexPath.section, row: indexPath.row) {
            let selectedQuizViewController = SelectedQuizViewController()
            selectedQuizViewController.quiz = quiz
            navigationController?.pushViewController(selectedQuizViewController, animated: true)
        }
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        if let quiz = quiz(section: indexPath.section,row: indexPath.row) {
            cell.setup(withQuiz: quiz)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfQuizzes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==0){
            return quizzes?.filter{$0.category == QuizCategory.SPORTS}.count ?? 0
        }
        else {
            return quizzes?.filter{$0.category == QuizCategory.SCIENCE}.count ?? 0
        }
    }
}






