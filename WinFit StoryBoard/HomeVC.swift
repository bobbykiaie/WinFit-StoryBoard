//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Babak Kiaie on 6/9/22.
//

import UIKit


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: HomeViewController.createAnotherLayout())

        
    static func createAnotherLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex{
            case 1: return createSecondSection()
            case 2: return createThirdSection()
            default: return createFirstSection()
            }
        }
        return layout
    }
    
    static func createThirdSection() -> NSCollectionLayoutSection {
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
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    static func createSecondSection() -> NSCollectionLayoutSection {
        //Item
        let statGroupItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        statGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
        //Group
        let statGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(3/9)
                ),
            subitem: statGroupItem, count: 2)
        //Section
        let section = NSCollectionLayoutSection(group: statGroup)
        return section
    }
    
    static func createFirstSection() -> NSCollectionLayoutSection {
        let dateGroupItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/7),
                heightDimension: .fractionalHeight(1)
            )
        )
        dateGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 25, trailing: 5)
        
        //Group
        let dateGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
                ),
            subitem: dateGroupItem, count: 7)

        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/9)
                ),
            subitems: [dateGroup])
        
        //Section
    let section = NSCollectionLayoutSection(group: containerGroup)
        return section
    }
    
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = UserDefaults.standard.string(forKey: "username")
        view.backgroundColor = .systemBackground
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(CustomCellCollectionViewCell.self, forCellWithReuseIdentifier: CustomCellCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    //Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            return 2
        default:
            return 7
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCellCollectionViewCell.identifier,
            for: indexPath)
       
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

