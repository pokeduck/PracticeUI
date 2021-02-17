//
//  AppDelegate.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/3.
//  Copyright © 2020 Pokeduck. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavController()
        window?.makeKeyAndVisible()
        return true
    }

}
