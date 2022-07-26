//
//  DatabaseManager.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import FirebaseDatabase

public class DatabaseManager{
    
    static let shared = DatabaseManager()
    
//    // MARK: - Public
//
    private let database = Database.database().reference()
    
    // Check if username and email is available
    // - Parameters
    //       - email: String representing email
    //       - username: String representing username
    public func canCreateNewUser(with email: String,username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    // Insert new user data to database
    // - Parameters
    //       - email: String representing email
    //       - username: String representing username
    //       - completion: Async callback for result if database entry succeeded

    public func insertNewUser(with email: String, username: String, completion: @escaping(Bool) -> Void){
        
        let key = email.safeDatabaseKey()
        print(key)
        
        database.child(key).setValue(["username": username]) {error, _ in
            if error == nil{
                // succeeded
                completion(true)
                return
            }
            else {
                // failed
                completion(false)
                return
            }
        }
        
    }
    
    
}

