//
//  AuthManager.swift
//  Instagram
//
//  Created by theHinneh on 11/08/2021.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)) {
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        //        else if let username = username {
        //
        //        }
    }
    
    public func registerUserNewUser(username: String?, email: String?, password: String, completion: @escaping(Bool) -> Void) {
        /*
         - check if username already exist
         - check if email already exist
         - create account
         - insert account into database
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email!, username: username!) { canCreate in
            if canCreate{
                Auth.auth().createUser(withEmail: email!, password: password) { authResult, error in
                    guard error == nil, authResult != nil else {
                        // firebase could not create account
                        completion(false)
                        return
                    }
                    
                    // Create user
                    DatabaseManager.shared.canCreateNewUser(with: email!, username: username!) {inserted in
                        if inserted {
                            // inserted into database
                            completion(true)
                            return
                        } else {
                            // failed to insert into database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // either username or email exist
                completion(false)
            }
        }
    }
}
