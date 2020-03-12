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

    private let service = "service"
    private let account = "account"
    private let accessGroup = "accessGroup"
    private var keychainItemIdentifier: AGenericPasswordKeychainItemIdentifier {
        let keychainItemIdentifier = AGenericPasswordKeychainItemIdentifier(service: service, account: account, accessGroup: accessGroup, isSynchronizable: true)
        return keychainItemIdentifier
    }

    private let data: Data = Data([0x75, 0x43, 0x52, 0x54])
    private var keychainItem: AGenericPasswordKeychainItem {
        let identifier = keychainItemIdentifier
        let keychainItem = AGenericPasswordKeychainItem(identifier: identifier, data: data)
        return keychainItem
    }

    func testCreate() {
        do {
            try deleteGenericPasswordKeychainItem(identifier: keychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item deletion throws error \(error.localizedDescription).")
        }
        let creatingKeychainItem = keychainItem

        do {
            try createGenericPasswordKeychainItem(creatingKeychainItem)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }
        let createdKeychainItemIdentifier = creatingKeychainItem.identifier
        var createdKeychainItem: AGenericPasswordKeychainItem? = nil
        do {
            createdKeychainItem = try selectGenericPasswordKeychainItem(identifier: createdKeychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item selection throws error \(error.localizedDescription).")
        }

        XCTAssert(createdKeychainItem == creatingKeychainItem, "Created keychain item \(String(describing: createdKeychainItem)) is not equal to creating keychain item \(String(describing: createdKeychainItem))")
    }

    func testUpdateData() {
        do {
            try deleteGenericPasswordKeychainItem(identifier: keychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item deletion throws error \(error.localizedDescription).")
        }
        var updatingKeychainItem = keychainItem
        do {
            try createGenericPasswordKeychainItem(updatingKeychainItem)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }
        updatingKeychainItem.data = Data([0x43, 0x34])

        do {
            try updateGenericPasswordKeychainItem(updatingKeychainItem)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }
        let updatedKeychainItemIdentifier = updatingKeychainItem.identifier
        var updatedKeychainItem: AGenericPasswordKeychainItem? = nil
        do {
            updatedKeychainItem = try selectGenericPasswordKeychainItem(identifier: updatedKeychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item selection throws error \(error.localizedDescription).")
        }

        XCTAssert(updatedKeychainItem == updatingKeychainItem, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }

    func testDelete() {
        do {
            try deleteGenericPasswordKeychainItem(identifier: keychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item deletion throws error \(error.localizedDescription).")
        }
        let deletingKeychainItem = keychainItem
        do {
            try createGenericPasswordKeychainItem(deletingKeychainItem)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }

        let deletedGenericPasswordKeychainItemIdentifier = deletingKeychainItem.identifier
        do {
            try deleteGenericPasswordKeychainItem(identifier: deletedGenericPasswordKeychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }
        let deletedKeychainItemIdentifier = deletingKeychainItem.identifier
        var deletedKeychainItem: AGenericPasswordKeychainItem? = nil
        do {
            deletedKeychainItem = try selectGenericPasswordKeychainItem(identifier: deletedKeychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item selection throws error \(error.localizedDescription).")
        }

        XCTAssert(deletedKeychainItem == nil, "Deleted keychain item \(String(describing: deletedKeychainItem)) is not deleted")
    }

}
