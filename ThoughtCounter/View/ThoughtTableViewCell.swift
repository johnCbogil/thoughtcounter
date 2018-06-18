//
//  ThoughtTableViewCell.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/9/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

protocol SaveThoughtsDelegate {
    func saveThoughts()
}

class ThoughtTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    var thought: Thought?
    var saveThoughtsDelegate: SaveThoughtsDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(increaseCount))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
    }
    
    func configureWithThought(thought:Thought) {
        self.thought = thought
        textField.text = thought.title
        countLabel.text = String(thought.count)
    }
    
    @objc func increaseCount() {
        print("increase count")
        if let thought = thought {
            thought.count += 1
            countLabel.text = String(thought.count)
            saveThoughtsDelegate.saveThoughts()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        thought?.title = textField.text
        saveThoughtsDelegate.saveThoughts()
        return true
    }
}
