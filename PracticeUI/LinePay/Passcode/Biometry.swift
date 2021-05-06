//
//  Biometry.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import LocalAuthentication
import RxCocoa
import RxSwift

class Biometry {
    private let context = LAContext()
    var isAvaiable: Bool {
        let error = NSErrorPointer(nilLiteral: ())
        let reuslt = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: error)
        return reuslt
    }

    var biometryName: String {
        switch context.biometryType {
        case .faceID:
            return "Face ID"
        case .touchID:
            return "Touch ID"
        default:
            return ""
        }
    }

    func enable() {
        UserDefaults.standard[.biometryEnable] = true
    }

    func disable() {
        UserDefaults.standard[.biometryEnable] = false
    }

    func isEnable() -> Bool {
        if !isAvaiable { return false }
        let isEnable = UserDefaults.standard.bool(forKey: .biometryEnable)
        return isEnable
    }

    func auth() -> Signal<Result<Bool, Error>> {
        let obserable: Observable<Result<Bool, Error>>
            = Observable.create { [weak self] observer -> Disposable in
                guard let self = self else {
                    observer.onCompleted()
                    return Disposables.create()
                }

                if !self.isAvaiable {
                    observer.onCompleted()
                }
                self.context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "使用 \(self.biometryName)") { result, error in

                    if error != nil {
                        observer.onNext(.failure(error!))
                    } else {
                        observer.onNext(.success(result))
                    }
                }
                return Disposables.create()
            }
        return obserable.asSignal(onErrorJustReturn: .success(false))
    }

    func auth(resultHandler: @escaping (_ result: Result<Bool, Error>) -> Void) {
        if !isAvaiable { return }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "使用 \(biometryName)") { result, error in
            DispatchQueue.main.async {
                if error != nil {
                    resultHandler(.failure(error!))
                } else {
                    resultHandler(.success(result))
                }
            }
        }
    }
}
