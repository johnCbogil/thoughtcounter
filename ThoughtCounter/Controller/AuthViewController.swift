//
//  AuthViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 7/10/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] (success, authenticationError) in
                
                DispatchQueue.main.async {
                    if success {
                        let thoughtsVC = self.storyboard!.instantiateViewController(withIdentifier: "ThoughtsViewController") as! ThoughtsViewController
                        if let nav = self.navigationController {
                            DispatchQueue.main.async {
                                nav.pushViewController(thoughtsVC, animated: true)
                            }
                        }
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometry
        }
    }
    
    @IBAction func authenticate(_ sender: Any) {
        
    }
}