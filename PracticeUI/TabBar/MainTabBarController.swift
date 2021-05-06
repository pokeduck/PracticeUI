//
// MainTabBarController.swift
//
// Created by Ben for PracticeUI on 2021/2/17.
// Copyright © 2021 Alien. All rights reserved.
//

import ESTabBarController_swift

class MainTabBarController: ESTabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        // object_setClass(self.tabBar, ConvexTabBar.self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override var tabBar: UITabBar {
//        return ConvexTabBar()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let tabBar = tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
        let v1 = TestContentPageViewController(content: "1")
        let v2 = TestContentPageViewController(content: "2")
        let v3 = TestContentPageViewController(content: "3")
        let v4 = TestContentPageViewController(content: "4")
        let v5 = TestContentPageViewController(content: "5")

        v1.tabBarItem = ESTabBarItem(ExampleBasicContentView(), title: "home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem(ExampleBasicContentView(), title: "find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem(ExampleIrregularityContentView(), title: "photo", image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
        v4.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v5.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

        viewControllers = [v1, v2, v3, v4, v5]

        title = "Example"

//        let vc0 = TestContentPageViewController(content: "0")
//        let item0 = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
//        vc0.tabBarItem = item0
//
//        let vc1 = TestContentPageViewController(content: "1")
//        let item1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
//        vc1.tabBarItem = item1
//
//        let vc2 = TestContentPageViewController(content: "2")
//        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
//        vc2.tabBarItem = item2
//
//        let vc3 = TestContentPageViewController(content: "3")
//        let item3 = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
//        vc3.tabBarItem = item3
//
//        let vc4 = TestContentPageViewController(content: "4")
//        let item4 = UITabBarItem(tabBarSystemItem: .favorites, tag: 4)
//        vc4.tabBarItem = item4
//
//        viewControllers = [vc0, vc1, vc2, vc3, vc4]
//
//        delegate = self
//
//

        let tabBar = { () -> ConvexTabBar in
            let tabBar = ConvexTabBar()
            tabBar.delegate = self

//            tabBar.delegate = superclass
//            tabBar.delegate = super
//            tabBar.customDelegate = super
//            tabBar.tabBarController = super
            return tabBar
        }()
        setValue(tabBar, forKey: "tabBar")
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

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        tabBar.setNeedsDisplay()
        return true
    }
}

//
// extension MainTabBarController: UITabBarDelegate {
//
// }
