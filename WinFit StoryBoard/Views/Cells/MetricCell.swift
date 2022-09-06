//
//  MetricCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/16/22.
//

import Foundation
import UIKit

protocol MetricCellDelegate: AnyObject {
    func metricCellButtonTap(_ cell: MetricCell)
}

class MetricCell: UICollectionViewCell {
    
    weak var delegate: MetricCellDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
//        configureButton()
       
        contentView.backgroundColor = .quaternarySystemFill
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let reuseIdentifier = "metricCell"
    
    
    
    //Metric Cell
//    let metricContainer = UIButton()
//    let metricCard = UIView()
    let metricImage = UIImageView()
    let metricTitle = UILabel()
    let metricValue = UILabel()
    let metricButton = UIButton()
 
    func configure() {
        metricImage.image = UIImage(systemName: "heart")
        metricTitle.text = "Heart"
        metricTitle.font = .preferredFont(forTextStyle: .footnote)
        metricValue.text = "200"
        metricValue.font = .systemFont(ofSize: 36)
        metricValue.textColor = .systemRed
//        metricButton.configuration = .filled()
//        metricButton.configuration?.baseForegroundColor = .white
//        metricButton.configuration?.baseBackgroundColor = .systemRed
//        metricButton.configuration?.title = "Test"
//        metricButton.addTarget(self, action: #selector(didTapMetricButton), for: .touchUpInside)
       
        addTheConstraints()
    }
    
    
    @objc func didTapMetricButton() {
        delegate?.metricCellButtonTap(self)
    }
    
    func addTheConstraints(){
        contentView.addSubview(metricImage)
        contentView.addSubview(metricTitle)
        contentView.addSubview(metricValue)
//        contentView.addSubview(metricButton)
//        
        metricTitle.translatesAutoresizingMaskIntoConstraints = false
        metricImage.translatesAutoresizingMaskIntoConstraints = false
        metricValue.translatesAutoresizingMaskIntoConstraints = false
//        metricButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            metricImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            metricImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            metricImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            metricImage.heightAnchor.constraint(equalTo: metricImage.widthAnchor),
            metricTitle.centerXAnchor.constraint(equalTo: metricImage.centerXAnchor),
            metricTitle.topAnchor.constraint(equalTo: metricImage.bottomAnchor, constant: 0),
            metricValue.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            metricValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
//            metricButton.leadingAnchor.constraint(equalTo: metricImage.trailingAnchor),
//            metricButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            metricButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            metricButton.heightAnchor.constraint(equalTo: metricImage.heightAnchor),
//            metricButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    
//    func configureButton() {
//
//
//        metricContainer.configuration = .tinted()
//        metricContainer.configuration?.image = UIImage(systemName: "heart")
//        metricContainer.configuration?.titleAlignment = .trailing
//        metricContainer.configuration?.imagePlacement = .leading
//
//        metricContainer.configuration?.title = "Scone"
//
//        addMetricContainerConstraints()
//    }
//
//    func addMetricContainerConstraints() {
//        contentView.addSubview(metricContainer)
//        metricContainer.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            metricContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), metricContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            metricContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor), metricContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor)
//        ])
//    }
    
}
