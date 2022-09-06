//
//  AuthManager.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 6/22/22.
//

import Foundation
import FirebaseAuth


struct User: Codable {
    let username: String
    let email: String
}

final class AuthManager{
    static let shared = AuthManager()
    
    private init () {}
    
    let auth = Auth.auth() //So we dont have to write Auth.auth 100 times
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    
    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }
    
    public func signUp(
    email: String,
    username: String,
    password: String,
//    profilePicture: Data?,
    completion: @escaping (Result<User, Error>) -> Void)
    {
    let newUser = User(username: username, email: email)
        
        auth.createUser(withEmail: newUser.email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(AuthError.newUserCreation))
                print("error in the createUser AuthManager")
                return
            }
            
            
            DatabaseManager.shared.createUser(userName: username, email: email)
            completion(.success(newUser))
        }
}
    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void){
        DatabaseManager.shared.findUser(with: email) { user in
            guard let user = user else {
               
                print("No User")
                return
            }
            print("printing user from auth")
           print(user)
            self.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.email, forKey: "email")
                completion(.success(user))
            }
        }
        
        
    }
    
    public func signOut(
        completion: @escaping (Bool) -> Void
    ) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
    }
    
}
