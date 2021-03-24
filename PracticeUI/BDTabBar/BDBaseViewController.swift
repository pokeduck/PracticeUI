//
// BDBaseViewController.swift
//
// Created by Ben for PracticeUI on 2021/3/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class BDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController
        // Do any additional setup after loading the view.
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
extension BDBaseViewController {
    var bdTabBarController: BDTabBarController {
        
    }
}
 
