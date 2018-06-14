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
    init(title: String) {
     self.title = title
    }
    
    required convenience init(coder decoder: NSCoder) {        
        let title = decoder.decodeObject(forKey: "title") as! String
        self.init(title: title)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
    }
}
