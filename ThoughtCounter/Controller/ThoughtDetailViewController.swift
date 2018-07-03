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
    @IBOutlet weak var thoughtTextView: UITextView!
    @IBOutlet weak var deleteThoughtButton: UIButton!
    
    struct DateCount {
        var dateString: String
        var count: Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stats"
        thoughtTextView.text = thought?.title
        thoughtTextView.delegate = self
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
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            let key = formatter.string(from: date)
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
    
    @IBAction func deleteThought(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete Thought", message: "This feature not yet implemented.", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }

        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ThoughtDetailViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        thought?.title = textView.text
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveThoughts"), object: nil, userInfo: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
