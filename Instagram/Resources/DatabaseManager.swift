//
//  DatabaseManager.swift
//  Instagram
//
//  Created by theHinneh on 11/08/2021.
//

//import Foundation
import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Insert data into database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for completion if database entry succeded
    public func insertDataIntoDatabase(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabseKey()
        database.child(key).setValue(["username": username]) {error, _ in
            if error == nil {
                // success
                completion(true)
                return
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
}
