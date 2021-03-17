//
// LocalizationDemoVC.swift
//
// Created by Ben for PracticeUI on 2021/2/26.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

class LocalizationDemoVC: UIViewController {
//    for (NSString *language in [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]) {
//        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
//        NSLog(@"%@: %@", language, NSLocalizedStringFromTableInBundle(@"Testing", @"Localizable", bundle, nil));
//    }
    override func viewDidLoad() {
        let category = UIApplication.shared.preferredContentSizeCategory
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: .main) { (notification) in
            guard let userInfo = notification.userInfo else { return }
            if let sizeVal = userInfo[UIContentSizeCategory.newValueUserInfoKey] as? UIContentSizeCategory {
                print(sizeVal)
            }
            
        }
        print("Size category: \(category.rawValue)")
        print("Label Size: \(UIFont.labelFontSize)")
        print("Button Size: \(UIFont.buttonFontSize)")
        print("Small Size: \(UIFont.smallSystemFontSize)")
        let localPath = Bundle.main.path(forResource: "Localizable", ofType: "strings")
        let localDict = NSDictionary(contentsOfFile: localPath!)
        print(localDict)
        (UserDefaults.standard.object(forKey: "AppleLangues") as? [String])?.forEach({ (string) in
            guard let bundlePath = Bundle.main.path(forResource: string, ofType: "lproj"),
                  let bundle = Bundle(path: bundlePath) else { return }
            
            let localStr = NSLocalizedString("Hello", tableName: "Localizable", bundle: bundle, value: "Value", comment: "Comment")
            print(localStr)
        })
        let langBundle = AnyLanguageBundle()
        Bundle.setLanguage("zh")

        let strA = langBundle.localizedString(forKey: "hello", value: "Zz", table: nil)
        Bundle.setLanguage("en")
        let strB = langBundle.localizedString(forKey: "hello", value: nil, table: nil)
        super.viewDidLoad()
        let str = NSLocalizedString("hello", comment: "AA")
        title = str
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        let l = UILabel()
        l.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        view.addSubview(l)
        
        l.textColor = .black
        l.text = Locale.current.languageCode?.identity
        let support = Locale.preferredLanguages
        print("Prefered Lang:\(support)")
        let setLang = support.first?.identity ?? "zh"
        Bundle.setLanguage(setLang)
        let str2 = NSLocalizedString("hello", comment: "AA")
        print(str2)

    }
    
    

}
var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {

override func localizedString(forKey key: String,
                              value: String?,
                              table tableName: String?) -> String {

    guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
        let bundle = Bundle(path: path) else {

            return super.localizedString(forKey: key, value: value, table: tableName)
    }

    return bundle.localizedString(forKey: key, value: value, table: tableName)
  }
}

extension Bundle {

class func setLanguage(_ language: String) {

    defer {

        object_setClass(Bundle.main, AnyLanguageBundle.self)
    }

    objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}
