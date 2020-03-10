//
//  AGenericPasswordKeychainItemUnitTesting.swift
//  ASecurityUnitTesting
//
//  Created by Ihor Myroniuk on 3/6/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import XCTest
@testable import ASecurity

class AGenericPasswordKeychainItemUnitTesting: XCTestCase {

    private let service = "service"
    private let account = "account"

    func testInitServiceAccount() {
        let keychainItem = AGenericPasswordKeychainItemIdentifier(service: service, account: account)

        let keychainItemDictionary = keychainItem.dictionary

        var expectedDictionary: [String: Any] = [:]
        expectedDictionary[kSecClass as String] = kSecClassGenericPassword
        expectedDictionary[kSecAttrService as String] = service
        expectedDictionary[kSecAttrAccount as String] = account
        XCTAssert(keychainItemDictionary == expectedDictionary, "Keychain item dictionary \(keychainItemDictionary) is not equal to expected dictionary \(expectedDictionary)`")
    }

}
