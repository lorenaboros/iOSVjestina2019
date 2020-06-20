//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 18/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchInputField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchText: String = ""
    var quizzes: [QuizEntity]?
    var refreshControl: UIRefreshControl!
    let cellReuseIdentifier = "cellReuseIdentifier"
    var sections: Set<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(QuizSectionHeader.self,forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        if(searchText != searchInputField.text) {
            searchText = searchInputField.text ?? ""
        }
        setupTableView()
        setupData(searchParam: searchText)
    }
    
    func setupTableView() {
        refreshControl = UIRefreshControl()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(SearchViewController.refresh), for: UIControl.Event.valueChanged)
        searchTableView.refreshControl = refreshControl
        searchTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func setupData(searchParam: String) {
        self.quizzes = DataController.shared.fetchQuizzess(searchParam: searchParam)
        if quizzes?.count == 0 {
            searchTableView.isHidden = true
        }else {
            searchTableView.isHidden = false
        }
        self.sections = self.getSections()
        self.refresh()
    }
    
    func quiz(section: Int, row: Int) -> Quiz? {
        guard let quizzes = quizzes else {
            return nil
        }
        if section==0 {
            return mapQuizEntityToQuiz(quizEntity: quizzes.filter{$0.category == QuizCategory.SPORTS.rawValue}[row])
        } else {
            return mapQuizEntityToQuiz(quizEntity: quizzes.filter{$0.category == QuizCategory.SCIENCE.rawValue}[row])
        }
    }
    
    func mapQuizEntityToQuiz(quizEntity: QuizEntity) -> Quiz? {
        guard let image = quizEntity.image else {
            return Quiz(title: quizEntity.title,
                        description: quizEntity.quizDescription,
                        image: nil,
                        category: mapToEnum(category: quizEntity.category),
                        level: quizEntity.level,
                        questions: [Question](),
                        id: quizEntity.id)
        }
        let quiz = Quiz(title: quizEntity.title,
                        description: quizEntity.quizDescription,
                        image: URL(string: image),
                        category: mapToEnum(category: quizEntity.category),
                        level: quizEntity.level,
                        questions: [Question](),
                        id: quizEntity.id)
        return quiz
    }
    
    func mapToEnum(category: String) -> QuizCategory {
        if category == "SPORTS" {
            return QuizCategory.SPORTS
        } else {
            return QuizCategory.SCIENCE
        }
    }
    
    private func getSections() -> Set<String> {
        guard let quizzes = quizzes else {
            return Set<String>()
        }
        return Set(quizzes.map{$0.category})
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = searchTableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as! QuizSectionHeader
        view.title.text = Array(sections)[section]
        
        if Array(sections)[section] == QuizCategory.SPORTS.rawValue {
            view.title.textColor = UIColor.blue
        } else {
            view.title.textColor = UIColor.red
        }
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
            let navViewController = self.tabBarController?.selectedViewController as? UINavigationController
            navViewController?.pushViewController(selectedQuizViewController, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        guard let quiz = quiz(section: indexPath.section,row: indexPath.row) else {
            return cell
        }
        cell.setup(withQuiz: quiz)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let quizzes = quizzes else {
            return 0
        }
        return Set(quizzes.map{$0.category}).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return quizzes?.filter{$0.category == QuizCategory.SPORTS.rawValue}.count ?? 0
        } else {
            return quizzes?.filter{$0.category == QuizCategory.SCIENCE.rawValue}.count ?? 0
        }
    }
}

