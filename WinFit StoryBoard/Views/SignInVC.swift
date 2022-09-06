//
//  SignInVC.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 6/22/22.
//

import UIKit
import SafariServices

class SignInVC: UIViewController, UITextFieldDelegate {

    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground

        addSubviews()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        addButtonActions()
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        
        emailField.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 80)
        passwordField.frame = CGRect(x: 20, y: emailField.frame.origin.y+emailField.frame.size.height+10, width: view.frame.width-40, height: 50)
        signInButton.frame = CGRect(x: 20, y: passwordField.frame.origin.y+passwordField.frame.size.height+10, width: view.frame.width-40, height: 50)
        createAccountButton.frame = CGRect(x: 20, y: signInButton.frame.origin.y+signInButton.frame.size.height+10, width: view.frame.width-40, height: 50)
//        termsButton.frame = CGRect(x: 35, y: createAccountButton.bottom+50, width: view.width-70, height: 40)
//        privacyButton.frame = CGRect(x: 35, y: termsButton.bottom+10, width: view.width-70, height: 40)

    }
    
    private func addSubviews() {

        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton )
    }
    
    private func addButtonActions() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)

    }

    // MARK: - Actions
    
    @objc func didTapSignIn() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
            let password = passwordField.text,
                !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
        password.count >= 6 else {
            return
        }
        
        // Sign in with auth manager
        AuthManager.shared.signIn(email: email, password: password) { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success:
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)

                case .failure(let error):
                    print(error)
            }

            }
        }
        
    }
    
    @objc func didTapTerms() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
            
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacy() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    
    
    @objc func didTapCreateAccount() {
        DispatchQueue.main.async {
            let vc = SignUpVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
       
    }
    
    
   
    // MARK: - FIELD DELEGATE
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }

}
