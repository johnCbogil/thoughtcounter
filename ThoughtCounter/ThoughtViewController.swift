//
//  ThoughtViewController
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ThoughtViewController: UIViewController {

    @IBOutlet weak var thoughtCountLabel: UILabel!
    @IBOutlet weak var decreaseThoughtCountButton: UIButton!
    @IBOutlet weak var increaseThoughtCountButton: UIButton!
    var thoughtCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func increaseThoughtCount(_ sender: Any) {
        thoughtCount += 1
        thoughtCountLabel.text = String(thoughtCount)
        print(thoughtCount)
    }
    
    @IBAction func decreaseThoughtCount(_ sender: Any) {
        if thoughtCount > 0 {
            thoughtCount -= 1
            thoughtCountLabel.text = String(thoughtCount)
        }
        print(thoughtCount)
    }
}

