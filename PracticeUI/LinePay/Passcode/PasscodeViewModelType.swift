//
//  PasscodeViewModelType.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/11.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift

protocol PasscodeViewModelInput: AnyObject {
    var addNumber: PublishRelay<String> { get }
    var deleteNumber: PublishRelay<Void> { get }
    var useBiometry: PublishRelay<Void> { get }
}

protocol PasscodeViewModelOutput: AnyObject {
    var didFailed: PublishSignal<Void> { get }
    var didSucceed: PublishSignal<Void> { get }

    var removeSign: PublishSignal<PasscodeIndex> { get }
    var cleanSigns: PublishSignal<Void> { get }
    var addSign: PublishSignal<PasscodeIndex> { get }

    var title: BehaviorDriver<String> { get }
    var detail: BehaviorDriver<String> { get }

    var isHUDShow: BehaviorDriver<Bool> { get }

    var isBiometryHidden: BehaviorRelay<Bool> { get }
    var biometryLocalizeText: BehaviorRelay<String> { get }
    var isCancelHidden: BehaviorRelay<Bool> { get }
}

typealias PasscodeViewModelType = PasscodeViewModelInput & PasscodeViewModelOutput
typealias PasscodeIndex = Int
