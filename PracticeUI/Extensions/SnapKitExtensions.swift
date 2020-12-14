//
//  SnapKitExtensions.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/5.
//

import SnapKit
import UIKit

extension UIView {
    var safeArea: ConstraintLayoutGuideDSL {
        safeAreaLayoutGuide.snp
    }
}
