//
//  Message.swift
//  Winstars
//
//  Created by CHAN CHI YU on 13/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation
import MessageKit


// Represents a message within MessengerKit.
public struct Message: MessageType{
    
    public var sender: SenderType
    
    public var messageId: String
    
    public var sentDate: Date
    
    public var kind: MessageKind
    
}
