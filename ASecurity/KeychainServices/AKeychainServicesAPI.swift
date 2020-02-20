//
//  AKeychainServicesAPI.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 2/20/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

// MARK: Item

public typealias KeychainItem = [String: Any]

public enum KeychainItemClassValue {
    case genericPassword
}

public func createKeychainItem(class: KeychainItemClassValue, service: String, account: String) -> [String: Any] {
    var item = [String: Any]()
    item[kSecClass as String] = `class`.cfString
    item[kSecAttrService as String] = service
    item[kSecAttrAccount as String] = account
    return item
}

// MARK: Errors

public struct JCPKeychainServicesAPIError: Error {
    let status: OSStatus
}

// MARK: Setting Getting

public func setKeychainItemData(_ item: KeychainItem, data: Data?) throws {
    let query = item
    guard let data = data else {
        let status = SecItemDelete(query as CFDictionary)
        if status != noErr && status != errSecItemNotFound {
            throw JCPKeychainServicesAPIError(status: status)
        }
        return
    }
    var attributesToUpdate = [String: AnyObject]()
    attributesToUpdate[kSecValueData as String] = data as AnyObject?
    let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    if status == errSecItemNotFound {
        var attributes = item
        attributes[kSecValueData as String] = data
        let status = SecItemAdd(attributes as CFDictionary, nil)
        if status != noErr {
             throw JCPKeychainServicesAPIError(status: status)
        }
    } else if status != noErr {
        throw JCPKeychainServicesAPIError(status: status)
    }
}

public enum KeychainItemMatchLimit {
    case one
}

public func getKeychainItemData(_ item: KeychainItem, matchLimit: KeychainItemMatchLimit, returnData: Bool) throws -> Data? {
    var query = item
    query[kSecMatchLimit as String] = matchLimit.cfString
    query[kSecReturnData as String] = returnData.cfBoolean
    var result: AnyObject?
    let status = withUnsafeMutablePointer(to: &result) {
        SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }
    if status == noErr {
        let data = result as? Data
        return data
    } else if status == errSecItemNotFound {
        return nil
    } else {
        throw JCPKeychainServicesAPIError(status: status)
    }
}

// MARK: Helpers

private extension KeychainItemClassValue {
    var cfString: CFString {
        switch self {
        case .genericPassword:
            return kSecClassGenericPassword
        }
    }
}

private extension KeychainItemMatchLimit {
    var cfString: CFString {
        switch self {
        case .one:
            return kSecMatchLimitOne
        }
    }
}

private extension Bool {

    var cfBoolean: CFBoolean {
        return self ? kCFBooleanTrue : kCFBooleanFalse
    }

}
