//
//  DateCountTableViewCell.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/12/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class DateCountTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
