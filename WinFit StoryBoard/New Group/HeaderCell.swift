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
        label.text = UserDefaults.standard.value(forKey: "username")! as? String
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
            joinCompButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50),
            joinCompButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            joinCompButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7),
            joinCompButton.heightAnchor.constraint(equalTo: joinCompButton.widthAnchor),
            heading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            heading.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])

    }
    
    @objc func didTapPlus() {
        print("circle button clicked")
        delegate?.buttonToAddCompModalTap()
        
    }
}
