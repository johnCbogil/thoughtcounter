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

    init(thought:Thought) {
        if let title = thought.title {
            self.title = title
        }
        else {
            self.title = ""
        }
        self.count = thought.listOfOccurrences.filter { (date) -> Bool in
            return Calendar.current.isDateInToday(date)
            }.count
    }
}
