//
//  Group.swift
//  Winstars
//
//  Created by CHAN CHI YU on 15/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Group {
    
    let id: String?
    let name: String
    let listNum: Int
    
    init(name: String, listNum: Int) {
        id = nil
        self.name = name
        self.listNum = listNum
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String else {
            return nil
        }
        
        guard let listNum = data["listNum"] as? Int else {
                   return nil
               }
        
        id = document.documentID
        self.name = name
        self.listNum = listNum
    }
    
    init?(document: DocumentSnapshot) {
        let data = document.data()
        
        guard let name = data!["name"] as? String else {
            return nil
        }
        
        guard let listNum = data!["listNum"] as? Int else {
                          return nil
                      }
        
        id = document.documentID
        self.name = name
        self.listNum = listNum
    }
    
}

extension Group: DatabaseRepresentation {
    
    var representation: [String : Any] {
        var rep = [
            "name": name ,
            "listNum": listNum
            ] as [String : Any]
        
        if let id = id {
            rep["id"] = id
        }
        
        
        
        return rep
    }
    
}

extension Group: Comparable {
  
  static func == (lhs: Group, rhs: Group) -> Bool {
    return lhs.id == rhs.id
  }
  
    //  for  groups.sort()
  static func < (lhs: Group, rhs: Group) -> Bool {
    return lhs.listNum < rhs.listNum
  }
    


}
