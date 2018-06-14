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

protocol UpdateThoughtModelDelegate {
    func updateThoughtModel()
}

class ThoughtTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var saveThoughtsDelegate: SaveThoughtsDelegate!
    var updateThoughtModelDelegate: UpdateThoughtModelDelegate!
    
    var thought: Thought?

    override func awakeFromNib() {
        super.awakeFromNib()
     
        textField.delegate = self
    }
    
    func configureWithThought(thought:Thought) {
        self.thought = thought
        textField.text = self.thought?.title
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateThought()
        textField.resignFirstResponder()
        return true
    }
    
    // TODO: THIS VIEW SHOULD NOT BE UPDATING THE MODEL
    func updateThought() {
        thought?.title = textField.text
        saveThoughtsDelegate.saveThoughts()
    }
}
