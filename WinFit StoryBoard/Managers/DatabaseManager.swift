//
//  DatabaseManager.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 6/23/22.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public func createUser(userName: String, email: String){
        print(email)
        
        let reference =  database.document("user/\(userName)")
        reference.setData(["email": email, "username": userName])
        
        
    }
    
    
//MARK: - User Related Functions
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
        }
    
    
//MARK: - Competition related functions
    
    public func joinCompetition(compName: String?, handler: @escaping(_ compList: NSArray) -> Void){
        guard compName != nil else {
            return
        }
        let currentUser = UserDefaults.standard.string(forKey: "username")!
        let compRef = database.document("Competitions/\(compName!)")
        compRef.updateData(["members": FieldValue.arrayUnion(["\(currentUser)"])])
        let reference =  database.document("user/\(UserDefaults.standard.string(forKey: "username")!)")
      reference.updateData(["compName": FieldValue.arrayUnion(["\(compName!)"])])
          
            reference.getDocument { snapshot, error in
                
                guard let retrievedComps = snapshot?.data() else{
                    return
                }
                let blankComp: NSArray = ["No Comps"]
                let comps = (retrievedComps["compName"] as? NSArray) ?? blankComp
            
                handler(comps)
         
            }
    }
    
    public func addCompetition(compName: String?, handler: @escaping (_ compList: NSArray) -> Void)  {
        guard compName != nil else {
            let reference =  database.document("user/\(UserDefaults.standard.string(forKey: "username")!)")
            reference.getDocument { snapshot, error in
                
                guard let retrievedComps = snapshot?.data() else{
                    return
                }
                print(retrievedComps)
                let emptyComp: NSArray = ["No Comps"]
                
                let comps: NSArray
                
                guard retrievedComps.count != 0 else {
                    comps = [emptyComp]
                    return
                }
                 comps = (retrievedComps["compName"] as? NSArray) ?? emptyComp
                
                guard comps.count != 0 else {
                    let noComp: NSArray = ["No Competition"]
                    handler(noComp)
                    return
                }
                if comps.count != 0 {
                    handler(comps)
                }
            
         
            }
            
            
            
            return
        }
        let reference =  database.document("user/\(UserDefaults.standard.string(forKey: "username")!)")
      reference.updateData(["compName": FieldValue.arrayUnion(["\(compName!)"])])
          
            reference.getDocument { snapshot, error in
                
                guard let retrievedComps = snapshot?.data() else{
                    let emptyComp: NSArray = ["No Comp"]
                    handler(emptyComp)
                    return
                }
                let emptyComp: NSArray = ["No Comp"]
                let comps = (retrievedComps["compName"] as? NSArray) ?? emptyComp
            
                handler(comps)
         
            }

        let compref = database.document("Competitions/\(compName!)")
        compref.setData(["compName": compName!, "members":[ "\(UserDefaults.standard.string(forKey: "username")!)"]])
    }
    
    //function takes in an email and another function that takes in a User

 //MARK: - Competition page functions
    
    
    public func getListOfCompetitionMembers(
        compName: String,
        handler: @escaping((Array<Any>) -> Void)) {
        let compRef = database.document("Competitions/\(compName)")
        compRef.getDocument { snapshot, error in
            guard let theData = snapshot?.data() else {
                return
            }
           
            var membersList = [String]()
            let mapped = theData.compactMap { array in
                array.value as? NSArray
    
            }
         
            mapped.forEach { list in
                list.forEach { item in
                    membersList.append(item as? String ?? "none")
                }
            }
            print(membersList)
            handler(membersList)

    }
        
    }
    
    }

