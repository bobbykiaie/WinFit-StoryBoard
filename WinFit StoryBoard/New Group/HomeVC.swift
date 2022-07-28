import UIKit

struct Item: Hashable {

    let title: String

}

enum ItemType: Hashable {
    case dateItem(DateItem), comp(Comp), metric(Metric)
}

struct DateItem: Hashable {
    var theDate: Int
}

struct Comp: Hashable {
    var compName: String
}

struct Metric: Hashable {
    var metricName: String
    var metricValue: String
    var metricLogo: UIImage
    
}



class HomeViewController: UIViewController, MetricCellDelegate, CompDataDelegate, HeaderCellDelegate  {
    func buttonToAddCompModalTap() {
        let addCompController = AddCompModal()
         addCompController.delegate = self
        present(addCompController, animated: true)
    }
    

    let addComp = UIButton()
        
    let label: UILabel = {
        var label = UILabel()
        label.text = "scone malone"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    func configureLabel() {
//       addComp.configuration = .filled()
//       addComp.configuration?.cornerStyle = .capsule
//       addComp.configuration?.title = "+"
////        collectionView.addSubview(addComp)
//
//        addComp.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//           addComp.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
//           addComp.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
//           addComp.widthAnchor.constraint(equalToConstant: 100),addComp.heightAnchor.constraint(equalToConstant: 40),
//        ])
    }
    
    var competions = [ItemType]()
    func passCompData(_ data: NSArray) {
        print(data)
        print("")
        var tempArray = [ItemType]()

        guard data.count > 0 else {
            let emptyData: NSArray = ["No Comp"]
            
            emptyData.forEach { item in
                tempArray.append(item as! ItemType)
                self.competions = tempArray
                updateDataSource()
            }
            
            return 
        }
        data.forEach { item in
           
            tempArray.append( ItemType.comp(Comp(compName: item as! String)))
        }
        self.competions = tempArray
        
        updateDataSource()
    }

    
    func metricCellButtonTap(_ cell: MetricCell) {
       let addCompController = AddCompModal()
        addCompController.delegate = self
        
        present(addCompController, animated: true)
    }

    let healthPlace = HealthStore()
    var heartArray = ["No Data"]
    
    var collectionView: UICollectionView!
    
    enum Section: Hashable, CaseIterable {
        case first
        case second
        case third
    }

    struct Date: Hashable {
        let date: Int
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, ItemType>!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        healthPlace.accessData()
        healthPlace.getRestingHR()
        healthPlace.getSteps { num in
            print(num)
        }
       
        DispatchQueue.main.async {
            self.healthPlace.getSteps { [weak self] num in
                print(num)
        }
            self.updateDataSource()
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scone = AddCompModal()
        scone.delegate = self
  
            DatabaseManager.shared.addCompetition(compName: nil) {
                compList in
                var tempArray = [ItemType]()
                print(compList)
                guard compList.count > 0 else {
                    let emptyData: NSArray = ["No Comp"]
                    
                    emptyData.forEach { item in
                        tempArray.append(item as! ItemType)
                        self.competions = tempArray
                        self.updateDataSource()
                    }
                    return 
                }
              
                compList.forEach { item in
                   
                    tempArray.append( ItemType.comp(Comp(compName: item as! String )))
                }
                self.competions = tempArray
                self.updateDataSource()
            }
        

        configureCollectionView()
        view.addSubview(collectionView)
        collectionView.delegate = self
//        collectionView.frame = view.bounds
        dataSource = UICollectionViewDiffableDataSource<Section, ItemType>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell in
            switch model {
            case .comp(let comp): 
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionHomeScreenCell.reuseIdentifier, for: indexPath) as! CompetitionHomeScreenCell
                cell.myLabel.text = comp.compName
          
                return cell
            case .dateItem(let dateItem):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as! DateCell
                cell.dateButton.configuration?.title = "\(dateItem.theDate)"
                return cell
            case .metric(let metric):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetricCell.reuseIdentifier, for: indexPath) as! MetricCell
                cell.metricTitle.text = metric.metricName
                cell.metricValue.text = metric.metricValue
                cell.metricImage.image = metric.metricLogo
                cell.delegate = self
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { (view, kind, index) in
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.reuseIdentifier, for: index) as! HeaderCell
            header.delegate = self
     
            return header
        }
 
        updateDataSource()
        configureLabel()
        
    }
    
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        collectionView.register(CompetitionHomeScreenCell.self, forCellWithReuseIdentifier: CompetitionHomeScreenCell.reuseIdentifier)
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        collectionView.register(MetricCell.self, forCellWithReuseIdentifier: MetricCell.reuseIdentifier)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
    }

    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemType>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([ItemType.metric(Metric(metricName: "Heart Rate", metricValue: String(healthPlace.restHR), metricLogo: UIImage(systemName: "heart")!)), ItemType.metric(Metric(metricName: "Steps", metricValue: String(healthPlace.recentSteps), metricLogo: UIImage(systemName: "figure.walk")!))], toSection: .second)
        if competions.count > 0 {
            print(competions.count)
            snapshot.appendItems(competions, toSection: .third)
        }
        else {
            snapshot.appendItems([ItemType.comp(Comp(compName: "No Competitions"))], toSection: .third)
        }
        snapshot.appendItems([ItemType.dateItem(DateItem(theDate: 1)), ItemType.dateItem(DateItem(theDate:2)), ItemType.dateItem(DateItem(theDate:3)), ItemType.dateItem(DateItem(theDate:4)), ItemType.dateItem(DateItem(theDate:5)), ItemType.dateItem(DateItem(theDate:6)), ItemType.dateItem(DateItem(theDate:7))], toSection: .first)
        dataSource.apply(snapshot, animatingDifferences: true)
        
        
    }
    
}

extension HomeViewController {
    func layoutProvider() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = Section.allCases[sectionIndex]
            switch section {
            
            case .first:
                let dateGroupItem = NSCollectionLayoutItem(
                            layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1)
                            )
                        )
                        //Group
                        let dateGroup = NSCollectionLayoutGroup.horizontal(
                            layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1/7),
                                heightDimension: .fractionalHeight(1)
                            ),
                            subitem: dateGroupItem, count: 1)
                
                        let containerGroup = NSCollectionLayoutGroup.horizontal(
                            layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1/9)
                            ),
                            subitems: [dateGroup])
                
                        //Section
                        let section = NSCollectionLayoutSection(group: containerGroup)
                
                
                        return section
            case .third:
                let competitionGroupItem = NSCollectionLayoutItem(
                           layoutSize: NSCollectionLayoutSize(
                               widthDimension: .fractionalWidth(1),
                               heightDimension: .fractionalHeight(1)
                           )
                       )
                       competitionGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20)
                       let competitionGroup = NSCollectionLayoutGroup.horizontal(
                           layoutSize: NSCollectionLayoutSize(
                               widthDimension: .fractionalWidth(1),
                               heightDimension: .fractionalHeight(1)
                           ),
                           subitem: competitionGroupItem, count: 1)
               
                       let containerGroup = NSCollectionLayoutGroup.vertical(
                           layoutSize: NSCollectionLayoutSize(
                               widthDimension: .fractionalWidth(1),
                               heightDimension: .fractionalHeight(3/9)
                           ),
                           subitem: competitionGroup, count: 1)
                       let section = NSCollectionLayoutSection(group: containerGroup)
                let title = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [title]
                section.orthogonalScrollingBehavior = .continuous
             
                return section
                
            case .second:
                let metricItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
                
                metricItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
                
                let metricGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [metricItem])
                
                let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3/9)), subitems: [metricGroup])
                let section = NSCollectionLayoutSection(group: containerGroup)
                return section
            }
            
        }
        return layout
    }
    
    func layOutHeader() {
        
    }
}



extension HomeViewController: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let selectedCompetitionPage = CompetitionPage()
        healthPlace.accessData()
        healthPlace.getRestingHR()
        var yoyo = dataSource.itemIdentifier(for: indexPath).self
        var clickedCompName: String?
        switch yoyo {
        case .comp(let value):
            print("sconey boney")
            print(value.compName)
            clickedCompName = value.compName
            
        default: print("didnt work")
            clickedCompName = "Nothing"
        }
        var memberlist = [CompetitionPage.Member]()
        DispatchQueue.main.async  {
            DatabaseManager.shared.getListOfCompetitionMembers(compName: clickedCompName!) { item in
               print("printing from comppage")
                print(item)
                print("finished printing from comppage")
                item.forEach { member in
                    memberlist.append(CompetitionPage.Member(username: member as! String))
                }
            }
        }
     
    
        updateDataSource()
    
        present(selectedCompetitionPage, animated: true) {
      
            selectedCompetitionPage.memberlist = memberlist
            selectedCompetitionPage.updateSnapshot()
        }
        
        
//
}

   

}


















/////
////  ExploreViewController.swift
////  Instagram
////
////  Created by Babak Kiaie on 6/9/22.
////
//
///*
// 1. Create Model for Item
// A. Needs to be hashable
// B. Can be a struct
//
// In the View Controller do the following:
// 1. Create an enum of the sections
// 2. Create an Item Struct
// 3. Create the collectionView
// 4. Create the data source
// var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
// 5. Configure the collection view
// 6. Create the layout for the collection View
// 7  Create functions to register the cells
// 8. Configure the data source
// A. call Cell registration
// B. Set datasource and configure its closure
// 1. switch
// */
//
//import UIKit
//import CoreMIDI
//import simd
//
//
//
//
//class HomeViewController: UIViewController {
//    enum Section: Int, Hashable, CaseIterable {
//        case first
//        case second
//        case third
//
//    }
//    //    enum Section {
//    //        case top: print("scone")
//    //        case middle: print("sconee")
//    //        case bottom: print("scallled")
//    //    }
//
//    var collectionView: UICollectionView!
//
//
//
//
//
//    var dataSource: UICollectionViewDiffableDataSource<Section, TestCellController.TestItem>?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//        title = UserDefaults.standard.string(forKey: "username")
//        view.backgroundColor = .systemBackground
//        configureCollectionView()
//        createDataSource()
//
//    }
//    func configureCollectionView() {
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//        collectionView.register(CustomCellCollectionViewCell.self, forCellWithReuseIdentifier: CustomCellCollectionViewCell.identifier)
//        collectionView.frame = view.bounds
//        collectionView.backgroundColor = .systemBackground
//        //        collectionView.dataSource = self
//
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .blue
//    }
//    func createDataSource() {
//
//        let cellRegistration = UICollectionView.CellRegistration<TestCell, TestCellController.TestItem> { cell, indexPath, item in
//            cell.titleLabel.text = item.title
//        }
//
//        dataSource = UICollectionViewDiffableDataSource<Section,TestCellController.TestItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
//            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
//        })
//    }
//
//    func applySnapshot(){
//        let sections = Section.allCases
//        var snapshot = NSDiffableDataSourceSnapshot<Section,TestCellController.TestItem>()
//        snapshot.appendSections(sections)
//        snapshot.appendItems([TestCellController.TestItem(title: "Scone", description: "socnne")])
//        dataSource!.apply(snapshot)
//
//    }
//
//
//    func createLayout() -> UICollectionViewLayout {
//
//        let sectionProvider = {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            guard let sectionKind = Section(rawValue: sectionIndex) else {
//                return nil
//            }
//            let section: NSCollectionLayoutSection
//
//            if sectionKind == .first {
//                section = self.createThirdSection()
//            } else if sectionKind == .second {
//                section = self.createSecondSection()
//            } else if sectionKind == .third {
//                section = self.createFirstSection()
//            } else {
//                fatalError("unknown")
//            }
//            return section
//        }
//        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
//    }
//
//    //    static func createAnotherLayout() -> UICollectionViewLayout {
//    //        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//    //            switch sectionIndex{
//    //            case 1: return createSecondSection()
//    //            case 2: return createThirdSection()
//    //            default: return createFirstSection()
//    //            }
//    //        }
//    //        return layout
//    //    }
//
//    func createThirdSection() -> NSCollectionLayoutSection {
//        let competitionGroupItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(1)
//            )
//        )
//        competitionGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20)
//        let competitionGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(1)
//            ),
//            subitem: competitionGroupItem, count: 1)
//
//
//
//
//        let containerGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(3/9)
//            ),
//            subitem: competitionGroup, count: 1)
//        let section = NSCollectionLayoutSection(group: containerGroup)
//
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//
//        return section
//    }
//
//    func createSecondSection() -> NSCollectionLayoutSection {
//        //Item
//        let statGroupItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(1)
//            )
//        )
//
//        statGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
//        //Group
//        let statGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(3/9)
//            ),
//            subitem: statGroupItem, count: 2)
//        //Section
//        let section = NSCollectionLayoutSection(group: statGroup)
//        return section
//    }
//
//    func createFirstSection() -> NSCollectionLayoutSection {
//        let dateGroupItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1/7),
//                heightDimension: .fractionalHeight(1)
//            )
//        )
//        dateGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 25, trailing: 5)
//
//        //Group
//        let dateGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(1)
//            ),
//            subitem: dateGroupItem, count: 7)
//
//        let containerGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalHeight(1/9)
//            ),
//            subitems: [dateGroup])
//
//        //Section
//        let section = NSCollectionLayoutSection(group: containerGroup)
//        return section
//    }
//
//
//
//
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.frame = view.bounds
//    }
//
//
//
//
//    //Collection View
//
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}
//

