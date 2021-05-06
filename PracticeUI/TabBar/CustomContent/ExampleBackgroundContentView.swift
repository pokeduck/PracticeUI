//
//  ExampleBackgroundContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import ESTabBarController_swift

class ExampleBackgroundContentView: ExampleBasicContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = UIColor(white: 165.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor(white: 165.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = UIColor(red: 37 / 255.0, green: 39 / 255.0, blue: 42 / 255.0, alpha: 1.0)
        highlightBackdropColor = UIColor(red: 22 / 255.0, green: 24 / 255.0, blue: 25 / 255.0, alpha: 1.0)
    }

    public convenience init(specialWithAutoImplies implies: Bool) {
        self.init(frame: CGRect.zero)
        textColor = .white
        highlightTextColor = .white
        iconColor = .white
        highlightIconColor = .white
        backdropColor = UIColor(red: 17 / 255.0, green: 86 / 255.0, blue: 136 / 255.0, alpha: 1.0)
        highlightBackdropColor = UIColor(red: 22 / 255.0, green: 24 / 255.0, blue: 25 / 255.0, alpha: 1.0)
        if implies {
            let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ExampleBackgroundContentView.playImpliesAnimation(_:)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        }
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc internal func playImpliesAnimation(_ sender: AnyObject?) {
        if selected == true || highlighted == true {
            return
        }
        let view = imageView
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.15, 0.8, 1.15]
        impliesAnimation.duration = 0.3
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        impliesAnimation.isRemovedOnCompletion = true
        view.layer.add(impliesAnimation, forKey: nil)
    }
}
