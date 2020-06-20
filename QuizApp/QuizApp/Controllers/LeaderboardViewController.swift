//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 16/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    var quizId: Int? = nil
    var playersScore: [PlayerScore]?
    @IBOutlet weak var leaderboardTableView: UITableView!
    var refreshControl: UIRefreshControl!
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
    }
    
    func setupTableView() {
        refreshControl = UIRefreshControl()
        leaderboardTableView.dataSource = self
        leaderboardTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(LeaderboardViewController.refresh), for: UIControl.Event.valueChanged)
        leaderboardTableView.refreshControl = refreshControl
        leaderboardTableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupData() {
        let leaderboardService = LeaderboardService()
        guard let quizId = quizId else {
            return
        }
        leaderboardService.fetchLeaderboardList(quizId: quizId){ [weak self] (playersScoreResult) in
            guard let self = self else { return }
            guard let playersScoreResult = playersScoreResult else {return}
            self.playersScore = self.sortData(playersScoreResult: playersScoreResult)
            self.refresh()
        }
    }
    
    func sortData(playersScoreResult: [PlayerScoreResponse])-> [PlayerScore] {
        var playersScore = [PlayerScore]()
        
        for playerScoreResult in playersScoreResult {
            let playerScore = PlayerScore()
            playerScore.username = playerScoreResult.username
            
            if(playerScoreResult.score == nil) {
                playerScore.score = 0
            }
            else {
                let score = Int(String(playerScoreResult.score?.split(separator: ".")[0] ?? "0"))
                playerScore.score = score ?? 0
            }
            playersScore.append(playerScore)
        }
        
        return Array(playersScore.sorted {Int($0.score) > Int($1.score)}.prefix(20))
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.leaderboardTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.leaderboardTableView.isHidden = false
        }
    }
    
    func getPlayerScore(row: Int) -> PlayerScore? {
        guard let playersScore = playersScore else {
            return nil
        }
        return playersScore[row]
    }
}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LeaderboardTableViewCell
        
        if let playerScore = getPlayerScore(row: indexPath.row) {
            cell.setup(playerScore: playerScore,playerRank: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let playersScore = playersScore else {
            return 0
        }
        return playersScore.count
    }
}
