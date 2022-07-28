//
//  DateCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/15/22.
//

import Foundation
import UIKit

class DateCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let reuseIdentifier = "dateCell"
    
    let dateButton = UIButton()
    
    func configureButton() {
        contentView.addSubview(dateButton)
        dateButton.configuration = .tinted()
        dateButton.configuration?.title = "1"
        addButtonConstraints()
        
    }
    
    func addButtonConstraints() {
      
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([dateButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), dateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), dateButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8), dateButton.heightAnchor.constraint(equalTo: dateButton.widthAnchor, multiplier: 1.5)])
    }
    

}
