//
//  OnboardingViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/18/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    let questionsArray = ["What is an intrusive thought?", "What can I do to treat intrusive thoughts?", "How does counting help?" ]
    let answersArray = ["An intrusive thought is an unwelcome involuntary thought, image, or unpleasant idea that can feel difficult to manage or eliminate.","One type of treatment is to monitor these thoughts by counting them.","Self-monitoring is proven to help develop self-control and decrease intrusive thoughts. At first you will notice that the number increases; this will happen for several days as you get better at identifying intrusive thoughts. Soon you will see that the daily total plateaus after 7 - 10 days, followed by a decrease in intrusive thoughts."]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        getStartedButton.setTitle("Get Started", for: .normal)
        questionLabel.text = questionsArray[index]
        answerLabel.text = answersArray[index]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        if index == 2 {
            getStartedButton.isHidden = false
        }
        else {
            getStartedButton.isHidden = true
        }
    }
    
    @IBAction func getStarted(_ sender: Any) {
        let thoughtsVC = self.storyboard!.instantiateViewController(withIdentifier: "ThoughtsViewController") as! ThoughtsViewController
        navigationController?.pushViewController(thoughtsVC, animated: true)
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        dismiss(animated: true, completion: nil)
    }
}
