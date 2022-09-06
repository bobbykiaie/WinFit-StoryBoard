//
//  TestCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/14/22.
//

import Foundation
import UIKit
import Photos
import PhotosUI


class CompetitionHomeScreenCell: UICollectionViewCell {
    static let reuseIdentifier = "testCell"

     let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
         imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "scone"
         myLabel.font = .systemFont(ofSize: 40)
         myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.layer.opacity = 0.8
        contentView.backgroundColor = .secondarySystemBackground
        viewConstraints()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewConstraints() {
        let screenWidth = contentView.widthAnchor
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.widthAnchor.constraint(equalTo: screenWidth, multiplier: 1/3),
            myImageView.heightAnchor.constraint(equalTo: myImageView.widthAnchor),
            myLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myLabel.bottomAnchor.constraint(equalTo: myImageView.topAnchor, constant: -5)
        ])
    }
}
