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
    var listOfOccurrences = [Date]()
    
    init(title: String) {
     self.title = title
    }
    
    required convenience init(coder decoder: NSCoder) {        
        let title = decoder.decodeObject(forKey: "title") as! String
        let listOfOccurrences = decoder.decodeObject(forKey: "listOfOccurrences") as! [Date]
        self.init(title: title)
        self.listOfOccurrences = listOfOccurrences
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(listOfOccurrences, forKey: "listOfOccurrences")
    }
}
