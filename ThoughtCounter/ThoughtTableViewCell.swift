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
    var saveThoughtsDelegate: SaveThoughtsDelegate!
    
    var thought: Thought?

    override func awakeFromNib() {
        super.awakeFromNib()
     
        textField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Did begin editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateThought()
        print("did finish editing")
        textField.resignFirstResponder()
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
