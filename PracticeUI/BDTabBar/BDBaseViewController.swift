//
// BDBaseViewController.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BDBaseViewController: UIViewController {
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        funcLog()
        
        let btn1 = UIButton(frame: .zero)
        btn1.frame = CGRect(x: 30, y: 100, width: 100, height: 100)
        btn1.setTitleColor(.black, for: .normal)
        btn1.setTitle("page1", for: .normal)
        view.addSubview(btn1)
        btn1.rx.tap.bind { (_) in
            self.bdTabBarController?.setSelectedIndex(index: 0)
        }.disposed(by: bag)
        
        let btn2 = UIButton(frame: .zero)
        btn2.frame = CGRect(x: 30, y: 200, width: 100, height: 100)
        btn2.setTitleColor(.black, for: .normal)
        view.addSubview(btn2)
        btn2.setTitle("page2", for: .normal)
        btn2.rx.tap.bind { (_) in
            self.bdTabBarController?.setSelectedIndex(index: 1)
        }.disposed(by: bag)
        
        let btn3 = UIButton(frame: .zero)
        btn3.frame = CGRect(x: 30, y: 300, width: 100, height: 100)
        btn3.setTitleColor(.black, for: .normal)
        view.addSubview(btn3)
        btn3.setTitle("page3", for: .normal)
        btn3.rx.tap.bind { (_) in
            self.bdTabBarController?.setSelectedIndex(index: 2)
        }.disposed(by: bag)
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        funcLog()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        funcLog()
    }


}
extension UIViewController {
    var bdTabBarItem: BDTabBarItem? {
        return tabBarItem as? BDTabBarItem
    }
    
    var bdTabBarController: BDTabBarController? {
        var currentVC = self as UIViewController
        while let currentParent = currentVC.parent {
            if let bdParent = parent as? BDTabBarController {
                return bdParent
            }
            currentVC = currentParent
        }
        return nil
    }
}
 
