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
    let dateCellIdentifier = "DateTableViewCell"
    var thought: Thought?
    var listOfFormattedDates = [DateCount]()
    
    struct DateCount {
        var dateString: String
        var count: Int
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    fileprivate func configureTableView() {
        if let thought = thought {
            listOfFormattedDates = formatListOfDates(listOfDates: thought.listOfOccurrences)
        }
        tableView.register(UINib(nibName: dateCellIdentifier, bundle: nil), forCellReuseIdentifier: dateCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func formatListOfDates(listOfDates:[Date]) -> [DateCount] {
        
        // CREATE A DICT OF DATES AND COUNTS
        let dateCounts = listOfDates.reduce(into: [String: Int]()) { dict, date in
            let year = Calendar.current.component(.year, from: date)
            let month = Calendar.current.component(.month, from: date)
            let day = Calendar.current.component(.day, from: date)
            let key = "\(year)-\(month)-\(day)"
            dict[key, default: 0] += 1
        }
        
        // BREAK DICT INTO ARRAY OF OBJECTS
        var array = [DateCount]()
        for (date, count) in dateCounts {
            let dateCountStruct = DateCount.init(dateString: date, count: count)
            array.append(dateCountStruct)
        }
        return array
    }

}

extension ThoughtDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return listOfFormattedDates.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier, for: indexPath) as! DateTableViewCell
        let dateCount = listOfFormattedDates[indexPath.row]
        cell.dateLabel.text = dateCount.dateString
        cell.countLabel.text = String(dateCount.count)
        return cell
    }
    
}
