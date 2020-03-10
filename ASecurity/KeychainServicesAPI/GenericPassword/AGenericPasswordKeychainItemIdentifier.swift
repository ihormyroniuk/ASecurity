//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/6/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import Foundation

public struct AGenericPasswordKeychainItemIdentifier {

    private let service: String
    private let account: String

    public init(service: String, account: String) {
        self.service = service
        self.account = account
    }

    // MARK: Keychain Item

    var dictionary: [String: Any] {
        var dictionary = [String: Any]()
        dictionary[kSecClass as String] = kSecClassGenericPassword
        dictionary[kSecAttrService as String] = service
        dictionary[kSecAttrAccount as String] = account
        return dictionary
    }

}
