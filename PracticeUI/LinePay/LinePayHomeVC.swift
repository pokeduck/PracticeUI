//
//  LinePayHomeVC.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/6.
//

import RxCocoa
import RxSwift
import UIKit

class LinePayHomeVC: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = PasscodeAuthViewModel()
    lazy var testBtn: PasscodeNumericButton = {
        let btn = PasscodeNumericButton(type: .system)
        btn.setTitle("1", for: .normal)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(55)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1)
        }
        btn.titleColorForNormal = Colors.Line.appLockBtnNormalText
        // btn.titleColorForHighlighted = Colors.Line.appLockBtnPressedText
        btn.backgroundColorForHighlighted = Colors.Line.appLockBtnBgPressed
        btn.backgroundColorForNormal = Colors.Line.appLockBtnBgNormal
        btn.backgroundColor = Colors.Line.appLockBtnBgNormal
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.cornerRadius = 55 / 2
        return btn
    }()

    lazy var signsView: PasscodeSignsView = {
        let v = PasscodeSignsView()
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(100)
        }
        v.backgroundColor = .blue
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Line.main

        // _ = signsView
        testBtn.rx.tap.asSignal().emit(onNext: { [weak self] _ in
            self?.present(LinePayPasscodeVC(style: .auth), animated: true)
        }).disposed(by: disposeBag)
        present(LinePayPasscodeVC(style: .setup), animated: false, completion: nil)
        return

        let pad = PasscodeNumericPadView.instance(with: .lineTheme)
        view.addSubview(pad)
        pad.snp.makeConstraints { make in
            make.width.height.equalTo(370)
            make.center.equalToSuperview()
        }
        pad.tapNumber
            .emit(to: vm.addNumber)
            .disposed(by: disposeBag)

        pad.tapDelete
            .emit(to: vm.deleteNumber)
            .disposed(by: disposeBag)

        vm.addSign.emit(to: signsView.addSign)
            .disposed(by: disposeBag)

        vm.removeSign.emit(to: signsView.removeSign)
            .disposed(by: disposeBag)

        vm.cleanSigns.emit(to: signsView.cleanSigns)
            .disposed(by: disposeBag)

        vm.didSucceed
            .emit(onNext: { _ in
                print("Auth Success")
            })
            .disposed(by: disposeBag)

        vm.didFailed
            .emit(onNext: { _ in
                print("Auth Failed")
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
