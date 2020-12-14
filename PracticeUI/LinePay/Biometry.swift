//
//  Biometry.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import LocalAuthentication
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
