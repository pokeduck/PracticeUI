//
// ShadowTopViewBaseVC.swift
//
// Created by Ben for PracticeUI on 2021/4/1.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class ShadowTopViewBaseVC: UIViewController {

    let topViewHeight: CGFloat = 50
    
    lazy var topViewShadow: UIView = {
        let v = UIView()
        view.addSubview(v)
        v.backgroundColor = .white
        v.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(topView)
        }
        v.addShadow(ofColor: .black, radius: 8, offset: .zero, opacity: 0.5)
        return v
    }()
    
    lazy var topView: UIView = {
        let v = UIView()
        view.addSubview(v)
        view.backgroundColor = .white
        v.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(topViewHeight)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        view.addSubview(v)
        view.backgroundColor = .white
        v.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.bringSubviewToFront(contentView)
        view.bringSubviewToFront(topViewShadow)
        view.bringSubviewToFront(topView)
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
