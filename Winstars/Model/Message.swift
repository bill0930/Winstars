//
//  Message.swift
//  Winstars
//
//  Created by CHAN CHI YU on 13/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Firebase
import MessageKit
import FirebaseFirestore
import FirebaseAuth

struct Message: MessageType {
    
    let sender: SenderType
    let id: String?
    let content: String
    let sentDate: Date
    
    var kind: MessageKind {
        return .text(content)
    }
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    init(user: User, content: String) {
        sender = Sender(id: user.uid, displayName: AppSettings.displayName)
        self.content = content
        sentDate = Date()
        id = nil
    }

    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        print(data.debugDescription)
        guard let sentDate = data["created"] as? Timestamp else {
            print( "cannot get data[created] ")
            return nil
        }
        guard let senderID = data["senderID"] as? String else {
            print( "cannot get data[senderID] ")
            return nil
        }
        guard let senderName = data["senderName"] as? String else {
             print( "cannot get data[senderName] ")
            return nil
        }
        
        
        id = document.documentID

        self.sentDate = sentDate.dateValue()
        sender = Sender(id: senderID, displayName: senderName)

        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            content = ""
        } else {
            return nil
        }
        
    }
    
}

extension Message: DatabaseRepresentation {
    
    var representation: [String : Any] {
        var rep: [String : Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName
        ]
        
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        
        return rep
    }
    
}

extension Message: Comparable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}
