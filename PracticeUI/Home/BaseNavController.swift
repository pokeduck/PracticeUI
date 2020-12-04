//
//  BaseNavController.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/4.
//

import UIKit.UINavigationController

class BaseNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([HomeTableViewController()], animated: false)
    }
}
