//
//  CustomCellCollectionViewCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/1/22.
//

import UIKit

class CustomCellCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomeCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "scone"
        myLabel.backgroundColor = .blue
        return myLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       contentView.backgroundColor = [UIColor.red, UIColor.green, UIColor.blue, UIColor.brown, UIColor.orange, UIColor.systemPink, UIColor.cyan].randomElement()
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        myLabel.frame = CGRect(x: 10, y: 30, width: 20, height: 20)
    }
    
}
