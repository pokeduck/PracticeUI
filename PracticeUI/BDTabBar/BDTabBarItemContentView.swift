//
// BDTabContainerView.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDTabBarItemContentView: UIView {

    var title: String?
    
    var image: UIImage?
    
    var selectedImage: UIImage?

    private(set) var selected = false
    
    //private(set) var highlighted = false

    
    open var backdropColor = UIColor.yellow {
        didSet {
            if !selected { backgroundColor = backdropColor }
        }
    }
    
    open var highlightBackdropColor = UIColor.purple {
        didSet {
            if selected { backgroundColor = highlightBackdropColor }
        }
    }
    
    open var insets = UIEdgeInsets.zero
    {
        didSet {
            self.updateLayout()
        }
    }
    
    func updateLayout() {
        
        
    }
    
    func updateDisplay() {
//        imageView.image = (selected ? (selectedImage ?? image) : image)?.withRenderingMode(renderingMode)
//        imageView.tintColor = selected ? highlightIconColor : iconColor
//        titleLabel.textColor = selected ? highlightTextColor : textColor
        backgroundColor = selected ? highlightBackdropColor : backdropColor
    }
    
    func seletct() {

        if selected {
            
        } else {
            selected = true
            updateDisplay()
        }
    }
    func deselect() {
        if selected {
            selected = false
            updateDisplay()
        } else {
            
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return superview
    }
}
