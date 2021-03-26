//
// BDBaseViewController.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        funcLog()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        funcLog()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        funcLog()
    }


}
extension BDBaseViewController {
    var bdTabBarItem: BDTabBarItem? {
        return tabBarItem as? BDTabBarItem
    }
    
    var bdTabBarController: BDTabBarController? {
        var currentVC = self as UIViewController
        while let currentParent = currentVC.parent {
            if let bdParent = parent as? BDTabBarController {
                return bdParent
            }
            currentVC = currentParent
        }
        return nil
    }
}
 
