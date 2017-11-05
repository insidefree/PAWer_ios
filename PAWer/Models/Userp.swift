//
//  Userp.swift
//  PAWer
//
//  Created by Denis Sorokin on 04/11/2017.
//  Copyright © 2017 Denis Sorokin. All rights reserved.
//

import Foundation
import Firebase

struct Userp {
    let uid: String
    let email: String
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email!
    }
}
