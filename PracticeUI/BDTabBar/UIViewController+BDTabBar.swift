//
// UIViewController++.swift
//
// Created by Ben for PracticeUI on 2021/3/26.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import ObjectiveC.runtime
private var kWKTabBarController = "key.wk.tabbar"
extension UIViewController {
    var wk_TabBarController: BDTabBarController? {
        set {
            objc_setAssociatedObject(self, &kWKTabBarController, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            let tabBar = objc_getAssociatedObject(self, &kWKTabBarController)
            if tabBar == nil && parent != nil {
                return parent?.wk_TabBarController
            }
            return tabBar as? BDTabBarController
        }
    }
    var wk_TabBarItem: BDTabBarItem? {
        return tabBarItem as? BDTabBarItem
    }
}
