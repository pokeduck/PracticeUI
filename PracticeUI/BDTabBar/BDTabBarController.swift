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
    
    private(set) lazy var tabBar: BDTabBar = {
        let tab = BDTabBar()
        tab.delegate = self
        tab.backgroundColor = .green
        return tab
    }()
    
    private(set) lazy var tabBarShadow: UIView = {
        let v = UIView()
        v.cornerRadius = 20
        v.clipsToBounds = true
        v.addShadow(ofColor: .black, radius: 8, offset: .zero, opacity: 0.5)
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(contentView)
        view.addSubview(tabBarShadow)
        view.addSubview(tabBar)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSelectedIndex(index: selectedIndex)
        funcLog()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        funcLog()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dLog("Bounds:\(view.bounds)")
        let b = view.bounds
        // TabBar layout
        let tabH: CGFloat = UIDevice.current.hasNotch ? 120.0 : 90.0
        
        let tabBarFrame = CGRect(x: 0, y: b.maxY - tabH, width: b.width, height: tabH)
        tabBar.frame = tabBarFrame
        tabBarShadow.frame = tabBarFrame
            
        // Content Layout
        contentView.frame = CGRect(x: 0, y: 0, width: b.width, height: b.maxY - tabH )
        
        
        selectedViewController().view.frame = contentView.bounds
        //return CGSize(width: size.width, height: UIDevice.current.hasNotch ? 120.0 : 90.0)

    }
    
    func selectedViewController() -> UIViewController {
        return viewControllers[selectedIndex]
    }
    
    
    func setSelectedIndex(index: Int) {
        if index > viewControllers.count {
            return
        }
        setCurrentTabBarItem(index: index)

        setCurrentViewControler(index: index)
        
    }
    
    func setViewControllers(vcs: [BDBaseViewController]) {
        
        viewControllers.forEach { (vc) in
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        
        assert(vcs.count < 6, "ViewController 多到爆")
        assert(vcs.count > 0, "ViewController 沒半個")
        
        viewControllers = vcs
        var items: [BDTabBarItem] = []
        for (idx, vc) in vcs.enumerated() {
            guard let item = vc.bdTabBarItem else {
                assertionFailure("Item 為定義")
                continue
            }
            item.tag = idx
            items.append(item)
            vc.wk_setTabBarController(vc: self)
            item.contentView.updateDisplay()
        }
        
        tabBar.items = items
        
        
    }
    func indexForViewController(vc: UIViewController) -> Int {
        var searchedVC:UIViewController = vc
        while let parent = searchedVC.parent,
              parent != self {
            searchedVC = parent
        }
        for (idx, vc) in viewControllers.enumerated() {
            if vc == searchedVC {
                return idx
            }
        }
        return 0
    }
    
    private func setCurrentViewControler(index: Int) {
        let selectedVC = selectedViewController()
        selectedVC.willMove(toParent: nil)
        selectedVC.view.removeFromSuperview()
        selectedVC.removeFromParent()
        
        let newSelectedVC = viewControllers[index]
        selectedIndex = index
        addChild(newSelectedVC)
        newSelectedVC.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.addSubview(newSelectedVC.view)
        newSelectedVC.view.frame = contentView.bounds
        newSelectedVC.didMove(toParent: self)
        bringTabBarToFront()
        view.setNeedsDisplay()
        setNeedsStatusBarAppearanceUpdate()
    }
    private func setCurrentTabBarItem(index: Int) {
        let newSelectedVC = viewControllers[index]
        tabBar.items?.forEach({ (item) in
            if item.tag == newSelectedVC.bdTabBarItem?.tag {
                tabBar.selectedItem = newSelectedVC.bdTabBarItem
            } else {
                item.contentView.deselect()
            }
        })
    }
    private func bringTabBarToFront() {
        view.bringSubviewToFront(tabBarShadow)
        view.bringSubviewToFront(tabBar)
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension BDTabBarController : BDTabBarDelegate {
    func tabBar(_ tabBar: BDTabBar, shouldSelected item: BDTabBarItem) -> Bool {
        return true
    }
    func tabBar(_ tabBar: BDTabBar, willSelected item: BDTabBarItem) {}
    func tabBar(_ tabBar: BDTabBar, didSelected item: BDTabBarItem) {
        setCurrentViewControler(index: item.tag)
    }
    
    
}
