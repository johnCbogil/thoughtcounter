//
//  RxTableViewCell.swift
//  ThoughtCounter
//
//  Created by John Bogil on 9/16/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit
import Anchors

class RxTableViewCell: UITableViewCell {

    // MARK: VIEWS
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.textColor = .black
        return label
    }()

    // MARK: INIT
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(nameLabel)

        activate(
         nameLabel.anchor.leading.constant(10),
         nameLabel.anchor.paddingVertically(10)
        )
    }
}

extension RxTableViewCell {

    // MARK: API
    func configure(text: String) {
        nameLabel.text = text
    }
}
