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
        textField.resignFirstResponder()
        return true
    }
}
