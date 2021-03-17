//
// LocalizationDemoVC.swift
//
// Created by Ben for PracticeUI on 2021/2/26.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import Localize_Swift
import RxCocoa
import RxSwift

class LocalizationDemoVC: UIViewController {
//    for (NSString *language in [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]) {
//        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
//        NSLog(@"%@: %@", language, NSLocalizedStringFromTableInBundle(@"Testing", @"Localizable", bundle, nil));
//    }
    private let bag = DisposeBag()
    override func viewDidLoad() {
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        view.addSubview(label)
        label.textColor = .black
        label.text = "hello".localized()
        navigationController?.setNavigationBarHidden(false, animated: false)
        let btn = UIButton(frame: CGRect(x: 50, y: 300, width: 50, height: 50))
        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        btn.setTitle("Setting", for: .normal)
        btn.rx.tap.subscribe { [weak self] (_) in
            self?.navigationController?.pushViewController(LocalizeSettingTableVC())

        }.disposed(by: bag)

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "LCLLanguageChangeNotification"), object: nil, queue: .main) { (_) in
            label.text = "hello".localized()
        }
    }
    
    
    

}

