//
// BDTabBarItem.swift
//
// Created by Ben for PracticeUI on 2021/3/25.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDTabBarItem: UITabBarItem {

    open override var tag: Int
    {
        didSet { self.contentView.tag = tag }
    }
    
    
    open override var title: String?
    {
        didSet { self.contentView.title = title }
    }
    
    
    open override var image: UIImage?
    {
        didSet { self.contentView.image = image }
    }
    
    
    open override var selectedImage: UIImage?
    {
        get { return contentView.selectedImage }
        set(newValue) { contentView.selectedImage = newValue }
    }
    
    
    var selectedStringAttribute: [NSAttributedString.Key : Any]?
    
    var unselectedStringAttribute: [NSAttributedString.Key : Any]?
    
    var contentView: BDTabBarItemContentView = BDTabBarItemContentView()
    {
        didSet {
            self.contentView.updateLayout()
            self.contentView.updateDisplay()
        }
    }
    
    //MARK: Init
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
