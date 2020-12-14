//
//  PasscodeSetupViewModel.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/15.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxSwift

class PasscodeSetupViewModel: PasscodeViewModelType {
    
    // Input
    let addNumber = PublishRelay<String>()

    let deleteNumber = PublishRelay<Void>()

    let useBiometry = PublishRelay<Void>()

    // Output
    let didSucceed = PublishSignal<Void>()

    let removeSign = PublishSignal<PasscodeIndex>()

    let cleanSigns = PublishSignal<Void>()

    let addSign = PublishSignal<PasscodeIndex>()

    let didFailed = PublishSignal<Void>()

    let title = BehaviorDriver<String>(value: "請輸入新密碼")
    let detail = BehaviorDriver<String>(value: "")
    let isHUDShow = BehaviorDriver<Bool>(value: false)
    var isCancelHidden = BehaviorRelay<Bool>(value: false)

    let biometryLocalizeText = BehaviorRelay<String>(value: "")
    let isBiometryHidden = BehaviorRelay<Bool>(value: true)

    enum Step {
        case step1
        case step2
    }
    private var step = Step.step1
    private let maxLength = 6
    private var currentSigns: [String] = []
    private var newSigns: [String] = []
    
    private var errorCount = 0

    private let mockStorage = PasscodeStorageMock()
    private let exectionQueue = ConcurrentDispatchQueueScheduler(qos: .default)
    private let disposeBag = DisposeBag()
    private let biometry = Biometry()

    init() {
        bind()
    }

    deinit {
        print("viewmodel release")
    }

    func bind() {
        addNumber
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe { [weak self] event in
                guard let self = self else { return }
                guard let value = event.element else { return }
                self.addAuthenticationCodes(value)

            }.disposed(by: disposeBag)

        deleteNumber.subscribe { [weak self] _ in
            guard let self = self else { return }
            let lastIndex = self.currentSigns.count - 1
            if lastIndex < 0 { return }
            self.currentSigns.removeLast()
            self.removeSign.accept(lastIndex)
        }.disposed(by: disposeBag)

        mockStorage.authSucceed
            .delay(.seconds(1), scheduler: exectionQueue)
            .bind(to: didSucceed.publish)
            .disposed(by: disposeBag)
        
        mockStorage.authSucceed
            .subscribe { [weak self] _ in
            guard let self = self else { return }
                self.title.accept("設定完成")
                self.isHUDShow.accept(false)
        }.disposed(by: disposeBag)
        
    }

    private func addAuthenticationCodes(_ sign: String) {
        if currentSigns.count >= maxLength { return }
        currentSigns.append(sign)
        addSign.accept(currentSigns.count - 1)

        if currentSigns.count >= maxLength {
            switch step {
            case .step1:
                sleep(1)
                newSigns = currentSigns
                cleanSigns.accept(())
                title.accept("再輸入一次新密碼")
                currentSigns.removeAll()
                step = .step2
            case .step2:
                isHUDShow.accept(true)
                if newSigns == currentSigns {
                    mockStorage.newCodes.accept(newSigns)
                } else {
                    title.accept("第二次輸入錯誤")
                    newSigns.removeAll()
                    currentSigns.removeAll()
                    step = .step1
                    cleanSigns.accept(())
                    isHUDShow.accept(false)
                }
            }
        } else {
            if step == .step1 {
                title.accept("請輸入新密碼")
            }
        }
    }
}

