//
//  ThoughtDetailViewController
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ThoughtDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thoughtCountLabel: UILabel!
    @IBOutlet weak var decreaseThoughtCountButton: UIButton!
    @IBOutlet weak var increaseThoughtCountButton: UIButton!
    
    var thoughtCount = 0
    var listOfDates = [Date]()
    var listOfFormattedDates = [DateCount]()
    var thought: Thought?
    
    let dateCell = "DateCountTableViewCell"
    let dateFormat = "dd.MM.yyyy"
    
    struct DateCount {
        var dateString: String
        var count: Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        if let vcTitle = thought?.title {
            title = vcTitle
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: dateCell, bundle: nil), forCellReuseIdentifier: dateCell)
    }
    
    @IBAction func increaseThoughtCount(_ sender: Any) {
        listOfDates.append(Date())
        thoughtCount += 1
        thoughtCountLabel.text = String(thoughtCount)
        listOfFormattedDates = formatListOfDates(listOfDates: listOfDates)
        tableView.reloadData()
    }
    
    @IBAction func decreaseThoughtCount(_ sender: Any) {
        if thoughtCount > 0 {
            listOfDates.removeLast()
            thoughtCount -= 1
            thoughtCountLabel.text = String(thoughtCount)
            listOfFormattedDates = formatListOfDates(listOfDates: listOfDates)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFormattedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dateCell, for: indexPath) as! DateCountTableViewCell
        let dateCount = listOfFormattedDates[indexPath.row]
        cell.dateLabel.text = dateCount.dateString
        cell.countLabel.text = String(dateCount.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

