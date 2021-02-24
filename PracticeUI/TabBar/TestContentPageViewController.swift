//
// TestContentPageViewController.swift
//
// Created by Ben for PracticeUI on 2021/2/17.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import SnapKit

final class TestContentPageViewController: UIViewController {
    
    private let content: String
    
    init(content: String) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let titleL = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        view.addSubview(titleL)
        titleL.text = content
        titleL.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        titleL.font = UIFont.systemFont(ofSize: 30)
//        view.bringSubviewToFront(titleL)
//        view.sendSubviewToBack(titleL)
        titleL.superview?.bringSubviewToFront(titleL)
        // Do any additional setup after loading the view.
        view.backgroundColor = .random
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
