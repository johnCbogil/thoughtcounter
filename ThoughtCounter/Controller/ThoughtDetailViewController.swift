//
//  ThoughtDetailViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/20/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ThoughtDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dateCellIdentifier = ""
    var thought: Thought?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ThoughtDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let thought = thought {
            return thought.listOfOccurrences.count
        }
        else { return 0 }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier, for: indexPath) as! DateTableViewCell
        return cell
    }
    
}
