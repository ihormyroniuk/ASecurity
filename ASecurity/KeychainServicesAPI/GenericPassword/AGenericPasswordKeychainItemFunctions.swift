//
//  AGenericPasswordKeychainItemGetterSetter.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

public func selectGenericPasswordKeychainItem(identifier: AGenericPasswordKeychainItemIdentifier) throws -> AGenericPasswordKeychainItem? {
    var query = identifier.dictionary
    query[kSecMatchLimit as String] = kSecMatchLimitOne
    query[kSecReturnData as String] = kCFBooleanTrue
    query[kSecReturnAttributes as String] = kCFBooleanTrue
    var result: AnyObject?
    let status = withUnsafeMutablePointer(to: &result) {
        SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }
    if status == noErr {
        guard let dictionary = result as? [String: Any] else { return nil }
        let data = dictionary[kSecValueData as String] as? Data
        let genericPasswordKeychainItem = AGenericPasswordKeychainItem(identifier: identifier, data: data)
        return genericPasswordKeychainItem
    } else if status == errSecItemNotFound {
        return nil
    } else {
        throw AKeychainServicesAPIError(status: status)
    }
}

public func createGenericPasswordKeychainItem(_ item: AGenericPasswordKeychainItem) throws {
    let attributes = item.dictionary
    var result: AnyObject?
    let status = withUnsafeMutablePointer(to: &result) {
        SecItemAdd(attributes as CFDictionary, UnsafeMutablePointer($0))
    }
    if status != noErr {
        throw AKeychainServicesAPIError(status: status)
    }
}

public func updateGenericPasswordKeychainItem(_ item: AGenericPasswordKeychainItem) throws {
    let query = item.identifier.dictionary
    let attributesToUpdate = item.dictionaryToUpdate
    let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    if status != noErr {
        throw AKeychainServicesAPIError(status: status)
    }
}

public func deleteGenericPasswordKeychainItem(identifier: AGenericPasswordKeychainItemIdentifier) throws {
    let query = identifier.dictionary
    let status = SecItemDelete(query as CFDictionary)
    if status != noErr && status != errSecItemNotFound {
        throw AKeychainServicesAPIError(status: status)
    }
}
