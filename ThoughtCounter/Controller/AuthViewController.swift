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
        let context = LAContext()
        var error:NSError?
        
        // edit line - deviceOwnerAuthentication
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            //showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
        }
        
        // edit line - deviceOwnerAuthentication
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            // edit line - deviceOwnerAuthentication
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Privacy is a human right.", reply: { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        let thoughtsVC = self.storyboard!.instantiateViewController(withIdentifier: ThoughtsViewController.identifier) as! ThoughtsViewController
                        if let nav = self.navigationController {
                            DispatchQueue.main.async {
                                nav.pushViewController(thoughtsVC, animated: true)
                            }
                        }
                    }
                }
            })
        }else {
            // self.showAlertWith(title: "Error", message: (errorPointer?.localizedDescription)!)
        }
    }
}
