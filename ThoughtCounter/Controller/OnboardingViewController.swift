//
//  OnboardingViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/18/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        
        // Do any additional setup after loading the view.
    }
    @IBAction func getStarted(_ sender: Any) {
        let thoughtsVC = self.storyboard!.instantiateViewController(withIdentifier: "ThoughtsViewController") as! ThoughtsViewController
        let navController = UINavigationController(rootViewController: thoughtsVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.present(navController, animated:true, completion: nil)
    }
}
