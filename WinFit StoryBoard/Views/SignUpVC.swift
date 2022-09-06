
//
//  SignUpVC.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 6/22/22.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

//Create Sign UP Page Fields
    let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .next
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))  //Padding inside the view itself
        field.leftViewMode = .always
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.autocapitalizationType = .none
        field.returnKeyType = .next
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))  //Padding inside the view itself
        field.leftViewMode = .always
        return field
    }()
    
  private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.isSecureTextEntry = true
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))  //Padding inside the view itself
        field.leftViewMode = .always
        return field
    }()
    
   private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        view.backgroundColor = .systemBackground
        view.addSubview(profilePictureImageView)
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(emailField)
        view.addSubview(signUpButton)
     
        userNameField.delegate = self
        passwordField.delegate = self
        
        addButtonActions()
    }
 
    //Create frames for
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 90
        
        profilePictureImageView.frame = CGRect(
            x: (view.frame.width - imageSize)/2,
            y: view.safeAreaInsets.top,
            width: imageSize,
            height: imageSize)
        
        userNameField.frame = CGRect(x: 25,
                                     y: profilePictureImageView.bottom+20,
                                     width: view.width - 50,
                                     height: 50)
        
        emailField.frame = CGRect(x: 25,
                                     y: userNameField.bottom+20,
                                     width: view.width - 50,
                                     height: 50)
        passwordField.frame = CGRect(x: 25,
                                     y: emailField.bottom+20,
                                     width: view.width - 50,
                                     height: 50)
        signUpButton.frame = CGRect(x: 40,
                                     y: passwordField.bottom+20,
                                     width: view.width - 80,
                                     height: 50)
    }
    
 
    
    private func addButtonActions(){
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc func didTapSignUp(){
        guard let email = emailField.text,
              let username = userNameField.text,
              let password = passwordField.text
                
        else {
            print("Error")
            return
        }
      
        AuthManager.shared.signUp(
            email: email,
            username: username,
            password: password
        ) { [weak self] result in
           
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("we got to the success case")
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.username, forKey: "username")
                    print("i'm about to present")
                    
                    print(AuthManager.shared.isSignedIn)
                    
                    let vc = TabBarViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    self?.present(navVC, animated: true)
                    
                case .failure(let error):
                    print(error)
                }
                
                }
                
                }
            
                
            }
        }
    



