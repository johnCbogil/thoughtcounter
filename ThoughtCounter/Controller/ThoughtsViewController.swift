//
//  ThoughtsViewController
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit
import Instabug

class ThoughtsViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addThoughtButton: UIBarButtonItem!
    @IBOutlet weak var sendFeedbackButton: UIButton!
    
    var listOfThoughts = [Thought]()
    let thoughtCell = "ThoughtTableViewCell"
    let listOfThoughtsKey = "ListOfThoughts"
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
        getThoughts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateThoughtCountWhenAppBecomesActive), name: NSNotification.Name(rawValue: "updateThoughtCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveThoughts), name: NSNotification.Name(rawValue: "saveThoughts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteThought), name: NSNotification.Name(rawValue: "deleteThought"), object: nil)
        
        if listOfThoughts.count == 0 {
            addThought(self)
        }
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ThoughtsViewController.hideKeyboard))
        tableView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        tableView.endEditing(true)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
        tableView.reloadData()
    }
    
    fileprivate func configureNavBar() {
        title = "Today's Thought Count"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(presentOnboarding), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.leftBarButtonItem = infoBarButtonItem
    }
    
    fileprivate func configureTableView() {
        tableView.register(UINib(nibName: thoughtCell, bundle: nil), forCellReuseIdentifier: thoughtCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive;
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
    
    @objc func saveThoughts() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: listOfThoughts)
        userDefaults.set(encodedData, forKey: listOfThoughtsKey)
        print("Saving \(listOfThoughts.count) thoughts")
        userDefaults.synchronize()
    }
    
    fileprivate func getThoughts() {
        if let decodedData = userDefaults.object(forKey: listOfThoughtsKey) as! Data? {
            listOfThoughts = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Thought]
            tableView.reloadData()
            print("Getting \(listOfThoughts.count) thoughts")
            userDefaults.synchronize()
        }
    }
    
    @objc func deleteThought(notification:Notification) {
        if let userInfo = notification.userInfo {
            let thought = userInfo["thought"] as! Thought
            if let index = listOfThoughts.index(of: thought) {
                listOfThoughts.remove(at: index)
                tableView.reloadData()
                saveThoughts()
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func updateThoughtCountWhenAppBecomesActive() {
        tableView.reloadData()
    }
    
    @objc fileprivate func presentOnboarding() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController")
        navigationController?.present(vc, animated: true, completion: nil)
        print("Display info vc, need to find a solution here")
    }
    
    @IBAction func sendFeedback(_ sender: Any) {
        Instabug.invoke()
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ThoughtDetailViewController") as! ThoughtDetailViewController
        detailVC.thought = listOfThoughts[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

