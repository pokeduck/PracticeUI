//
//  UserDefaults.swift
//
//  Created by Shaps Benkau on 24/05/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//
import Foundation

#if os(iOS)
    import UIKit
    public typealias SystemColor = UIColor
#else
    import Cocoa
    public typealias SystemColor = NSColor
#endif

public extension UserDefaults {
    func set<T>(_ value: T?, forKey key: Key) {
        set(value, forKey: key.rawValue)
    }

    func value<T>(forKey key: Key) -> T? {
        value(forKey: key.rawValue) as? T
    }

    func register(defaults: [Key: Any]) {
        let mapped = Dictionary(uniqueKeysWithValues: defaults.map { key, value -> (String, Any) in
            if let color = value as? SystemColor {
                return (key.rawValue, NSKeyedArchiver.archivedData(withRootObject: color))
            } else if let url = value as? URL {
                return (key.rawValue, url.absoluteString)
            } else {
                return (key.rawValue, value)
            }
        })

        register(defaults: mapped)
    }
}

public extension UserDefaults {
    subscript<T>(key: Key) -> T? {
        get { value(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> SystemColor? {
        get { color(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> URL? {
        get { url(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> Bool {
        get { bool(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> Int {
        get { integer(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> Double {
        get { double(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> Float {
        get { float(forKey: key) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> CGFloat {
        get { CGFloat(float(forKey: key) as Float) }
        set { set(newValue, forKey: key) }
    }

    subscript(key: Key) -> [String]? {
        get { stringArray(forKey: key) }
        set { set(newValue, forKey: key) }
    }
}

public extension UserDefaults {
    func bool(forKey key: Key) -> Bool {
        bool(forKey: key.rawValue)
    }

    func integer(forKey key: Key) -> Int {
        integer(forKey: key.rawValue)
    }

    func float(forKey key: Key) -> Float {
        float(forKey: key.rawValue)
    }

    func float(forKey key: Key) -> CGFloat {
        CGFloat(float(forKey: key) as Float)
    }

    func double(forKey key: Key) -> Double {
        double(forKey: key.rawValue)
    }

    func url(forKey key: Key) -> URL? {
        string(forKey: key).flatMap { URL(string: $0) }
    }

    func date(forKey key: Key) -> Date? {
        object(forKey: key.rawValue) as? Date
    }

    func string(forKey key: Key) -> String? {
        string(forKey: key.rawValue)
    }

    func stringArray(forKey key: Key) -> [String]? {
        stringArray(forKey: key.rawValue)
    }

    func set(_ url: URL?, forKey key: Key) {
        set(url?.absoluteString, forKey: key.rawValue)
    }

    func set(_ color: SystemColor?, forKey key: Key) {
        guard let color = color else {
            set(nil, forKey: key.rawValue)
            return
        }

        let data = NSKeyedArchiver.archivedData(withRootObject: color)
        set(data, forKey: key.rawValue)
    }

    func color(forKey key: Key) -> SystemColor? {
        data(forKey: key.rawValue)
            .flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) as? SystemColor }
    }

    func removeObject(forKey key: Key) {
        removeObject(forKey: key.rawValue)
    }
}

public extension UserDefaults {
    struct Key: Hashable, RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }
}
