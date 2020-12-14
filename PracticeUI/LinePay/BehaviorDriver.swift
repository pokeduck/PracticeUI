//
//  BehaviorDriver.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public class BehaviorDriver<Element>: NSObject {
    var behavior: BehaviorRelay<Element>!
    var driver: Driver<Element> {
        behavior.asDriver()
    }

    public init(value: Element) {
        behavior = BehaviorRelay<Element>(value: value)
    }

    public func value() -> Element {
        behavior.value
    }

    public func accept(_ event: Element) {
        behavior.accept(event)
    }

    public func drive(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        driver.drive(onNext: onNext, onCompleted: onCompleted, onDisposed: onDisposed)
    }

    public func drive<Observer>(_ observer: Observer) -> Disposable where Observer: ObserverType, Element == Observer.Element {
        driver.drive(observer)
    }
}
