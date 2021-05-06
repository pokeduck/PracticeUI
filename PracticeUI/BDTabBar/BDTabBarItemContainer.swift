//
// ESTabBarItemContainer.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDTabBarItemContainer: UIControl {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ target: AnyObject?, tag: Int) {
        super.init(frame: .zero)

        addTarget(target, action: #selector(BDTabBar.selectAction(_:)), for: .touchUpInside)
        addTarget(target, action: #selector(BDTabBar.highlightAction(_:)), for: .touchDown)
        addTarget(target, action: #selector(BDTabBar.highlightAction(_:)), for: .touchDragEnter)
        addTarget(target, action: #selector(BDTabBar.dehighlightAction(_:)), for: .touchDragExit)

        self.tag = tag
        backgroundColor = .blue
    }

    override func layoutSubviews() {
        funcLog()
        super.layoutSubviews()
        for subview in subviews {
            if let subview = subview as? BDTabBarItemContentView {
                let f = CGRect(x: subview.insets.left, y: subview.insets.top, width: bounds.size.width - subview.insets.left - subview.insets.right, height: bounds.size.height - subview.insets.top - subview.insets.bottom)

                subview.frame = f
                subview.updateLayout()
            }
        }
    }

//    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        var b = super.point(inside: point, with: event)
//        if !b {
//            for subview in self.subviews {
//                if subview.point(inside: CGPoint.init(x: point.x - subview.frame.origin.x, y: point.y - subview.frame.origin.y), with: event) {
//                    b = true
//                }
//            }
//        }
//        return b
//    }
}
