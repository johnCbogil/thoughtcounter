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
    let questionsArray = ["What is an intrusive thought?", "What can I do to treat intrusive thoughts?", "How does counting help?" ]
    let answersArray = ["An intrusive thought is an unwelcome involuntary thought, image, or unpleasant idea that can feel difficult to manage or eliminate.","One type of treatment is to monitor these thoughts by counting them.","Self-monitoring is proven to help develop self-control and decrease intrusive thoughts. At first you will notice that the number increases; this will happen for several days as you get better at identifying intrusive thoughts. Soon you will see that the daily total plateaus after 7 - 10 days, followed by a decrease in intrusive thoguhts."]

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
        
//        self.setViewControllers([listOfViewControllers[0]] as [OnboardingViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)

        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: OnboardingViewController = viewController as! OnboardingViewController
        var index = pageContent.index
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: OnboardingViewController = viewController as! OnboardingViewController
        var index = pageContent.index
        if (index == NSNotFound)
        {
            return nil;
        }
        
        index += 1
        if (index == questionsArray.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> OnboardingViewController {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! OnboardingViewController
        pageContentViewController.questionLabel.text = "\(questionsArray[index])"
        pageContentViewController.answerLabel.text = "\(answersArray[index])"
        pageContentViewController.index = index
        return pageContentViewController
    }
}
