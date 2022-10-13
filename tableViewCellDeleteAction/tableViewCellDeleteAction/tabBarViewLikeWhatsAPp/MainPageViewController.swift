//
//  MainPageViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 14/04/22.
//

import UIKit

   class MainPageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

       lazy var orderedViewControllers: [UIViewController] = {
               return [
                       self.newVc(viewController: "ChatMainViewController"),self.newVc(viewController: "StatusViewController"),self.newVc(viewController: "callsViewController")]
           }()
       override func viewDidLoad() {
           super.viewDidLoad()
           self.dataSource = self
            if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
           }
       }
       func newVc(viewController: String) -> UIViewController {
           return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
       }
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController),viewControllerIndex > 0 else{
               return nil
           }
           let previousIndex = viewControllerIndex - 1
                   return orderedViewControllers[previousIndex]
       }
       //
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController), viewControllerIndex < (orderedViewControllers.count - 1)  else{
               return nil
           }
           let nextIndex = viewControllerIndex + 1
        return orderedViewControllers[nextIndex]
       }
   }
