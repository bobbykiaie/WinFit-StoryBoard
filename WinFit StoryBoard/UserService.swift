//Connection to DB
//  UserService.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 4/29/22.
//

import Foundation
import FirebaseFirestore


class UserService {
    //Checks for users on DB and returns user data
    //Creates new profile for users
    
    static func createProfile(userId: String, username: String, completion: @escaping (WinFitUser?) -> Void) {
        
        let profileData = ["username":username]
        
        //Get Firestore reference
        let db = Firestore.firestore()
        //Create hte document for the user id
        db.collection("users").document(userId).setData(profileData) { (error) in
            if error == nil {
                var u = WinFitUser()
                u.username = username
                u.userId = userId
                
                completion(u)
            } else {
                completion(nil)
            }
        }    }
    
    
    //Check for  user data using the UID from the loginViewController
    static func retrieveProfile(userId: String, completion: @escaping (WinFitUser?) -> Void ) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            if error != nil || snapshot == nil {
                return
            }
            
            if let profile = snapshot!.data(){
                // Profile was found create a new WinFit User
                 var u = WinFitUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                
                completion(u)
                
            } else {
                completion(nil)
            }
        }
        
    }
    
    
}
