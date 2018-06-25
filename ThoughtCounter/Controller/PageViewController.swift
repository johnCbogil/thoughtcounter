//
//  PageViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 6/24/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var listOfViewControllers = [OnboardingViewController]()
    let pageCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc1.index = 0
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc2.index = 1
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc3.index = 2
        listOfViewControllers.append(contentsOf: [vc1,vc2,vc3])
        
        setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: OnboardingViewController = viewController as! OnboardingViewController
        var index = pageContent.index
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: OnboardingViewController = viewController as! OnboardingViewController
        var index = pageContent.index
        if (index == NSNotFound) {
            return nil;
        }
        
        index += 1
        if (index == pageCount) {
            return nil;
        }
        return getViewControllerAtIndex(index: index)
    }
    
    fileprivate func getViewControllerAtIndex(index: NSInteger) -> OnboardingViewController {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        pageContentViewController.index = index
        return pageContentViewController
    }
}
