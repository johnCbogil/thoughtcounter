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
    var thoughtCount:Int = 0
    
    var thought: Thought?

    override func awakeFromNib() {
        super.awakeFromNib()
     
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(increaseCount))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
        textField.delegate = self
    }
    
    func configureWithThought(thought:Thought) {
        self.thought = thought
        textField.text = self.thought?.title
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        thought?.title = textField.text
        return true
    }
    
    @objc func increaseCount() {
        thoughtCount += 1
        countLabel.text = String(thoughtCount)
    }
}
