//
//  TimeRemainingCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 8/23/22.
//

import UIKit

class TimeRemainingCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(roundedBackgroundView)
        contentView.addSubview(timerLabel)
       
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let reuseIdentifier = "timeRemainingCell"
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "4:05:03"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    func constraints() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
