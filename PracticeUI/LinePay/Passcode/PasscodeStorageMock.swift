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
private let mockDelayTime = DispatchTimeInterval.seconds(2)
class PasscodeStorageMock {
    private let disposeBag = DisposeBag()
    // input
    let authCodes = PublishRelay<[String]>()
    let newCodes = PublishRelay<[String]>()
    // output
    let authError = PublishRelay<Void>()
    let authSucceed = PublishRelay<Void>()
    let exectionQueue = ConcurrentDispatchQueueScheduler(qos: .default)

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

        newCodes.delay(mockDelayTime, scheduler: exectionQueue).subscribe { [weak self] event in
            guard let codes = event.element,
                  let self = self else { return }
            self.saveNewCode(codes)
            self.authSucceed.accept(())

        }.disposed(by: disposeBag)
    }
}

extension UserDefaults.Key {
    static let passcode: UserDefaults.Key = "line.passcode.key"
}
