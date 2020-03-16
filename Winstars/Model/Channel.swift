//
//  Post.swift
//  Winstars
//
//  Created by CHAN CHI YU on 4/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Channel {
    
    let id: String?
    let name: String
    let author: String
    let emoji: String
    let timestamp: Timestamp
    
    init(name: String, author: String, emoji: String) {
        id = nil
        self.author = author
        self.name = name
        self.emoji = emoji
        self.timestamp = Timestamp.init()
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String else {
            return nil
        }
        
        guard let author = data["author"] as? String else {
            return nil
        }
        guard let emoji = data["emoji"] as? String else {
            return nil
        }
        
        guard let timestamp = data["timestamp"] as? Timestamp else {
            return nil
        }
        
        id = document.documentID
        self.name = name
        self.author = author
        self.emoji = emoji
        self.timestamp = timestamp
    }
    
}

extension Channel: DatabaseRepresentation {
    
    var representation: [String : Any] {
        var rep = [
            "name": name ,
            "author": author,
            "emoji": emoji,
            "timestamp": timestamp
            ] as [String : Any]
        
        if let id = id {
            rep["id"] = id
        }
        
    
        return rep
    }
    
}

extension Channel: Comparable {
    static func < (lhs: Channel, rhs: Channel) -> Bool {
        return rhs.timestamp.seconds < lhs.timestamp.seconds

    }
    
    
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

