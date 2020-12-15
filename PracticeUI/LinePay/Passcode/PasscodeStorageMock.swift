//
//  PasscodeStorageMock.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
private let mockDelayTime = DispatchTimeInterval.milliseconds(300)
class PasscodeStorageMock {
    static func hasBeenSetup() -> Bool {
        UserDefaults.standard.stringArray(forKey: .passcode) != nil
    }

    private let disposeBag = DisposeBag()
    // input
    let authCodes = PublishRelay<[String]>()
    let saveCodes = PublishRelay<[String]>()
    // output
    let saveSucceed = PublishRelay<Void>()
    let authError = PublishRelay<Void>()
    let authSucceed = PublishRelay<Void>()
    private let exectionQueue = ConcurrentDispatchQueueScheduler(qos: .default)

    private var userDefault: UserDefaults { UserDefaults.standard }

    init() {
        bind()
    }

    deinit {
        print("storage release")
    }

    private func codes() -> [String] {
        if let codeData = userDefault.stringArray(forKey: .passcode) {
            print("Last codes: \(codeData)")
            return codeData
        } else {
            let newCodes = ["1", "2", "3", "4", "5", "6"]
            userDefault[.passcode] = newCodes
            return newCodes
        }
    }

    private func saveNewCode(_ codes: [String]) {
        userDefault[.passcode] = codes
    }

    private func bind() {
        authCodes.delay(mockDelayTime, scheduler: exectionQueue).subscribe(onNext: { [weak self] codes in
            guard let self = self else { return }
            if self.codes() == codes {
                self.authSucceed.accept(())
            } else {
                self.authError.accept(())
            }

        }).disposed(by: disposeBag)

        saveCodes.delay(mockDelayTime, scheduler: exectionQueue).subscribe { [weak self] event in
            guard let codes = event.element,
                  let self = self else { return }
            self.saveNewCode(codes)
            self.saveSucceed.accept(())

        }.disposed(by: disposeBag)
    }
}

extension UserDefaults.Key {
    static let passcode: UserDefaults.Key = "line.passcode.key"
    static let biometryEnable: UserDefaults.Key = "line.passcode.biometry.enable.key"
}
