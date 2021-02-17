//
// MainTabBarController.swift
//
// Created by Ben for PracticeUI on 2021/2/17.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override var tabBar: UITabBar {
        return ConvexTabBar()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViewControllers([TestContentPageViewController(content: "1"), TestContentPageViewController(content: "2")], animated: false)
        let item0 = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        let item1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        // Do any additional setup after loading the view.
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
