//
// BDTabBarItem.swift
//
// Created by Ben for PracticeUI on 2021/3/25.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDTabBarItem: UITabBarItem {
    override open var tag: Int {
        didSet { self.contentView.tag = tag }
    }

    override open var title: String? {
        didSet { self.contentView.title = title }
    }

    override open var image: UIImage? {
        didSet { self.contentView.image = image }
    }

    override open var selectedImage: UIImage? {
        get { contentView.selectedImage }
        set(newValue) { contentView.selectedImage = newValue }
    }

    var selectedStringAttribute: [NSAttributedString.Key: Any]?

    var unselectedStringAttribute: [NSAttributedString.Key: Any]?

    var contentView = BDTabBarItemContentView() {
        didSet {
            self.contentView.updateLayout()
            self.contentView.updateDisplay()
        }
    }

    // MARK: Init

    override init() {
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
