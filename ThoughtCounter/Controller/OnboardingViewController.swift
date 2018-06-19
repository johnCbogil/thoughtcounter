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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func getStarted(_ sender: Any) {
        let thoughtsVC = self.storyboard!.instantiateViewController(withIdentifier: "ThoughtsViewController") as! ThoughtsViewController
        navigationController?.pushViewController(thoughtsVC, animated: true)
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
}
