//
//  LineColors.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/7.
//  Copyright © 2020 pokeduck. All rights reserved.
//

// import ChameleonFramework
import SwifterSwift
import UIKit

protocol ColorConvertible {
    var colorCode: String { get }
    func color() -> UIColor?
}

extension ColorConvertible {
    func color() -> UIColor? {
        UIColor(hexString: colorCode)
    }
}

enum Colors {}

extension Colors {
    enum Line {
        /*
         static var main: UIColor { UIColor(hexString: "00C05B")!}
         static var appLockUserID: UIColor { UIColor(hexString: "84e0b1")!}
         static var appLockBtnNormalText: UIColor { UIColor(hexString: "fefefe")!}
         static var appLockBtnPressedText: UIColor { UIColor(hexString: "4fc987")!}
         static var appLockBtnBgPressed: UIColor { UIColor(hexString: "08b757")!}
         static var appLockBtnBgNormal: UIColor { main }
          */
        static var main: UIColor { UIColor(hexString: "00C05B")! }
        static var appLockUserID: UIColor { UIColor(hexString: "84e0b1")! }
        static var appLockBtnNormalText: UIColor { UIColor(hexString: "fefefe")! }
        static var appLockBtnPressedText: UIColor { UIColor(hexString: "4fc987")! }
        static var appLockBtnBgNormal: UIColor { UIColor.FlatUI.emerald }
        static var appLockBtnBgPressed: UIColor { UIColor.FlatUI.nephritis }
    }
}
