//
// BDTabContainerView.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDTabBarItemContentView: UIView {
    // MARK: Data & State

    var title: String? {
        didSet {
            titleLabel.text = title
            updateLayout()
        }
    }

    var image: UIImage? {
        didSet {
            if !selected { updateDisplay() }
        }
    }

    var selectedImage: UIImage?

    private(set) var selected = false

    // private(set) var highlighted = false

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

    open var textColor = UIColor(white: 0.57254902, alpha: 1.0) {
        didSet {
            if !selected { titleLabel.textColor = textColor }
        }
    }

    open var highlightTextColor = UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0) {
        didSet {
            if selected { titleLabel.textColor = highlightIconColor }
        }
    }

    open var iconColor = UIColor(white: 0.57254902, alpha: 1.0) {
        didSet {
            if !selected { imageView.tintColor = iconColor }
        }
    }

    open var highlightIconColor = UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0) {
        didSet {
            if selected { imageView.tintColor = highlightIconColor }
        }
    }

    open var insets = UIEdgeInsets.zero {
        didSet {
            self.updateLayout()
        }
    }

    // MARK: Elements

    open var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = .clear
        return imageView
    }()

    open var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .clear
        titleLabel.textAlignment = .center

        return titleLabel
    }()

    // MARK: Init

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false

        addSubview(imageView)
        addSubview(titleLabel)

        titleLabel.textColor = textColor
        imageView.tintColor = iconColor
        backgroundColor = backdropColor
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    func updateLayout() {
        let w = bounds.size.width
        let h = bounds.size.height

        var s: CGFloat = 0.0 // image size
        var f: CGFloat = 0.0 // font
        var isLandscape = false
        if let keyWindow = UIApplication.shared.keyWindow {
            isLandscape = keyWindow.bounds.width > keyWindow.bounds.height
        }
        let isWide = isLandscape || traitCollection.horizontalSizeClass == .regular // is landscape or regular
        if #available(iOS 11.0, *), isWide {
            s = UIScreen.main.scale == 3.0 ? 23.0 : 20.0
            f = UIScreen.main.scale == 3.0 ? 13.0 : 12.0
        } else {
            s = 23.0
            f = 10.0
        }

        titleLabel.font = UIFont.systemFont(ofSize: f)
        titleLabel.sizeToFit()

        if #available(iOS 11.0, *), isWide {
            titleLabel.frame = CGRect(x: (w - titleLabel.bounds.size.width) / 2.0 + (UIScreen.main.scale == 3.0 ? 14.25 : 12.25),
                                      y: (h - titleLabel.bounds.size.height) / 2.0,
                                      width: titleLabel.bounds.size.width,
                                      height: titleLabel.bounds.size.height)
            imageView.frame = CGRect(x: titleLabel.frame.origin.x - s - (UIScreen.main.scale == 3.0 ? 6.0 : 5.0),
                                     y: (h - s) / 2.0,
                                     width: s,
                                     height: s)
        } else {
            titleLabel.frame = CGRect(x: (w - titleLabel.bounds.size.width) / 2.0,
                                      y: h - titleLabel.bounds.size.height - 1.0,
                                      width: titleLabel.bounds.size.width,
                                      height: titleLabel.bounds.size.height)
            imageView.frame = CGRect(x: (w - s) / 2.0,
                                     y: (h - s) / 2.0 - 6.0,
                                     width: s,
                                     height: s)
        }
        funcLog()
    }

    func updateDisplay() {
        imageView.image = (selected ? (selectedImage ?? image) : image)
        imageView.tintColor = selected ? highlightIconColor : iconColor
        titleLabel.textColor = selected ? highlightTextColor : textColor
        backgroundColor = selected ? highlightBackdropColor : backdropColor
    }

    // MARK: Change State

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
        } else {}
    }
}
