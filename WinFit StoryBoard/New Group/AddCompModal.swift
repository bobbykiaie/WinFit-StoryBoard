//
//  AddCompModal.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/19/22.
//

import UIKit

protocol CompDataDelegate: AnyObject  {
    func passCompData(_ data: NSArray)
}

class AddCompModal: UIViewController, UITextFieldDelegate {
//    func passCompData(_ data: NSArray) {
//    
//    }
    
    var delegate: CompDataDelegate?
   
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
       
        title = UserDefaults.standard.string(forKey: "username")
        view.backgroundColor = .secondarySystemBackground
        compNameTextField.delegate = self
        configure()
        
        // Do any additional setup after loading the view.
    }
    

    
    let compNameTextField: UITextField = {
        let textField = UITextField()
     
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
      
        textField.textAlignment = .center
        
        textField.placeholder = "Competition Name"
        return textField
    }()
    let createCompButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Create"
        
        return button
        
    }()
 
    let joinCompButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Join"
        
        return button
        
    }()
    
    
    func configure() {
        view.addSubview(compNameTextField)
        view.addSubview(createCompButton)
        view.addSubview(joinCompButton)
      
        createCompButton.translatesAutoresizingMaskIntoConstraints = false
        compNameTextField.translatesAutoresizingMaskIntoConstraints = false
        joinCompButton.translatesAutoresizingMaskIntoConstraints = false
        joinCompButton.addTarget(self, action: #selector(didTapJoinComp), for: .touchUpInside)
        createCompButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
      
        
        NSLayoutConstraint.activate([
            createCompButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCompButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            createCompButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            createCompButton.heightAnchor.constraint(equalToConstant: 30),
            compNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            compNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            compNameTextField.widthAnchor.constraint(equalToConstant: 200),
            compNameTextField.heightAnchor.constraint(equalToConstant: 60),
            joinCompButton.centerXAnchor.constraint(equalTo: compNameTextField.centerXAnchor, constant: -40),
            joinCompButton.centerYAnchor.constraint(equalTo: compNameTextField.centerYAnchor, constant: -80),
            joinCompButton.widthAnchor.constraint(equalTo: createCompButton.widthAnchor),
            joinCompButton.heightAnchor.constraint(equalTo: createCompButton.heightAnchor)
        ])
        
    }
    
    @objc func didTapJoinComp() {
        DatabaseManager.shared.joinCompetition(compName: compNameTextField.text!){
            compList in
            self.delegate?.passCompData(compList)
        }
        self.dismiss(animated: true)
    }
    
    @objc func dismissVC()    {
        DatabaseManager.shared.addCompetition(compName: compNameTextField.text!) { compList in
            self.delegate?.passCompData(compList)
            
        }
     
        print(UserDefaults.standard.string(forKey: "email")!)
     
    
      
        self.dismiss(animated: true)
        
       
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
