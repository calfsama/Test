//
//  AuthManager.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import FirebaseAuth
public class AuthManager{
    static let shared = AuthManager()

// MARK: - Public
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping(Bool) -> Void) {

        /*
         - Check if username is available
         - Check if email is available
         - Create account
         - Insert account to database

         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
//                /*
//                 - Create account
//                 - Insert account to database
//                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else{
                        // Firebase auth coudn't create account.
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted{
                            completion(true)
                            return
                        }
                        else {
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {

                // Either username or email doesn't exist.
                completion(false)
            }

        }

    }
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping(Bool) -> Void){

        if let email = email {
            // Email log in
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            // username log in
            print(username)
        }
    }
//public class AuthManager{
//    static var shared = AuthManager()
//    
//    // Attempt to log out firebase user
//    public func LogOut(completion:(Bool)-> Void){
//        do{
//            try Auth.auth().signOut()
//            completion(true)
//            return
//        }
//        catch {
//            print(error)
//            completion(false)
//            return
//        }
//        
//    }
//}
}
