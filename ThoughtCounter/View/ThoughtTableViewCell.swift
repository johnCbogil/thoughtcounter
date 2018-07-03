//
//  ThoughtTableViewCell.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/9/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ThoughtTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    var thought: Thought?
    var todaysCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(increaseCount))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
        
        todaysCount = 0
        if let thought = thought {
            for date in thought.listOfOccurrences {
                if Calendar.current.isDateInToday(date) {
                    todaysCount += 1
                }
            }
            countLabel.text = String(todaysCount)
        }
    }
    
    func configureWithThought(thought:Thought) {
        self.thought = thought
        textField.text = thought.title
        
        todaysCount = 0
        for date in thought.listOfOccurrences {
            if Calendar.current.isDateInToday(date) {
                todaysCount += 1
            }
        }
        countLabel.text = String(todaysCount)
    }
    
    @objc func increaseCount() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
        todaysCount = 0
        print("increase count")
        if let thought = thought {
            let currentDate = Date()
            thought.listOfOccurrences.append(currentDate)
            for date in thought.listOfOccurrences {
                if Calendar.current.isDateInToday(date) {
                    todaysCount += 1
                }
            }
            countLabel.text = String(todaysCount)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveThoughts"), object: nil, userInfo: nil)

        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        thought?.title = textField.text
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveThoughts"), object: nil, userInfo: nil)

        return true
    }
}
