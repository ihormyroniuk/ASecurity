//
//  AGenericPasswordKeychainItemFunctionsUnitTesting.swift
//  ASecurityUnitTesting
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import XCTest
@testable import ASecurity

class AGenericPasswordKeychainItemFunctionsUnitTesting: XCTestCase {

    private let service = "service1f"
    private let account = "account1f"
    private var keychainItemIdentifier: AGenericPasswordKeychainItemIdentifier {
        let keychainItemIdentifier = AGenericPasswordKeychainItemIdentifier(service: service, account: account)
        return keychainItemIdentifier
    }

    private let accessGroup = "accessGroup"
    private let data: Data = Data([0x75, 0x43, 0x52, 0x54])
    private var keychainItem: AGenericPasswordKeychainItem {
        let identifier = keychainItemIdentifier
        let keychainItem = AGenericPasswordKeychainItem(identifier: identifier, accessGroup: accessGroup, data: data)
        return keychainItem
    }

    func testCreate() {
        do {
            try createGenericPasswordKeychainItem(keychainItem)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }
        do {
            let keychainItem = try selectGenericPasswordKeychainItem(identifier: keychainItemIdentifier)
            print("sdf")
        } catch {
            XCTAssert(false, "Keychain item selection throws error \(error).")
        }
    }

}
