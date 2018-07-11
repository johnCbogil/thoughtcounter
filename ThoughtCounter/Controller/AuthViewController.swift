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

    authenticate(self)
        
    }
    
    @IBAction func authenticate(_ sender: Any) {
        // 1
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Privacy is a human right."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] (success, authenticationError) in
                
                DispatchQueue.main.async {
                    if success {
                        let thoughtsVC = self.storyboard!.instantiateViewController(withIdentifier: ThoughtsViewController.identifier) as! ThoughtsViewController
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
}
