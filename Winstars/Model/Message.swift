//
//  Message.swift
//  Winstars
//
//  Created by CHAN CHI YU on 13/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation

public struct Message: Codable {
    var user: User?
    var content: String?
    var is_archived: Bool = false
    
    init(user: User, content: String, is_archived: Bool) {
        self.user = user
        self.content = content
        self.is_archived = is_archived
    }
    
    enum CodingKeys: String, CodingKey {
          case user
          case content
          case is_archived
      }
}
