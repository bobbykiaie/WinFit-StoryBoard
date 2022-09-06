//
//  MemberRankCell.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 8/21/22.
//

import UIKit

enum Section: Hashable, CaseIterable {
    case first
    
}
struct Member: Hashable {
    let title: String
}

class MemberRankCell: UICollectionViewCell, UITableViewDelegate {

    var initialMembersArray = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        listTable.delegate = self

      constraints()
        dataSource = UITableViewDiffableDataSource(tableView: listTable, cellProvider: { tableView, indexPath, itemIdentifier in
                        let cell = self.listTable.dequeueReusableCell(withIdentifier: "memberTableCell", for: indexPath) as! MemberRankTableCell
            cell.userNameLabel.text = itemIdentifier.title
            cell.scoreLabel.text = "500"
            cell.backgroundColor = .secondarySystemBackground
            
                        return cell
        })
       updateSnapshot()
    }
    
        func updateSnapshot() {
            let memberSnapshot = initialMembersArray.compactMap { member in
                Member(title: member)
            }
            let scone = (1...20).compactMap{ item in
                Member(title: String(item))
            }
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, Member>()
            snapshot.appendSections([.first])
            snapshot.appendItems(memberSnapshot)
            dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    
    var dataSource: UITableViewDiffableDataSource<Section, Member>!
    static let reuseIdentifier = "memberRankCell"
    
    
    let listTable: UITableView = {
        let table = UITableView()
        table.register(MemberRankTableCell.self, forCellReuseIdentifier: "memberTableCell")
        table.backgroundColor = .secondarySystemBackground
        return table
    }()
    
    func configureTable() {
        listTable.register(MemberRankTableCell.self, forCellReuseIdentifier: "memberTableCell")
    }
    
    
    func constraints() {
        contentView.addSubview(roundedBackgroundView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(listTable)
        
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        listTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            listTable.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: 10),
            listTable.trailingAnchor.constraint(equalTo:roundedBackgroundView.trailingAnchor, constant: -10),
            listTable.topAnchor.constraint(equalTo:     roundedBackgroundView.topAnchor, constant: 10),
            listTable.bottomAnchor.constraint(equalTo:  roundedBackgroundView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Properties
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
