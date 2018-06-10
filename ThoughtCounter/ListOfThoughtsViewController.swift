//
//  ListOfThoughtsViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ListOfThoughtsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addThoughtButton: UIBarButtonItem!
    
    var listOfThoughts = ["thought one","thought two","thought three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        title = "List of thoughts"
        tableView.register(UINib(nibName: "ThoughtTableViewCell", bundle: nil), forCellReuseIdentifier: "ThoughtTableViewCell")
    }
    
    @IBAction func addThought(_ sender: Any) {
        listOfThoughts.insert("", at: 0)
        tableView.reloadData()
        if let cell = tableView.visibleCells[0] as? ThoughtTableViewCell {
            if let textfield = cell.textField {
                textfield.becomeFirstResponder()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfThoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = ThoughtTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ThoughtTableViewCell")
        let cell = tableView .dequeueReusableCell(withIdentifier: "ThoughtTableViewCell", for: indexPath)
        cell.textLabel?.text = listOfThoughts[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThoughtViewController") as? ThoughtViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfThoughts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
