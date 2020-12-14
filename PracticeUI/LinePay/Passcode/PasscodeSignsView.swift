//
//  PasscodeSignsView.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/14.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import ChameleonFramework
import RxCocoa
import RxSwift
import UIKit

final class PasscodeSignsView: UIView {
    let addSign = PublishRelay<PasscodeIndex>()
    let removeSign = PublishRelay<PasscodeIndex>()

    let cleanSigns = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    fileprivate static let signSize: CGFloat = 15
    private var signSize: CGFloat { PasscodeSignsView.signSize }
    private let signsCount: Int = 6
    private lazy var signStartXFactor: CGFloat = {
        // x : 2 = 15 : width
        let startX = signSize / width
        return startX
    }()

    private lazy var signXFactor: CGFloat = {
        // x : 2 = perGap : width
        let perGap = (width - signSize) / CGFloat(signsCount - 1)
        let gapXFactor = 2 * perGap / width
        return gapXFactor
    }()

    lazy var sign0: PasscodeSignView = {
        let v = PasscodeSignView(style: .empty)
        addSubview(v)
        v.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(signSize)
            make.centerX.equalToSuperview().multipliedBy(signStartXFactor)
        }
        return v
    }()

    lazy var sign1: PasscodeSignView = {
        let v = PasscodeSignView(style: .empty)
        addSubview(v)
        v.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(signSize)
            make.centerX.equalToSuperview()
                .multipliedBy(signStartXFactor + signXFactor)
        }
        return v
    }()

    lazy var sign2: PasscodeSignView = {
        let v = PasscodeSignView(style: .empty)
        addSubview(v)
        v.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(signSize)
            make.centerX.equalToSuperview()
                .multipliedBy(signStartXFactor + signXFactor * 2)
        }
        return v
    }()

    lazy var sign3: PasscodeSignView = {
        let v = PasscodeSignView(style: .empty)
        addSubview(v)
        v.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(signSize)
            make.centerX.equalToSuperview()
                .multipliedBy(signStartXFactor + signXFactor * 3)
        }
        return v
    }()

    lazy var sign4: PasscodeSignView = {
        let v = PasscodeSignView(style: .empty)
        addSubview(v)
        v.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(signSize)
            make.centerX.equalToSuperview()
                .multipliedBy(signStartXFactor + signXFactor * 4)
        }
        return v
    }()

    lazy var sign5: PasscodeSignView = {
        let v = PasscodeSignView(style: .empty)
        addSubview(v)
        v.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(signSize)
            make.centerX.equalToSuperview()
                .multipliedBy(signStartXFactor + signXFactor * 5)
        }
        // v.backgroundColor = .green
        return v
    }()

    init() {
        super.init(frame: .zero)
        bind()
    }

    private func bind() {
        addSign.bind(onNext: { [weak self] index in
            switch index {
            case 0:
                self?.sign0.setStyle(.highlight)
            case 1:
                self?.sign1.setStyle(.highlight)
            case 2:
                self?.sign2.setStyle(.highlight)
            case 3:
                self?.sign3.setStyle(.highlight)
            case 4:
                self?.sign4.setStyle(.highlight)
            case 5:
                self?.sign5.setStyle(.highlight)
            default:
                break
            }
        }).disposed(by: disposeBag)

        removeSign.bind(onNext: { [weak self] index in
            switch index {
            case 0:
                self?.sign0.setStyle(.empty)
            case 1:
                self?.sign1.setStyle(.empty)
            case 2:
                self?.sign2.setStyle(.empty)
            case 3:
                self?.sign3.setStyle(.empty)
            case 4:
                self?.sign4.setStyle(.empty)
            case 5:
                self?.sign5.setStyle(.empty)
            default:
                break
            }
        }).disposed(by: disposeBag)

        cleanSigns.bind(onNext: { [weak self] _ in
            self?.sign0.setStyle(.empty)
            self?.sign1.setStyle(.empty)
            self?.sign2.setStyle(.empty)
            self?.sign3.setStyle(.empty)
            self?.sign4.setStyle(.empty)
            self?.sign5.setStyle(.empty)

        }).disposed(by: disposeBag)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        sign0.setStyle(.empty)
        sign1.setStyle(.empty)
        sign2.setStyle(.empty)
        sign3.setStyle(.empty)
        sign4.setStyle(.empty)
        sign5.setStyle(.empty)
    }
}

class PasscodeSignView: UIView {
    enum Style {
        case empty
        case highlight
    }

    private var style: Style

    func setStyle(_ style: Style) {
        self.style = style
        switch style {
        case .empty:
            backgroundColor = UIColor(hexString: "#010803", withAlpha: 0.1)
        case .highlight:
            backgroundColor = .white
        }
    }

    init(style: Style) {
        self.style = style
        super.init(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
    }

    override private init(frame: CGRect) {
        style = .empty
        super.init(frame: frame)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        switch style {
        case .empty:
            backgroundColor = UIColor(hexString: "#010803", withAlpha: 0.1)
        case .highlight:
            backgroundColor = .white
        }
        cornerRadius = PasscodeSignsView.signSize / 2
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
