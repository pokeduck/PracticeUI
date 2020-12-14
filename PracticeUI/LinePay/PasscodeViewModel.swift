//
//  PasscodeViewModel.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/11.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift

enum PasscodeStyle {
    case auth(correctCode: [String])

    case setup

    case change(oldCode: [String])
}

protocol PasscodeViewModelInput {
    var addNumber: PublishRelay<String> { get }
    var deleteNumber: PublishRelay<Void> { get }
    var useBiometry: PublishRelay<Void> { get }
}

protocol PasscodeViewModelOutput {
    var didFailed: PublishSignal<Void> { get }
    var didSucceed: PublishSignal<Void> { get }
    var didChangedState: PublishSignal<PasscodeViewModel.ChangeState> { get }
    var removeSign: PublishSignal<PasscodeIndex> { get }
    var cleanSigns: PublishSignal<Void> { get }
    var addSign: PublishSignal<PasscodeIndex> { get }

    var title: BehaviorDriver<String> { get }
    var detail: BehaviorDriver<String> { get }

    var isHUDShow: BehaviorDriver<Bool> { get }

    var isBiometryHidden: BehaviorRelay<Bool> { get }
    var biometryLocalizeText: BehaviorRelay<String> { get }
}

typealias PasscodeViewModelType = PasscodeViewModelInput & PasscodeViewModelOutput
typealias PasscodeIndex = Int

final class PasscodeViewModel: PasscodeViewModelType {
    // Input
    let addNumber = PublishRelay<String>()

    let deleteNumber = PublishRelay<Void>()

    let useBiometry = PublishRelay<Void>()

    // Output
    let didSucceed = PublishSignal<Void>()

    let didChangedState = PublishSignal<PasscodeViewModel.ChangeState>()

    let removeSign = PublishSignal<PasscodeIndex>()

    let cleanSigns = PublishSignal<Void>()

    let addSign = PublishSignal<PasscodeIndex>()

    let didFailed = PublishSignal<Void>()

    let title = BehaviorDriver<String>(value: "")
    let detail = BehaviorDriver<String>(value: "")
    let isHUDShow = BehaviorDriver<Bool>(value: false)

    let biometryLocalizeText = BehaviorRelay<String>(value: "")
    let isBiometryHidden = BehaviorRelay<Bool>(value: true)

    private var errorCount = 0

    private let mockStorage = PasscodeStorageMock()
    private let exectionQueue = ConcurrentDispatchQueueScheduler(qos: .default)
    private let disposeBag = DisposeBag()
    private let biometry = Biometry()
    let type: PasscodeStyle
    var originCodes: [String]?
    enum ChangeState {
        case verify
        case success
        case notMatch
    }

    private let maxLength = 6
    private var currentSigns: [String] = []

    init(type: PasscodeStyle) {
        self.type = type
        bind()
        switch type {
        case .auth:
            title.accept("請輸入密碼")
        case .setup:
            break
        case .change:
            break
        }
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

                switch self.type {
                case let .auth(correctCode):
                    self.addAuthenticationCodes(value, correctCodes: correctCode)
                case .setup:
                    self.didChangedState.accept(.verify)
                case let .change(oldCode):
                    print(oldCode)
                }
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

    private func addAuthenticationCodes(_ sign: String, correctCodes: [String]) {
        currentSigns.append(sign)
        addSign.accept(currentSigns.count - 1)

        if currentSigns.count >= correctCodes.count {
            isHUDShow.accept(true)
            mockStorage.authCodes.accept(currentSigns)
//            return
//            sleep(1)
//            if currentSigns == correctCodes {
//                currentSigns.removeAll()
//                //cleanSigns.accept(())
//                detail.accept("驗證成功")
//                sleep(1)
//                didSucceed.accept(())
//
//            } else {
//
//                currentSigns.removeAll()
//                detail.accept("密碼錯誤")
//                didFailed.accept(())
//                cleanSigns.accept(())
//
//            }
//            isHUDShow.accept(false)

        } else {
            if errorCount > 0 {
                detail.accept("請輸入目前密碼。")
            }
        }
    }
}
