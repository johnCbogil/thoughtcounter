//
//  ThoughtTableViewCell.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/9/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit
import UITextView_Placeholder;

struct ThoughtTableViewCellModel {
    var title: String
    var count: Int
    
    init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
}

class ThoughtTableViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    private var todaysCount = 0
    
    public var updateCountBlock: ((Int)->Void)?
    public var updateThoughtTitleBlock: ((String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureTextView()
        self.configureGestureRecognizers()
    }
    
    fileprivate func configureTextView() {
        self.textView.delegate = self
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.black.cgColor
        self.textView.placeholder = "Add thought here..."
    }
    
    fileprivate func configureGestureRecognizers() {
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(increaseCount))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(decreaseCount))
        leftSwipe.direction = .left
        
        self.addGestureRecognizer(rightSwipe)
        self.addGestureRecognizer(leftSwipe)
    }
    
    public func configureWithThought(cellModel: ThoughtTableViewCellModel) {
        self.todaysCount = cellModel.count
        self.textView.text = cellModel.title
        self.countLabel.text = "\(self.todaysCount)"
    }
    
    @objc func increaseCount() {
        self.updateCount(1)
    }
    
    @objc func decreaseCount() {
        if self.todaysCount == 0 { return }
        
        self.updateCount(-1)
    }
    
    // TODO CHANGE THIS NAME TO REFLECT COUNT AND TEXT
    private func updateCount(_ count: Int) {
        self.generateHapticFeedback()
        
        // Update the thought model
        self.updateCountBlock?(count)
        
        // Update the cell's UI
        self.todaysCount += count
        self.countLabel.text = "\(self.todaysCount)"
    }
    
    fileprivate func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            contentView.endEditing(true)
            self.updateThoughtTitleBlock?(textView.text)
            return false
        }
        else {
            return true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateThoughtTitleBlock?(textView.text)        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.updateThoughtTitleBlock = nil
        self.updateCountBlock = nil
    }
}
