//
//  Accessible.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/17/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import Foundation

public enum Accessible {
    case whenPasscodeSetThisDeviceOnly
    case whenUnlockedThisDeviceOnly
    case whenUnlocked
    case afterFirstUnlockThisDeviceOnly
    case afterFirstUnlock

    init?(string: String?) {
        guard let string = string else { return nil }
        let kSecAttrAccessibleWhenPasscodeSetThisDeviceOnlyString = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly as String
        let kSecAttrAccessibleWhenUnlockedThisDeviceOnlyString = kSecAttrAccessibleWhenUnlockedThisDeviceOnly as String
        let kSecAttrAccessibleWhenUnlockedString = kSecAttrAccessibleWhenUnlocked as String
        let kSecAttrAccessibleAfterFirstUnlockThisDeviceOnlyString = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly as String
        let kSecAttrAccessibleAfterFirstUnlockString = kSecAttrAccessibleAfterFirstUnlock as String
        switch string {
        case kSecAttrAccessibleWhenPasscodeSetThisDeviceOnlyString:
            self = .whenPasscodeSetThisDeviceOnly
        case kSecAttrAccessibleWhenUnlockedThisDeviceOnlyString:
            self = .whenUnlockedThisDeviceOnly
        case kSecAttrAccessibleWhenUnlockedString:
            self = .whenUnlocked
        case kSecAttrAccessibleAfterFirstUnlockThisDeviceOnlyString:
            self = .afterFirstUnlockThisDeviceOnly
        case kSecAttrAccessibleAfterFirstUnlockString:
            self = .afterFirstUnlock
        default:
            return nil
        }
    }

    var string: String {
        switch self {
        case .whenPasscodeSetThisDeviceOnly:
            return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly as String
        case .whenUnlockedThisDeviceOnly:
            return kSecAttrAccessibleWhenUnlockedThisDeviceOnly as String
        case .whenUnlocked:
            return kSecAttrAccessibleWhenUnlocked as String
        case .afterFirstUnlockThisDeviceOnly:
            return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly as String
        case .afterFirstUnlock:
            return kSecAttrAccessibleAfterFirstUnlock as String
        }
    }
}
