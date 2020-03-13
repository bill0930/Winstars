//
//  Post.swift
//  Winstars
//
//  Created by CHAN CHI YU on 4/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation

class Post {
    var user: User?
    var title: String = ""
    var content: String = ""
    var is_archived: Bool = false
    var message: [Message]?
    
    init(title: String, is_archived: Bool, content: String) {
        self.title = title
        self.content = content
        self.is_archived = is_archived
    }
    
}
