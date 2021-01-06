//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import Security

public struct GenericPasswordKeychainItem {

    public let identifier: GenericPasswordKeychainItemIdentifier
    public var data: Data?

    public init(identifier: GenericPasswordKeychainItemIdentifier, data: Data? = nil) {
        self.identifier = identifier
        self.data = data
    }

    // MARK: Keychain Item

    init?(dictionary: [String: Any]) {
        guard let identifier = GenericPasswordKeychainItemIdentifier(dictionary: dictionary) else { return nil }
        let data = dictionary[kSecValueData as String] as? Data
        self.init(identifier: identifier, data: data)
    }

    var dictionary: [String: Any] {
        var dictionary = identifier.dictionary
        dictionary[kSecValueData as String] = data
        return dictionary
    }

    var dictionaryToUpdate: [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[kSecValueData as String] = data
        return dictionary
    }

}
