//
// ContentDetailPushTtransition.swift
//
// Created by Ben for PracticeUI on 2021/5/7.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

protocol ContentDetailPushTtransitionAnimatorDelegate : AnyObject {
    func transitionWillStart()
    
    func transitionDidEnd()
    
    func referenceColor() -> UIColor?
    
    func cellFrame() -> CGRect?
}

class ContentDetailPushTtransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    fileprivate let fromDelegate: ContentDetailPushTtransitionAnimatorDelegate
    
    fileprivate let contentVC: CustomTransitionContentDetailVC
    
    fileprivate let transitionColorView: UIView = {
        let v = UIView()
        return v
    }()
    
    init?(delegate: Any, toVC: CustomTransitionContentDetailVC) {
        guard let d = delegate as? ContentDetailPushTtransitionAnimatorDelegate else { return nil }
        self.fromDelegate = d
        self.contentVC = toVC
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        let containerView = transitionContext.containerView
        toView?.alpha = 0
        
        [fromView, toView]
            .compactMap { $0 }
            .forEach { containerView.addSubview($0) }
        
        let transitionColor = fromDelegate.referenceColor()  ?? .white
        
        transitionColorView.backgroundColor = transitionColor
        containerView.addSubview(transitionColorView)
        
        // ToDo: defaultOffscreenFrameForPresentation
        transitionColorView.frame = fromDelegate.cellFrame() ?? .zero
        
        
    }
}
