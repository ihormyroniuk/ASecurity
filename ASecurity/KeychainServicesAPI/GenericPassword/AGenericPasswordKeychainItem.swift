//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

public struct AGenericPasswordKeychainItem: Equatable, Hashable {

    public let identifier: AGenericPasswordKeychainItemIdentifier
    public var data: Data?

    public init(identifier: AGenericPasswordKeychainItemIdentifier, data: Data?) {
        self.identifier = identifier
        self.data = data
    }

    // MARK: Keychain Item

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
