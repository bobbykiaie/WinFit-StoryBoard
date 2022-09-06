//
//  MemberRankTableCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 8/23/22.
//

import UIKit

class MemberRankTableCell: UITableViewCell {



    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
     
        
        addSubview(userNameLabel)
        addSubview(scoreLabel)
        configureLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "o"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    func configureLabelConstraints(){
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreLabel.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor),
            
            scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
            
            
          
        ])
    }
    
}
