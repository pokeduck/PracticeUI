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
            self.wk_TabBarController?.setSelectedIndex(index: 0)
        }.disposed(by: bag)
        
        let btn2 = UIButton(frame: .zero)
        btn2.frame = CGRect(x: 30, y: 200, width: 100, height: 100)
        btn2.setTitleColor(.black, for: .normal)
        view.addSubview(btn2)
        btn2.setTitle("page2", for: .normal)
        btn2.rx.tap.bind { (_) in
            self.wk_TabBarController?.setSelectedIndex(index: 1)
        }.disposed(by: bag)
        
        let btn3 = UIButton(frame: .zero)
        btn3.frame = CGRect(x: 30, y: 300, width: 100, height: 100)
        btn3.setTitleColor(.black, for: .normal)
        view.addSubview(btn3)
        btn3.setTitle("page3", for: .normal)
        btn3.rx.tap.bind { (_) in
            self.wk_TabBarController?.setSelectedIndex(index: 2)
        }.disposed(by: bag)
        
        let btn4 = UIButton(frame: .zero)
        btn4.frame = CGRect(x: 30, y: 400, width: 100, height: 100)
        btn4.setTitleColor(.black, for: .normal)
        view.addSubview(btn4)
        btn4.setTitle("content push", for: .normal)
        btn4.rx.tap.bind { (_) in
            let newVC = BDBaseViewController()
            self.navigationController?.pushViewController(newVC)
        }.disposed(by: bag)
        
        let btn5 = UIButton(frame: .zero)
        btn5.frame = CGRect(x: 30, y: 500, width: 100, height: 100)
        btn5.setTitleColor(.black, for: .normal)
        view.addSubview(btn5)
        btn5.setTitle("tab push", for: .normal)
        btn5.rx.tap.bind { (_) in
            let newVC = BDBaseViewController()
            self.wk_TabBarController?.navigationController?.pushViewController(newVC)
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
 
class BDTableViewController: UIViewController {
    let tv: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tv)
        tv.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
        view.backgroundColor = .white
        tv.backgroundColor = .white
        tv.register(cellWithClass: UITableViewCell.self)
        tv.delegate = self
        tv.dataSource = self
        
    }
}

extension BDTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = BDBaseViewController()
        self.navigationController?.pushViewController(newVC)
    }
}


extension BDTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        cell.textLabel?.text = "ACJOISJD"
        return cell
    }
    
    
}


