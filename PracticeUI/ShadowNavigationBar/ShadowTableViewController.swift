//
// ShadowTableViewController.swift
//
// Created by Ben for PracticeUI on 2021/4/1.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import SnapKit

class ShadowTableViewController: ShadowTopViewBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tv = UITableView()
        contentView.addSubview(tv)
        tv.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }

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
