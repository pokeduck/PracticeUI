//
// CustomTransitionVC.swift
//
// Created by Ben for PracticeUI on 2021/5/6.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomTransitionVC: UIViewController {
    private let bag = DisposeBag()
    override func viewDidLoad() {
        view.backgroundColor = .white
        let btn = UIButton(type: .system)
        view.addSubview(btn)
        btn.rx.tap.subscribe { _ in
            //self.navigationController?.popViewController()
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        btn.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.centerY.equalToSuperview()
        }
        btn.setTitle("Back", for: .normal)
    }
}
