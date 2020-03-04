//
//  Post.swift
//  Winstars
//
//  Created by CHAN CHI YU on 4/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation

class Post {
    var title: String = ""
    var content: String
    var is_archived: Bool
    var comment_count: Int = 0
    
    init(title: String, is_archived: Bool, content: String) {
        self.title = title
        self.content = content
        self.is_archived = is_archived
        self.comment_count = 0
        
    }
    
}
