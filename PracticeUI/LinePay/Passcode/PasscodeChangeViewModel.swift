//
//  PasscodeChangeViewModel.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/15.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxSwift

class PasscodeChangeViewModel: PasscodeViewModelType {
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

    let title = BehaviorDriver<String>(value: "LINE Pay")
    let detail = BehaviorDriver<String>(value: "請輸入目前的密碼。")
    let isHUDShow = BehaviorDriver<Bool>(value: false)
    var isCancelHidden = BehaviorRelay<Bool>(value: false)

    let biometryLocalizeText = BehaviorRelay<String>(value: "")
    let isBiometryHidden = BehaviorRelay<Bool>(value: true)

    enum Step {
        case inputOrigin
        case new
        case newAgain
    }

    private var step = Step.inputOrigin
    private let maxLength = 6
    private var currentSigns: [String] = []
    private var newSigns: [String] = []

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
            .delay(.milliseconds(100), scheduler: ConcurrentDispatchQueueScheduler(qos: .default))
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
            .delay(.milliseconds(300), scheduler: exectionQueue)
            .subscribe { [weak self] _ in

                guard let self = self else { return }
                self.step = .new
                self.detail.accept("請輸入新密碼")
                self.currentSigns.removeAll()
                self.cleanSigns.accept(())

            }.disposed(by: disposeBag)

        mockStorage.authError
            .delay(.milliseconds(300), scheduler: exectionQueue)
            .subscribe { [weak self] _ in

                guard let self = self else { return }
                self.step = .inputOrigin
                self.detail.accept("密碼錯誤。")
                self.currentSigns.removeAll()
                self.cleanSigns.accept(())
                self.didFailed.accept(())
            }.disposed(by: disposeBag)

        mockStorage.saveSucceed
            .delay(.milliseconds(300), scheduler: exectionQueue)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.detail.accept("變更完成。")
                self.cleanSigns.accept(())
                if self.biometry.isEnable() {
                    self.biometry.auth()
                        .emit(onNext: { [weak self] result in
                            guard let self = self else { return }
                            switch result {
                            case let .success(result):
                                if result {
                                    self.biometry.enable()
                                } else {
                                    self.biometry.disable()
                                }
                            case .failure:
                                self.biometry.disable()
                            }
                            self.didSucceed.accept(())
                        }).disposed(by: self.disposeBag)
                } else {
                    self.didSucceed.accept(())
                }
            }.disposed(by: disposeBag)
    }

    private func addAuthenticationCodes(_ sign: String) {
        if currentSigns.count >= maxLength { return }
        currentSigns.append(sign)
        addSign.accept(currentSigns.count - 1)

        if currentSigns.count >= maxLength {
            switch step {
            case .inputOrigin:
                mockStorage.authCodes.accept(currentSigns)
            case .new:
                newSigns = currentSigns
                currentSigns.removeAll()
                cleanSigns.accept(())
                step = .newAgain
            case .newAgain:
                if currentSigns == newSigns {
                    mockStorage.saveCodes.accept(newSigns)
                } else {
                    currentSigns.removeAll()
                    newSigns.removeAll()
                    cleanSigns.accept(())
                    step = .new
                    detail.accept("新密碼輸入不同，請重新設定。")
                }
            }
        } else {
            switch step {
            case .inputOrigin:
                detail.accept("請輸入目前的密碼。")
            case .new:
                detail.accept("請輸入新密碼。")
            case .newAgain:
                detail.accept("請再輸入新密碼。")
            }
        }
    }
}
