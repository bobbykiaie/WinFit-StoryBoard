//
//  LoginViewController.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 4/28/22.
//

import UIKit
import FirebaseEmailAuthUI

class LoginViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        if let authUI = authUI {
            authUI.delegate = self
        
            authUI.providers = [FUIEmailAuth()]
            
            let authViewController = authUI.authViewController()
            
            present(authViewController, animated: true, completion: nil)
            
            
            
        }

        
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
extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        } else {
            let user = authDataResult?.user
            
            if let user = user {
                
                //Use the UserService to get the profile
                UserService.retrieveProfile(userId: user.uid) { (user) in
                    // Check if user is nil
                    if user == nil {
                        // Go to create profile
                        self.performSegue(withIdentifier: "goToCreateProfile", sender: self)
                    } else {
                        // Go to home page
                        let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar")
                        
                        guard tabBarVC != nil else {
                            return
                        }
                        
                        self.view.window?.rootViewController = tabBarVC
                        self.view.window?.makeKeyAndVisible()
                    }
                }
                
            }
            
        }
    }
    
    
}
