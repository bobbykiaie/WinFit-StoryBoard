//
//  DatabaseManager.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 6/23/22.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public func createUser(userName: String, email: String){
        print(email)
        
        let reference =  database.document("user/\(userName)")
        reference.setData(["email": email, "username": userName])
        
        
    }
    //function takes in an email and another function that takes in a User
    public func findUser(with email: String, completion: @escaping (User?) -> Void) {
        //Search database for user
        let userRef = database.collection("user").whereField("email", isEqualTo: email)
        userRef.getDocuments { snapshot, error in
            guard let retreivedUsername = snapshot?.documents.first?.data()["username"],
                  let retrievedEmail = snapshot?.documents.first?.data()["email"],
                  error == nil
            else {
                return
            }
            
            let retievedUser = User(username: retreivedUsername as! String, email: retrievedEmail as! String)
            completion(retievedUser)
        }
            
        
        
//        referance.getDocuments { snapshot, error in
//            guard let users = snapshot?.documents. else {
//            completion(nil)
//                return
//            }
            
        }
    }

