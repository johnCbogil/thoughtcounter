//
//  ThoughtsViewController
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ThoughtsViewController: UIViewController, UIGestureRecognizerDelegate, SaveThoughtsDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addThoughtButton: UIBarButtonItem!
    
    var listOfThoughts = [Thought]()
    let thoughtCell = "ThoughtTableViewCell"
    let listOfThoughtsKey = "ListOfThoughts"
    let userDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        title = "Today's Thoughts"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        getThoughts()
    }
    
    fileprivate func configureTableView() {
        tableView.register(UINib(nibName: thoughtCell, bundle: nil), forCellReuseIdentifier: thoughtCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
    }
    
    @IBAction func addThought(_ sender: Any) {
        let newThought = Thought.init(title: "")
        let topOfList = 0
        listOfThoughts.insert(newThought, at: topOfList)
        tableView.reloadData()
        let visibleCells = tableView.visibleCells as! [ThoughtTableViewCell]
        let topCell = visibleCells[topOfList]
        topCell.textField.becomeFirstResponder()
    }
    
    func saveThoughts() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: listOfThoughts)
        userDefaults.set(encodedData, forKey: listOfThoughtsKey)
        print("Saving \(listOfThoughts.count) thoughts")
        userDefaults.synchronize()
    }

    func getThoughts() {
        if let decodedData = userDefaults.object(forKey: listOfThoughtsKey) as! Data? {
            listOfThoughts = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Thought]
            tableView.reloadData()
            print("Getting \(listOfThoughts.count) thoughts")
            userDefaults.synchronize()
        }
    }
}

extension ThoughtsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfThoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: thoughtCell, for: indexPath) as! ThoughtTableViewCell
        let thought = listOfThoughts[indexPath.row]
        cell.configureWithThought(thought: thought)
        cell.saveThoughtsDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

