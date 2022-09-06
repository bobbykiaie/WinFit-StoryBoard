//
//  CreateProfileViewController.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 4/29/22.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var TextField: UITextField!
    
    
    @IBAction func CreateProfileButton(_ sender: Any) {
        //Verify user is logged in
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        let currentUser = Auth.auth().currentUser!
        
        //Get the username
        
        
       let username = TextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Check username isnt nil
        
        if username == nil || username == ""{
            //Create an error message
            return
        }
        //Check for correct formratitng
        
        //Call the user service to create profile
        UserService.createProfile(userId: currentUser.uid, username: username!) { (user) in
            if user != nil {
                
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar" )
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
        }
        //Check if it was created succesfully
        
        //If not display error
        
        
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
