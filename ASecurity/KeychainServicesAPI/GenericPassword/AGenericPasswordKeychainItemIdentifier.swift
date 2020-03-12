//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/6/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import Foundation

public struct AGenericPasswordKeychainItemIdentifier: Equatable, Hashable {

    private let service: String
    private let account: String
    private let accessGroup: String?
    private let isSynchronizable: Bool?

    public init(service: String, account: String, accessGroup: String?, isSynchronizable: Bool?) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
        self.isSynchronizable = isSynchronizable
    }

    // MARK: Keychain Item

    var dictionary: [String: Any] {
        var dictionary = [String: Any]()
        dictionary[kSecClass as String] = kSecClassGenericPassword
        dictionary[kSecAttrService as String] = service
        dictionary[kSecAttrAccount as String] = account
        dictionary[kSecAttrAccessGroup as String] = accessGroup
        dictionary[kSecAttrSynchronizable as String] = isSynchronizable
        return dictionary
    }

}
