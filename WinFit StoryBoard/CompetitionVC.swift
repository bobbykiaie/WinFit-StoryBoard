//
//  ViewController.swift
//  Instagram
//
//  Created by Babak Kiaie on 6/9/22.
//

import UIKit

class CompetitionVC: UIViewController {

    private let signOut: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Competitions"
        view.backgroundColor = .systemBackground
        
        view.addSubview(signOut)
        signOut.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        
    }

    override func viewDidLayoutSubviews() {
        signOut.frame = CGRect(x: 50, y: 100, width: view.width/2, height: 40)
    }
    
    @objc func didTapSignOut() {
        AuthManager.shared.signOut { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    let vc = SignInVC()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    self?.present(navVC,animated: true)
                }
            }
        }
    }
}

