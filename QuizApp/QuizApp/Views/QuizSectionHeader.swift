//
//  QuizSectionHeader.swift
//  QuizApp
//
//  Created by Lorena Boroš on 05/05/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import UIKit

class QuizSectionHeader: UITableViewHeaderFooterView {
    
    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 30),
            title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    
    
}
