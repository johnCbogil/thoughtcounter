//
//  Thought.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/10/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation

class Thought: NSObject, NSCoding {
    var title: String?
    var count = 0
    
    init(title: String) {
     self.title = title
    }
    
    required convenience init(coder decoder: NSCoder) {        
        let title = decoder.decodeObject(forKey: "title") as! String
        let count = decoder.decodeInteger(forKey: "count")
        self.init(title: title)
        self.count = count
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(count, forKey: "count")
    }
}
