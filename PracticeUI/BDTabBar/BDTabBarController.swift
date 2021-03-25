//
// BDTabBarController.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDTabBarController: UIViewController {

    private var selectedIndex: Int = 0
    
    private var viewControllers: [BDBaseViewController] = []
    
    private lazy var tabBar: BDTabBar = {
        let tab = BDTabBar()
        tab.delegate = self
        tab.backgroundColor = .white
        return tab
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabBar)
        view.addSubview(contentView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setViewControllers(vcs: [BDBaseViewController]) {
        
        viewControllers.forEach { (vc) in
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        
        assert(vcs.count > 5, "ViewController 多到爆")
        assert(vcs.count < 1, "ViewController 沒半個")
        
        viewControllers = vcs
        var items: [BDTabBarItem] = []
        vcs.forEach { (vc) in
            guard let item = vc.bdTabBarItem else {
                assertionFailure("Item 為定義")
                return
            }
            items.append(item)
        }
        
    }
    
}

extension BDTabBarController: BDTabBarDelegate {
    
}
