//
// Localize++.swift
//
// Created by Ben for PracticeUI on 2021/3/17.
// Copyright © 2021 Alien. All rights reserved.
//

import Localize_Swift

extension Localize {
    class func displayNameForLanguage(_ language: String, dependOnLang: Bool = false) -> String {
        if !dependOnLang {
            return displayNameForLanguage(language)
        }
        let locale : NSLocale = NSLocale(localeIdentifier: language)
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}
