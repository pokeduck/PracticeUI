//
//  UIViewController+Rx.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit

    import RxCocoa
    import RxSwift

    public extension Reactive where Base: UIViewController {
        var viewDidLoad: ControlEvent<Void> {
            let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
            return ControlEvent(events: source)
        }

        var viewWillAppear: ControlEvent<Bool> {
            let source = methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
            return ControlEvent(events: source)
        }

        var viewDidAppear: ControlEvent<Bool> {
            let source = methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
            return ControlEvent(events: source)
        }

        var viewWillDisappear: ControlEvent<Bool> {
            let source = methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
            return ControlEvent(events: source)
        }

        var viewDidDisappear: ControlEvent<Bool> {
            let source = methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
            return ControlEvent(events: source)
        }

        var viewWillLayoutSubviews: ControlEvent<Void> {
            let source = methodInvoked(#selector(Base.viewWillLayoutSubviews)).map { _ in }
            return ControlEvent(events: source)
        }

        var viewDidLayoutSubviews: ControlEvent<Void> {
            let source = methodInvoked(#selector(Base.viewDidLayoutSubviews)).map { _ in }
            return ControlEvent(events: source)
        }

        var willMoveToParentViewController: ControlEvent<UIViewController?> {
            let source = methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController }
            return ControlEvent(events: source)
        }

        var didMoveToParentViewController: ControlEvent<UIViewController?> {
            let source = methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
            return ControlEvent(events: source)
        }

        var didReceiveMemoryWarning: ControlEvent<Void> {
            let source = methodInvoked(#selector(Base.didReceiveMemoryWarning)).map { _ in }
            return ControlEvent(events: source)
        }

        /// Rx observable, triggered when the ViewController appearance state changes (true if the View is being displayed, false otherwise)
        var isVisible: Observable<Bool> {
            let viewDidAppearObservable = base.rx.viewDidAppear.map { _ in true }
            let viewWillDisappearObservable = base.rx.viewWillDisappear.map { _ in false }
            return Observable<Bool>.merge(viewDidAppearObservable, viewWillDisappearObservable)
        }

        /// Rx observable, triggered when the ViewController is being dismissed
        var isDismissing: ControlEvent<Bool> {
            let source = sentMessage(#selector(Base.dismiss)).map { $0.first as? Bool ?? false }
            return ControlEvent(events: source)
        }
    }
#endif
