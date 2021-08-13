//
//  AuthenticationPageController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
class AuthenticationPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    
    var currentPage : Int = 0
    
    var onSwipeDelegate : ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self

        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")

        // etc ...

        pages.append(p1)
        pages.append(p2)

        // etc ...

        setViewControllers([p1], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
    }
    
    func navigateToPage(pageNo : Int){
        if pageNo == 1 {
            goToNextPage()
        } else {
            goToPreviousPage()
        }
        onSwipeDelegate?(pageNo)
        currentPage = pageNo
    }
    
    func goToNextPage() {
           guard let currentViewController = self.viewControllers?.first else { return }
           guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
           setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }

    func goToPreviousPage() {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
       setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if  completed == true, finished == true {
            if previousViewControllers[0] == pages[1] {
                onSwipeDelegate?(0)
                currentPage = 0
                
            } else {
                onSwipeDelegate?(1)
                currentPage = 1
            }
        }
    }


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
       
        let cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
         if cur == 0 { return nil }

        var prev = (cur - 1) % pages.count
        if prev < 0 {
            prev = pages.count - 1
        }
                return pages[prev]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
         
        let cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        if cur == (pages.count - 1) { return nil }

        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }

    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
}
