//
//  PasscodeAuthViewModel.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/15.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxSwift

class PasscodeAuthViewModel: PasscodeViewModelType {
    
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

    let title = BehaviorDriver<String>(value: "請輸入密碼")
    let detail = BehaviorDriver<String>(value: "")
    let isHUDShow = BehaviorDriver<Bool>(value: false)
    var isCancelHidden = BehaviorRelay<Bool>(value: true)

    let biometryLocalizeText = BehaviorRelay<String>(value: "")
    let isBiometryHidden = BehaviorRelay<Bool>(value: true)

    
    private let maxLength = 6
    private var currentSigns: [String] = []
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
            .map { true }
            .bind(to: isHUDShow.behavior)
            .disposed(by: disposeBag)
        mockStorage.authSucceed
            .map { "驗證成功" }
            .bind(to: detail.behavior)
            .disposed(by: disposeBag)

        mockStorage.authError.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.didFailed.accept(())
            self.isHUDShow.accept(false)
            self.cleanSigns.accept(())
            self.currentSigns.removeAll()
            self.detail.accept("無效的密碼。\n輸入錯誤若超過 4 次，您將無法使用服務。")
            self.errorCount += 1
        }.disposed(by: disposeBag)

        useBiometry.subscribe { [weak self] _ in
            self?.biometry.auth(resultHandler: { [weak self] result in
                switch result {
                case let .success(isCorrect):
                    if isCorrect {
                        self?.didSucceed.accept(())
                    } else {
                        self?.didFailed.accept(())
                    }
                case .failure:
                    self?.didFailed.accept(())
                }
            })
        }.disposed(by: disposeBag)

        isBiometryHidden.accept(!biometry.isAvaiable)
        biometryLocalizeText.accept(biometry.biometryName)
    }

    private func addAuthenticationCodes(_ sign: String) {
        currentSigns.append(sign)
        addSign.accept(currentSigns.count - 1)

        if currentSigns.count >= maxLength {
            isHUDShow.accept(true)
            mockStorage.authCodes.accept(currentSigns)
        } else {
            if errorCount > 0 {
                detail.accept("請輸入目前密碼。")
            }
        }
    }
}
