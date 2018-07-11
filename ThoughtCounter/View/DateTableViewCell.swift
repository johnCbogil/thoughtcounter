//
//  DateTableViewCell.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/20/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    static let identifier = "DateTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
