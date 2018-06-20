//
//  AppDelegate.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/8/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit
import Firebase
import Instabug

protocol UpdateThoughtCountDelegate {
    func updateThoughtCount()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var updateThoughtCountDelegate:UpdateThoughtCountDelegate!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Instabug.start(withToken: "62c2c28bca77c97d9b2acabe5bddb525", invocationEvent: .shake)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let initialViewController: UIViewController
        
        if launchedBefore  {
            print("Not first launch.")
            initialViewController = storyboard.instantiateViewController(withIdentifier: "ThoughtsViewController")
        }
        else {
            initialViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
        }
        
        let navigationController = UINavigationController(rootViewController: initialViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        updateThoughtCountDelegate.updateThoughtCount()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

