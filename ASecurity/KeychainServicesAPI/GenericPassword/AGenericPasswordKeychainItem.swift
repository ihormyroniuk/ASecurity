//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

public struct AGenericPasswordKeychainItemIdentifier: Equatable, Hashable {

    public let `class` = kSecClassGenericPassword
    public let service: String
    public let account: String
    public let accessGroup: String
    public let isSynchronizable: Bool

    public init(service: String, account: String, accessGroup: String, isSynchronizable: Bool) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
        self.isSynchronizable = isSynchronizable
    }

    // MARK: Keychain Item

    init?(dictionary: [String: Any]) {
        guard let service = dictionary[kSecAttrService as String] as? String else { return nil }
        guard let account = dictionary[kSecAttrAccount as String] as? String else { return nil }
        guard let accessGroup = dictionary[kSecAttrAccessGroup as String] as? String else { return nil }
        guard let isSynchronizable = dictionary[kSecAttrSynchronizable as String] as? Bool else { return nil }
        self.init(service: service, account: account, accessGroup: accessGroup, isSynchronizable: isSynchronizable)
    }

    var dictionary: [String: Any] {
        var dictionary = [String: Any]()
        dictionary[kSecClass as String] = `class`
        dictionary[kSecAttrService as String] = service
        dictionary[kSecAttrAccount as String] = account
        dictionary[kSecAttrAccessGroup as String] = accessGroup
        dictionary[kSecAttrSynchronizable as String] = isSynchronizable
        return dictionary
    }

}

public struct AGenericPasswordKeychainItem {

    public let identifier: AGenericPasswordKeychainItemIdentifier
    public var data: Data?
    public private(set) var creationDate: Date?
    public private(set) var modificationDate: Date?
    public var label: String?
    public var comment: String?
    public var description: String?
    public var isInvisible: Bool?
    public var isNegative: Bool?
    public var accessible: Accessible?

    public init(identifier: AGenericPasswordKeychainItemIdentifier, label: String? = nil, comment: String? = nil, description: String? = nil, isInvisible: Bool? = nil, isNegative: Bool? = nil, accessible: Accessible? = nil, data: Data? = nil) {
        self.identifier = identifier
        self.label = label
        self.description = description
        self.comment = comment
        self.isInvisible = isInvisible
        self.isNegative = isNegative
        self.data = data
        self.accessible = accessible
    }

    // MARK: Keychain Item

    init?(dictionary: [String: Any]) {
        guard let identifier = AGenericPasswordKeychainItemIdentifier(dictionary: dictionary) else { return nil }
        let label = dictionary[kSecAttrLabel as String] as? String
        let comment = dictionary[kSecAttrComment as String] as? String
        let description = dictionary[kSecAttrDescription as String] as? String
        let isInvisible = dictionary[kSecAttrIsInvisible as String] as? Bool
        let isNegative = dictionary[kSecAttrIsNegative as String] as? Bool
        let accessible = Accessible(string: dictionary[kSecAttrAccessible as String] as? String)
        let data = dictionary[kSecValueData as String] as? Data
        self.init(identifier: identifier, label: label, comment: comment, description: description, isInvisible: isInvisible, isNegative: isNegative, accessible: accessible, data: data)
        let creationDate = dictionary[kSecAttrCreationDate as String] as? Date
        self.creationDate = creationDate
        let modificationDate = dictionary[kSecAttrModificationDate as String] as? Date
        self.modificationDate = modificationDate
    }

    var dictionary: [String: Any] {
        var dictionary = identifier.dictionary
        dictionary[kSecAttrLabel as String] = label
        dictionary[kSecAttrComment as String] = comment
        dictionary[kSecAttrDescription as String] = description
        dictionary[kSecAttrIsInvisible as String] = isInvisible
        dictionary[kSecAttrIsNegative as String] = isNegative
        dictionary[kSecAttrAccessible as String] = accessible?.string
        dictionary[kSecValueData as String] = data
        return dictionary
    }

    var dictionaryToUpdate: [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[kSecAttrLabel as String] = label
        dictionary[kSecAttrComment as String] = comment
        dictionary[kSecAttrDescription as String] = description
        dictionary[kSecAttrIsInvisible as String] = isInvisible
        dictionary[kSecAttrIsNegative as String] = isNegative
        dictionary[kSecAttrAccessible as String] = accessible?.string
        dictionary[kSecValueData as String] = data
        return dictionary
    }

}
