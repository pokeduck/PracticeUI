//
// LocalizationDemoVC.swift
//
// Created by Ben for PracticeUI on 2021/2/26.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import Localize_Swift
class LocalizationDemoVC: UIViewController {
//    for (NSString *language in [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]) {
//        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
//        NSLog(@"%@: %@", language, NSLocalizedStringFromTableInBundle(@"Testing", @"Localizable", bundle, nil));
//    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        let currentHello = "hello".localized()
        Localize.setCurrentLanguage("fr")
        let frHello = "hello".localized()
        print("\(currentHello),\(frHello)")
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    

}

