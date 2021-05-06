//
//  PasscodeNumericPadView.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/8.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
protocol PasscodeNumericPadDelegate: AnyObject {
    func passcodeNumericPad(_ view: PasscodeNumericPadView, didPressed code: PasscodeNumericPadView.CodeType)
}

class PasscodeNumericPadView: UIView {
    @IBOutlet var buttons: [PasscodeNumericButton] = []

    weak var cancelButton: PasscodeNumericButton?

    private let _tapNumber = PublishRelay<String>()
    private let _tapDelete = PublishRelay<Void>()
    private let _tapCancel = PublishRelay<Void>()

    var tapNumber: Signal<String> {
        _tapNumber.asSignal()
    }

    var tapDelete: Signal<Void> {
        _tapDelete.asSignal()
    }

    var tapCancel: Signal<Void> {
        _tapCancel.asSignal()
    }

    enum CodeType {
        case numeric(String)
        case cancel
        case delete
    }

    struct ColorSets {
        let backgroundColor = UIColor.clear
        let buttonTextNormalColor = UIColor.white
        let buttonTextHighlightedColor = UIColor.FlatUI.asbestos
        let buttonBgNormalColor = UIColor.FlatUI.emerald
        let buttonBgHighlightedColor = UIColor.FlatUI.nephritis
    }

    struct Config {
        static let lineTheme = Config(backgroundColor: .clear, buttonTextNormalColor: .white, buttonTextHighlightedColor: UIColor.FlatUI.asbestos, buttonBgNormalColor: UIColor.FlatUI.emerald, buttonBgHighlightedColor: UIColor.FlatUI.nephritis)
        // var isShowCancel: Bool = false
        let backgroundColor: UIColor // = UIColor.clear
        let buttonTextNormalColor: UIColor // = UIColor.white
        let buttonTextHighlightedColor: UIColor // = UIColor.FlatUI.asbestos
        let buttonBgNormalColor: UIColor // = UIColor.FlatUI.emerald
        let buttonBgHighlightedColor: UIColor // = UIColor.FlatUI.nephritis
    }

    // private var config: Config = Config()
    override fileprivate init(frame: CGRect) {
        super.init(frame: frame)
    }

    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func instance(with config: Config) -> PasscodeNumericPadView {
        let view = PasscodeNumericPadView.instantiateFromNib()
        view.backgroundColor = config.backgroundColor
        view.buttons.forEach { btn in
            btn.addTarget(view, action: #selector(view.pressedBtn(_:)), for: .touchUpInside)
            btn.titleColorForNormal = config.buttonTextNormalColor
            btn.titleColorForHighlighted = config.buttonTextHighlightedColor
            btn.backgroundColorForHighlighted = config.buttonBgHighlightedColor
            btn.backgroundColorForNormal = config.buttonBgNormalColor
            btn.backgroundColor = config.buttonBgNormalColor
            if btn.tag == 100 {
                view.cancelButton = btn
                UIFont.systemFont(ofSize: 14)
                btn.cornerRadius = 10
            } else if btn.tag == 200 {
                UIFont.systemFont(ofSize: 14)
                btn.cornerRadius = 10
            } else {
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                btn.cornerRadius = 30
            }
        }
        return view
    }

    @objc func pressedBtn(_ btn: UIButton) {
        switch btn.tag {
        case 100:
            _tapCancel.accept(())

            print("cancel")
        case 200:
            _tapDelete.accept(())
            print("delete")
        default:
            _tapNumber.accept("\(btn.tag)")
            print(btn.tag)
        }
    }
}
