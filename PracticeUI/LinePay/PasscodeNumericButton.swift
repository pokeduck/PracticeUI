//
//  PasscodeNumericButton.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/8.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import UIKit

class PasscodeNumericButton: UIButton {
    var backgroundColorForHighlighted: UIColor?
    var backgroundColorForNormal: UIColor?

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = backgroundColorForHighlighted
            } else {
                backgroundColor = backgroundColorForNormal
            }
        }
    }
}
