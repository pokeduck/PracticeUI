//
//  PublishSignal.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxSwift

final class PublishSignal<Element> {
    let publish = PublishRelay<Element>()
    var signal: Signal<Element> {
        publish.asSignal()
    }

    func accept(_ event: Element) {
        publish.accept(event)
    }

    func emit(onNext: @escaping ((Element) -> Void)) -> Disposable {
        signal.emit(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }

    func emit(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        signal.emit(onNext: onNext, onCompleted: onCompleted, onDisposed: onDisposed)
    }

    func emit(to relay: RxRelay.PublishRelay<Element>) -> Disposable {
        signal.emit(to: relay)
    }
}
