//
//  AddCompModal.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/19/22.
//

import UIKit
import PhotosUI

protocol CompDataDelegate: AnyObject  {
    func passCompData(_ data: NSArray)
}

class AddCompModal: UIViewController, UITextFieldDelegate, PHPickerViewControllerDelegate {
    
    var pictureArray = [UIImage]()
    
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
  
        DispatchQueue.main.async {
            results.forEach { results in
                results.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                    guard let image =  reading as? UIImage, error == nil else {
                        return
                    }
                    
                    self.pictureArray.append(image)
                    DispatchQueue.main.async {
                        self.theImage.image = image
                        picker.dismiss(animated: true)
                    }
                    
                }
        }
       
        }
    }
    
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
 
    let chooseImageButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Choose Image"
        return button
    }()
    
    let joinCompButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Join"
        
        return button
        
    }()
    
    let theImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    
    
    func configure() {
        view.addSubview(compNameTextField)
        view.addSubview(createCompButton)
        view.addSubview(joinCompButton)
        view.addSubview(chooseImageButton)
        view.addSubview(theImage)
        
        
        createCompButton.translatesAutoresizingMaskIntoConstraints = false
        compNameTextField.translatesAutoresizingMaskIntoConstraints = false
        joinCompButton.translatesAutoresizingMaskIntoConstraints = false
        chooseImageButton.translatesAutoresizingMaskIntoConstraints = false
        theImage.translatesAutoresizingMaskIntoConstraints = false
        
        joinCompButton.addTarget(self, action: #selector(didTapJoinComp), for: .touchUpInside)
        createCompButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        chooseImageButton.addTarget(self, action: #selector(didTapChooseImage), for: .touchUpInside)
        
      
        
        NSLayoutConstraint.activate([
            createCompButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCompButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            createCompButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            createCompButton.heightAnchor.constraint(equalToConstant: 30),
            compNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            compNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            compNameTextField.widthAnchor.constraint(equalToConstant: 200),
            compNameTextField.heightAnchor.constraint(equalToConstant: 60),
            chooseImageButton.widthAnchor.constraint(equalTo: createCompButton.widthAnchor),
            chooseImageButton.heightAnchor.constraint(equalTo: createCompButton.heightAnchor),
            chooseImageButton.centerXAnchor.constraint(equalTo: compNameTextField.centerXAnchor),
            chooseImageButton.centerYAnchor.constraint(equalTo: compNameTextField.centerYAnchor, constant: 80),
            joinCompButton.centerXAnchor.constraint(equalTo: compNameTextField.centerXAnchor),
            joinCompButton.centerYAnchor.constraint(equalTo: compNameTextField.centerYAnchor, constant: -80),
            joinCompButton.widthAnchor.constraint(equalTo: createCompButton.widthAnchor),
            joinCompButton.heightAnchor.constraint(equalTo: createCompButton.heightAnchor),
            theImage.centerXAnchor.constraint(equalTo: chooseImageButton.centerXAnchor),
            theImage.centerYAnchor.constraint(equalTo: chooseImageButton.bottomAnchor, constant: 80),
            theImage.widthAnchor.constraint(equalToConstant: 100),
            theImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    @objc func didTapChooseImage() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc  = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
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
