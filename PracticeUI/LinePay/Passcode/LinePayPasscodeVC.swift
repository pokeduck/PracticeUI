//
//  LinePayPasscodeVC.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/6.
//

import RxCocoa
import RxSwift
import UIKit

final class LinePayPasscodeVC: UIViewController {
    private let disposeBag = DisposeBag()

    enum Style {
        case auth
        case setup
        case change
    }

    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "PingFangTC-Medium", size: 24)
        l.textColor = .white
        view.addSubview(l)
        l.snp.makeConstraints { make in
            make.bottom.equalTo(signsView.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        return l
    }()

    lazy var signsView: PasscodeSignsView = {
        let v = PasscodeSignsView()
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
        }
        v.backgroundColor = .clear
        return v
    }()

    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "PingFangTC-Medium", size: 12)
        l.textColor = .white
        view.addSubview(l)
        l.numberOfLines = 0
        l.textAlignment = .center
        l.snp.makeConstraints { make in
            make.top.equalTo(signsView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        return l
    }()

    lazy var biometryBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Touch IDAAA", for: .normal)
        view.addSubview(btn)
        btn.titleLabel?.font = UIFont(name: "PingFangTC-Medium", size: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.snp.makeConstraints { make in
            make.bottom.equalTo(numericPadView.snp.top).offset(0)
            make.left.equalTo(view.snp.centerX).offset(20)
        }
        return btn
    }()

    lazy var numericPadView: PasscodeNumericPadView = {
        let config = PasscodeNumericPadView.Config.lineTheme
        let v = PasscodeNumericPadView.instance(with: config)
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom)
            make.left.equalTo(view.safeArea.left)
            make.right.equalTo(view.safeArea.right)
            make.height.equalTo(350)
        }
        return v
    }()

    lazy var hude: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .gray)
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        v.hidesWhenStopped = true
        v.stopAnimating()
        return v
    }()

    var vm: PasscodeViewModelType!
    init(style: Style) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        switch style {
        case .auth:
            vm = PasscodeAuthViewModel()
        case .setup:
            vm = PasscodeSetupViewModel()
        case .change:
            vm = PasscodeChangeViewModel()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Line.main

        bindViewModel()
    }

    deinit {
        print("passcode vc release")
    }

    private func bindViewModel() {
        vm.title.driver
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        vm.detail.driver
            .drive(detailLabel.rx.text)
            .disposed(by: disposeBag)

        vm.didSucceed.emit(onNext: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)

        vm.addSign
            .emit(to: signsView.addSign)
            .disposed(by: disposeBag)
        vm.removeSign
            .emit(to: signsView.removeSign)
            .disposed(by: disposeBag)
        vm.cleanSigns
            .emit(to: signsView.cleanSigns)
            .disposed(by: disposeBag)

        numericPadView.tapNumber
            .emit(to: vm.addNumber)
            .disposed(by: disposeBag)
        numericPadView.tapCancel
            .emit(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        numericPadView.tapDelete
            .emit(to: vm.deleteNumber)
            .disposed(by: disposeBag)

        vm.isHUDShow
            .drive(hude.rx.isAnimating)
            .disposed(by: disposeBag)

        vm.isBiometryHidden
            .bind(to: biometryBtn.rx.isHidden)
            .disposed(by: disposeBag)

        vm.biometryLocalizeText
            .bind(to: biometryBtn.rx.title(for: .normal))
            .disposed(by: disposeBag)

        if numericPadView.cancelButton != nil {
            vm.isCancelHidden
                .bind(to: numericPadView.cancelButton!.rx.isHidden)
                .disposed(by: disposeBag)
        }

        biometryBtn.rx.tap
            .bind(to: vm.useBiometry)
            .disposed(by: disposeBag)

        rx.viewDidAppear.asSignal()
            .map { _ in () }
            .emit(to: vm.useBiometry)
            .disposed(by: disposeBag)
    }

    override var prefersStatusBarHidden: Bool {
        true
    }
}
