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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Did begin editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("did finish editing")
        textField.resignFirstResponder()
        
        thought?.title = textField.text
    }
}
