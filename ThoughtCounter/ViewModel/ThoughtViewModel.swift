//
//  ThoughtViewModel.swift
//  ThoughtCounter
//
//  Created by John Bogil on 7/30/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation

class ThoughtViewModel {
    var title: String
    var count: Int
    
    init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
}
