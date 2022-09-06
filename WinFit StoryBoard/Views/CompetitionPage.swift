//
//  CompetitionPage.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/23/22.
////
//
import Foundation
import UIKit


struct Countdown: Hashable {
    var time: String
}

struct MemberRank: Hashable {
    var title: String
}

class CompetitionPage: UIViewController, UITableViewDelegate {

  
    
    enum Section: Hashable, CaseIterable {
        case first
        
    }
    enum SectionCV: Hashable, CaseIterable {
        case countDownSection
        case memberRank
        case metricLeaders
        
    }
    
    enum ItemType: Hashable {
        case countDown(Countdown)
        case memberRank(Member)
        case stepLeader
        case effortLeader
    }
    
    struct Member: Hashable {
        let title: String
    }
//
//    var dataSource: UITableViewDiffableDataSource<Section, Member>!
    var memberlist = [Member]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        print(memberlist)
//        listOfMembersTable.delegate = self
//
//        listOfMembersTable.frame = view.bounds
//        dataSource = UITableViewDiffableDataSource(tableView: listOfMembersTable, cellProvider: { tableView, indexPath, itemIdentifier in
//            let cell = self.listOfMembersTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text  = itemIdentifier.username
//
//            return cell
//        })
    
        configureCollectionView()
        view.addSubview(collectionView)
      
           dataSourceCV = UICollectionViewDiffableDataSource<SectionCV, ItemType>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
               let membersToCell = self.memberlist.compactMap { member in
                   member.title
               }
                switch itemIdentifier {
                case .countDown:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeRemainingCell.reuseIdentifier, for: indexPath) as! TimeRemainingCell
                    return cell
                case .memberRank:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberRankCell.reuseIdentifier, for: indexPath) as! MemberRankCell
                   
                    cell.initialMembersArray = membersToCell
                    return cell
                case .effortLeader:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetricCell.reuseIdentifier, for: indexPath) as! MemberRankCell
                    
                    return cell
                case .stepLeader:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetricCell.reuseIdentifier, for: indexPath) as! MetricCell
                    cell.metricTitle.text = "1 Day"
                    return cell
                }
                
            })
           updateDataSource()
        
        
      
    }
    
//    var listOfMembersTable: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()

//    func updateSnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Member>()
//        snapshot.appendSections([.first])
//        snapshot.appendItems(memberlist)
//        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
//    }
    
    
    //MARK: Collection View
    
    var collectionView: UICollectionView!
    
    var dataSourceCV: UICollectionViewDiffableDataSource<SectionCV, ItemType>!
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layOutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        collectionView.register(MetricCell.self, forCellWithReuseIdentifier: MetricCell.reuseIdentifier)
        collectionView.register(MemberRankCell.self, forCellWithReuseIdentifier: MemberRankCell.reuseIdentifier)
        collectionView.register(TimeRemainingCell.self, forCellWithReuseIdentifier: TimeRemainingCell.reuseIdentifier)
    }
    
    //[ItemType.memberRank(Member(title: "10 Day")),ItemType.memberRank(Member(title: "2 Day")),ItemType.memberRank(Member(title: "3 Day")),ItemType.memberRank(Member(title: "4 Day")),ItemType.memberRank(Member(title: "55 Day")),ItemType.memberRank(Member(title: "a5 Day")),ItemType.memberRank(Member(title: "512 Day")),ItemType.memberRank(Member(title: "54 Day")),ItemType.memberRank(Member(title: "s5 Day")),ItemType.memberRank(Member(title: "5222 Day")),ItemType.memberRank(Member(title: "5 Day")),ItemType.memberRank(Member(title: "d5 Day")),ItemType.memberRank(Member(title: "556 Day")),ItemType.memberRank(Member(title: "5n Day")),ItemType.memberRank(Member(title: "5f Day")),ItemType.memberRank(Member(title: "52132 Day"))]
    
    func updateDataSource() {
        guard memberlist.isEmpty != true else {
            return
        }
        let memberSnap = memberlist.compactMap { member in
            ItemType.memberRank(Member(title: member.title))
        }
       
        print(memberSnap)
        print("printed membersnapshot")
        var snapshotTwo = NSDiffableDataSourceSnapshot<SectionCV, ItemType>()
        snapshotTwo.appendSections(SectionCV.allCases)
        snapshotTwo.appendItems([ItemType.countDown(Countdown(time: "4:05:03"))], toSection: .countDownSection)
        snapshotTwo.appendItems([memberSnap.first!], toSection: .memberRank)
//        snapshotTwo.appendItems([ItemType.countDown(Countdown(time: "3 Day"))], toSection: .metricLeaders)
//      
        dataSourceCV.apply(snapshotTwo, animatingDifferences: true)
    }
    
    func layOutProvider() -> UICollectionViewCompositionalLayout{
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = SectionCV.allCases[sectionIndex]
            switch section {
            case .countDownSection:
                
                let countDownItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let countDownGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [countDownItem])
                
                let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5)), subitems: [countDownGroup])
                
                let section = NSCollectionLayoutSection(group: containerGroup)
                
                return section
                
            case .memberRank:
                let countDownItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let countDownGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: countDownItem, count: 1)
                
                let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3/5)), subitem: countDownGroup, count: 1)
                
                let section = NSCollectionLayoutSection(group: containerGroup)
                
                return section
//                let section: NSCollectionLayoutSection
//                let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar
//                )
//
//
//                section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
//
                
                
                
            case .metricLeaders:
                
                let countDownItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let countDownGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: countDownItem, count: 1)
                
                let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5)), subitems: [countDownGroup])
                
                let section = NSCollectionLayoutSection(group: containerGroup)
                
                return section
            
            }
            
            
            
        }
        return layout
    }
    
}
