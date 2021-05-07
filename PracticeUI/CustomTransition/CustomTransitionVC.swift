//
// CustomTransitionVC.swift
//
// Created by Ben for PracticeUI on 2021/5/6.
// Copyright © 2021 Alien. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class CustomTransitionContentVC: UIViewController {
    private let bag = DisposeBag()
    override func viewDidLoad() {
        view.backgroundColor = .white
        let btn = UIButton(type: .system)
        view.addSubview(btn)
        btn.rx.tap.subscribe { _ in
            // self.navigationController?.popViewController()
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        btn.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.centerY.equalToSuperview()
        }
        btn.setTitle("Dismiss", for: .normal)
        title = "I am Page1"

        let btn2 = UIButton(type: .system)
        view.addSubview(btn2)
        btn2.rx.tap.subscribe { _ in
            self.navigationController?.pushViewController(CustomTransitionContentDetailVC())

        }.disposed(by: bag)
        btn2.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(btn.snp.bottom).offset(50)
        }
        btn2.setTitle("Push", for: .normal)
    }
}

class CustomTransitionContentDetailVC: UIViewController {
    private let bag = DisposeBag()
    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "I am Detail "
    }
}
