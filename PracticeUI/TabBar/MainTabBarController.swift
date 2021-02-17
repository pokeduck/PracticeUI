//
// MainTabBarController.swift
//
// Created by Ben for PracticeUI on 2021/2/17.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, ConvexTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var tabBar: UITabBar {
//        return ConvexTabBar()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc0 = TestContentPageViewController(content: "0")
        let item0 = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        vc0.tabBarItem = item0
        
        let vc1 = TestContentPageViewController(content: "1")
        let item1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        vc1.tabBarItem = item1
        
        let vc2 = TestContentPageViewController(content: "2")
        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        vc2.tabBarItem = item2
        
        viewControllers = [vc0, vc1, vc2]
            
        delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        tabBar.setNeedsDisplay()
        return true
    }
}
//
//extension MainTabBarController: UITabBarDelegate {
//
//}
