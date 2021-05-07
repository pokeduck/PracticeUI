//
// CustomNaviController.swift
//
// Created by Ben for PracticeUI on 2021/5/7.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class CustomNaviController: UINavigationController {
    fileprivate var currentAnimationTransition: UIViewControllerAnimatedTransitioning?
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([PhotosVC()], animated: false)
        view.backgroundColor = .white
        delegate = self
    }
}

extension CustomNaviController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var result: UIViewControllerAnimatedTransitioning?
        if let detail = toVC as? CustomTransitionContentDetailVC,
           operation == .push
        {
            result = ContentDetailPushTtransition(delegate: fromVC, toVC: detail)
        } else {
            result = nil
        }

        currentAnimationTransition = result
        return result
    }
}
