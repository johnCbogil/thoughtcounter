//
//  ThoughtViewController
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ThoughtViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thoughtCountLabel: UILabel!
    @IBOutlet weak var decreaseThoughtCountButton: UIButton!
    @IBOutlet weak var increaseThoughtCountButton: UIButton!
    var thoughtCount = 0
    var listOfDates = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func increaseThoughtCount(_ sender: Any) {
        listOfDates.append(Date())
        thoughtCount += 1
        thoughtCountLabel.text = String(thoughtCount)
        print(thoughtCount)
    }
    
    @IBAction func decreaseThoughtCount(_ sender: Any) {
        if thoughtCount > 0 {
            listOfDates.removeLast()
            thoughtCount -= 1
            thoughtCountLabel.text = String(thoughtCount)
        }
        print(thoughtCount)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "DateCell")
        let date = listOfDates[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: date)
        cell.textLabel?.text = dateString
        return cell
    }
}

