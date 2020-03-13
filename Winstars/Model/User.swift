//
//  User.swift
//  Winstars
//
//  Created by CHAN CHI YU on 13/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation

class User {
    
    var id: Int?
    var username: String
    var email: String
    var password: String
    var is_verified: Bool = false
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}
