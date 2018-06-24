//
//  PageViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/24/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc1.index = 0
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc2.index = 1
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc3.index = 2
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
}
