//
//  HeaderCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/22/22.
//

import Foundation
import UIKit


protocol HeaderCellDelegate: AnyObject {
    func buttonToAddCompModalTap()
}

class HeaderCell: UICollectionReusableView {

    
    let joinCompButton = UIButton()
    let heading: UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Competitions"
//        label.text = UserDefaults.standard.value(forKey: "username")! as? String
        return label
    }()
    weak var delegate: HeaderCellDelegate?
    
    
    
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HeaderCell {
    func configure() {
        
        addSubview(joinCompButton)
        addSubview(heading)
  
        joinCompButton.configuration = .filled()
        joinCompButton.configuration?.cornerStyle = .capsule
        joinCompButton.configuration?.title = "+"
        joinCompButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        joinCompButton.translatesAutoresizingMaskIntoConstraints = false
        heading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           
          
            joinCompButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            joinCompButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/12),
            joinCompButton.heightAnchor.constraint(equalTo: joinCompButton.widthAnchor),
            heading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            heading.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            joinCompButton.centerYAnchor.constraint(equalTo: heading.centerYAnchor)
        ])

    }
    
    @objc func didTapPlus() {
        print("circle button clicked")
        delegate?.buttonToAddCompModalTap()
        
    }
}
