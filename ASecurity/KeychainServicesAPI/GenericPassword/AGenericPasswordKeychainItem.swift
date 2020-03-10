//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

public struct AGenericPasswordKeychainItem {

    public let identifier: AGenericPasswordKeychainItemIdentifier
    public var accessGroup: String?
    public var data: Data?

    public init(identifier: AGenericPasswordKeychainItemIdentifier, accessGroup: String?, data: Data?) {
        self.identifier = identifier
        self.accessGroup = accessGroup
        self.data = data
    }

    // MARK: Keychain Item

    var dictionary: [String: Any] {
        var dictionary = identifier.dictionary
        dictionary[kSecAttrAccessGroup as String] = accessGroup
        dictionary[kSecValueData as String] = data
        return dictionary
    }

}
