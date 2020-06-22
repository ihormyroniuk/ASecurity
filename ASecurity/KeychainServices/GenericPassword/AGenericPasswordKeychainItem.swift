//
//  AGenericPasswordKeychainItem.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import Security

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

kSecClassGenericPassword item attributes:
    kSecAttrAccess (OS X only)
    kSecAttrAccessControl
    //kSecAttrAccessGroup (iOS; also OS X if kSecAttrSynchronizable and/or kSecUseDataProtectionKeychain set)
    kSecAttrAccessible (iOS; also OS X if kSecAttrSynchronizable and/or kSecUseDataProtectionKeychain set)
    //kSecAttrCreationDate
    //kSecAttrModificationDate
    //kSecAttrDescription
    //kSecAttrComment
    kSecAttrCreator
    kSecAttrType
    //kSecAttrLabel
    //kSecAttrIsInvisible
    //kSecAttrIsNegative
    //kSecAttrAccount
    //kSecAttrService
    kSecAttrGeneric
    //kSecAttrSynchronizable
