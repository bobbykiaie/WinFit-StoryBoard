//
//  CompetitionPage.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/23/22.
////
//
import Foundation
import UIKit


class CompetitionPage: UIViewController, UITableViewDelegate {

    enum Section {
        case first
        
    }
    
    struct Member: Hashable {
        let username: String
    }
    
    
   
    
    var listOfMembers: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var dataSource: UITableViewDiffableDataSource<Section, Member>!
    var memberlist = [Member]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(memberlist)
        listOfMembers.delegate = self
        view.addSubview(listOfMembers)
        listOfMembers.frame = view.bounds
        dataSource = UITableViewDiffableDataSource(tableView: listOfMembers, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = self.listOfMembers.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text  = itemIdentifier.username
            
            return cell
            
        })
     
     
    }

    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Member>()
        snapshot.appendSections([.first])
        snapshot.appendItems(memberlist)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
}
