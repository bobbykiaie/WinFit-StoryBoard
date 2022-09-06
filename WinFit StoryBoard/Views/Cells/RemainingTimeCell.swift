//
//  RemainingTimeCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 8/22/22.
//

import UIKit

class RemainingTimeCell: UICollectionViewCell {
    
    let timeDisplay: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureLabel()
    }
    static let reuseIdentifier = "remainingTimeCell"
    
    func configureLabel() {
        contentView.addSubview(timeDisplay)
        
        timeDisplay.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeDisplay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeDisplay.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
