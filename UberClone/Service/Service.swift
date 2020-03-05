//
//  Service.swift
//  UberClone
//
//  Created by Pushpank Kumar on 05/03/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

struct Service {
    
    let currentUserId = Auth.auth().currentUser?.uid
    
    static let shared = Service()
    
    func fetchUserData() {
        
        print("current userid ", currentUserId!)
        
        REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            print("There are many \(snapshot)")
        }
        print("DEBUG: Fetch user data here...")
    }
}

