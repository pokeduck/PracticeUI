//
// UIViewController++.swift
//
// Created by Ben for PracticeUI on 2021/3/26.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

extension UIViewController {
    func wk_setTabBarController(vc: UIViewController) {
        //UnsafeRawPointer(#selector(wk_tabBarController))
        var a = #selector(wk_tabBarController)
        objc_setAssociatedObject(self, &a, tabBarController, .OBJC_ASSOCIATION_ASSIGN)
    }
}

extension UIViewController {
    @objc func wk_tabBarController() -> BDTabBarController? {
        var a = #selector(wk_tabBarController)
        let tabBar = objc_getAssociatedObject(self, &a)
        if tabBar == nil && parent != nil {
            return parent?.wk_tabBarController()
        }
        return tabBar as? BDTabBarController
    }
    
    @objc func wk_tabBarItem() -> BDTabBarItem? {
        let tabBarController = wk_tabBarController()
        let index = tabBarController?.indexForViewController(vc: self) ?? 0
        return tabBarController?.tabBar.items?[index]
    }
    
    @objc func wk_setBarItem(item: BDTabBarItem) {
        guard let tabBarController = wk_tabBarController() else { return }
        
        let tabBar = tabBarController.tabBar
        guard let items = tabBar.items else { return }
        let index = tabBarController.indexForViewController(vc: self)
        
        let muArr = NSMutableArray(array: items)
        
        muArr.replaceObject(at: index, with: item)
        tabBar.items = items
    }
}
