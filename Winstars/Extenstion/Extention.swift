//
//  Extention.swift
//  Winstars
//
//  Created by CHAN CHI YU on 13/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation

/// 直接将Struct或Class转成Dictionary
protocol Convertable: Codable {
    
}

extension Convertable {
    
    /// 直接将Struct或Class转成Dictionary
    func toDict() -> Dictionary<String, Any>? {
        
        var dict: Dictionary<String, Any>? = nil
        
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(self)
            
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
            
        } catch {
            print(error)
        }
        
        return dict
    }
}

public class Extension {
    public static func emojiGenerate() -> String? {
        let emojiArray = ["😀","😍","🤓","🥺","😠","🤯"
            ,"🥱", "🤗"]
        
        return emojiArray.shuffled().first
    }
}
