//
// BDTabBar.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

protocol BDTabBarDelegate: class {
    
}

class BDTabBar: UIView {

    weak var delegate: BDTabBarDelegate?
    
    private(set) var containers: [BDTabBarItemContainer] = []
    
    var items: [BDTabBarItem]? {
        didSet {
            self.reload()
        }
    }
    
    func removeAll() {
        for container in containers {
            container.removeFromSuperview()
        }
        containers.removeAll()
    }
    
    func reload() {
        removeAll()
        guard let tabBarItems = self.items else {
            assertionFailure("Empty Items")
            return
        }
        for (_, item) in tabBarItems.enumerated() {
            let container = BDTabBarItemContainer()
            addSubview(container)
            containers.append(container)
            container.addSubview(item.contentView)
        }
        
        //self.updateAccessibilityLabels()
        self.setNeedsLayout()
    }
    
    
    
    override func draw(_ rect: CGRect) {
  
        
        
    }


}
