//
// FontSize.swift
//
// Created by Ben for PracticeUI on 2021/3/17.
// Copyright © 2021 Alien. All rights reserved.
//

import SnapKit
import UIKit

class FontSizeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 100, y: 320, width: 300, height: 30))
        label.font = UIFont(descriptor: .preferredDescriptor(textStyle: .headline), size: 0)
        label.text = "HEADLINE"
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: .main) { _ in
            label.font = UIFont(descriptor: .preferredDescriptor(textStyle: .headline), size: 0)
        }

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
