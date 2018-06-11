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
    var thought: Thought?
    
    let dateCell = "DateCell"
    let dateFormat = "dd.MM.yyyy"
    
    // TODO: NEED TO CREATE FAKE DATE OBJECTS FOR TESTING
    
    func parseDates() {
        
        // THIS WHAT I NEED
        //https://stackoverflow.com/questions/42981122/swift-map-array-of-objects-alphabetically-by-namestring-into-separate-letter
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
    }
    
    @IBAction func increaseThoughtCount(_ sender: Any) {
        listOfDates.append(Date())
        thoughtCount += 1
        thoughtCountLabel.text = String(thoughtCount)
        tableView.reloadData()
    }
    
    @IBAction func decreaseThoughtCount(_ sender: Any) {
        if thoughtCount > 0 {
            listOfDates.removeLast()
            thoughtCount -= 1
            thoughtCountLabel.text = String(thoughtCount)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: dateCell)
        let date = listOfDates[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: date)
        cell.textLabel?.text = dateString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

