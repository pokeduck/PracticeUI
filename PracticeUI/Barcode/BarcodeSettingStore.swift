//
// BarcodeSettingStore.swift
//
// Created by Ben for PracticeUI on 2021/2/24.
// Copyright © 2021 Alien. All rights reserved.
//

import AVFoundation
struct BarcodeTypeState {
    typealias Key = AVMetadataObject.ObjectType.RawValue
    let type: AVMetadataObject.ObjectType
    var isOn: Bool
}
class BarcodeSettingStore {
    static let shared = BarcodeSettingStore()
    private static let avaiableTypes: [AVMetadataObject.ObjectType] = [
        .upce,
        .code39,
        .code39Mod43,
        .ean13,
        .ean8,
        .code93,
        .code128,
        .pdf417,
        .aztec,
        .face,
        .dataMatrix,
        .interleaved2of5,
        .itf14,
        .qr
    ]
    private let userDefault = UserDefaults.standard
    private var activeType: [BarcodeTypeState.Key : BarcodeTypeState] = [:]
    private init() {
        let available = BarcodeSettingStore.avaiableTypes
        available.forEach { (obj) in
            activeType[obj.rawValue] = BarcodeTypeState(type: obj, isOn: false)
        }
        if let storage = userDefault.stringArray(forKey: .barcodeSetting) {
            storage.forEach { (key) in
                activeType[key]?.isOn = true
            }
        } else {
            available.forEach { (obj) in
                activeType[obj.rawValue] = BarcodeTypeState(type: obj, isOn: true)
            }
        }
    }
    
    func settingStates() -> [BarcodeTypeState] {
        let states = activeType.map { (key,value) -> BarcodeTypeState in
            return value
        }
        return states
    }
    
    func swap(_ state:BarcodeTypeState) {
        if state.isOn {
            turnOff(type: state.type)
        } else {
            turnOn(type: state.type)
        }
    }
    
    private func turnOn(type: AVMetadataObject.ObjectType) {
        activeType[type.rawValue]?.isOn = true
        saveCurrentActiveTypes()
    }
    private func turnOff(type: AVMetadataObject.ObjectType) {
        activeType[type.rawValue]?.isOn = false
        saveCurrentActiveTypes()
    }
    private func saveCurrentActiveTypes() {
        let strings = activeType
            .filter { $1.isOn }
            .map { $1.type.rawValue }
        userDefault[.barcodeSetting] = strings
    }
    func avaiableTypes() -> [AVMetadataObject.ObjectType] {
        let available = BarcodeSettingStore.avaiableTypes
        return available.filter { (obj) -> Bool in
            if let type = activeType[obj.rawValue] {
                if type.isOn {
                    return true
                }
            }
            return false
        }
    }
    
}

extension UserDefaults.Key {
    static let barcodeSetting = UserDefaults.Key(rawValue: "barcode.setting")
}
