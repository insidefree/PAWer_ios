//
//  Animal.swift
//  PAWer
//
//  Created by Denis Sorokin on 04/11/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import Foundation
import Firebase

struct Animal {
    let name: String
    let userId: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(name: String, userId: String){
        self.name = name
        self.userId = userId
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
