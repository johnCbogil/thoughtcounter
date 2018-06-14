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
    let thoughtDetailVC = "ThoughtDetailViewController"
    let listOfThoughtsKey = "ListOfThoughts"
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        title = "Thoughts"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        getThoughts()
    }
    
    fileprivate func configureTableView() {
        tableView.register(UINib(nibName: thoughtCell, bundle: nil), forCellReuseIdentifier: thoughtCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addThought(_ sender: Any) {
        let newThought = Thought.init(text: "")
        let topOfList = 0
        listOfThoughts.insert(newThought, at: topOfList)
        tableView.reloadData()
        var editCell: ThoughtTableViewCell
        let visibleCells = tableView.visibleCells as! [ThoughtTableViewCell]
        for cell in visibleCells {
            if (cell.thought === newThought) {
                editCell = cell
                editCell.textField.becomeFirstResponder()
                break
            }
        }
    }
    
    func saveThoughts() {
        DispatchQueue.main.async {
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.listOfThoughts)
            self.userDefaults.set(encodedData, forKey: self.listOfThoughtsKey)
            self.userDefaults.synchronize()
        }
    }
    
    func getThoughts() {
        if let decodedData  = userDefaults.object(forKey: listOfThoughtsKey) as! Data? {
            listOfThoughts = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Thought]
            tableView.reloadData()
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ThoughtsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfThoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: thoughtCell, for: indexPath) as! ThoughtTableViewCell
        let thought = listOfThoughts[indexPath.row]
        cell.thought = thought
        cell.textField?.text = thought.title
        cell.saveThoughtsDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: thoughtDetailVC) as? ThoughtDetailViewController {
            if let navigator = navigationController {
                viewController.thought = listOfThoughts[indexPath.row]
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfThoughts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveThoughts()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

