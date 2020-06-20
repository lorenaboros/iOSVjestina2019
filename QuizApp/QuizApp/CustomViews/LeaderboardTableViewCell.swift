//
//  LeaderboardTableViewCell.swift
//  QuizApp
//
//  Created by Lorena Boroš on 18/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardTableViewCell : UITableViewCell {
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerRankLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
        playerRankLabel.text = ""
        playerScoreLabel.text = ""
        playerName.text = ""
    }
    
    func setup(playerScore: PlayerScore, playerRank: Int) {
        playerScoreLabel.text = String(playerScore.score)
        playerName.text = playerScore.username
        playerRankLabel.text = " \(String(playerRank+1))."
    }
}
