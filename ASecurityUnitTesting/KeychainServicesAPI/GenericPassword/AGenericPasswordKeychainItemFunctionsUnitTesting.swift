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
    private var keychainItem: AGenericPasswordKeychainItem {
        let identifier = keychainItemIdentifier
        let keychainItem = AGenericPasswordKeychainItem(identifier: identifier)
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

        XCTAssert(createdKeychainItem?.identifier == creatingKeychainItem.identifier, "Created keychain item \(String(describing: createdKeychainItem)) is not equal to creating keychain item \(String(describing: createdKeychainItem))")
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

        XCTAssert(updatedKeychainItem?.data == updatingKeychainItem.data, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }

    func testUpdateLabel() {
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
        updatingKeychainItem.label = "label"

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

        XCTAssert(updatedKeychainItem?.label == updatingKeychainItem.label, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }

    func testUpdateComment() {
        do {
            try deleteGenericPasswordKeychainItem(identifier: keychainItemIdentifier)
        } catch {
            XCTAssert(false, "Keychain item deletion throws error \(error.localizedDescription).")
        }
        var updatingKeychainItem = keychainItem
        updatingKeychainItem.comment = "comment"
        do {
            try createGenericPasswordKeychainItem(updatingKeychainItem)
        } catch {
            XCTAssert(false, "Keychain item creation throws error \(error.localizedDescription).")
        }
        updatingKeychainItem.comment = "comment1"

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

        XCTAssert(updatedKeychainItem?.comment == updatingKeychainItem.comment, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }

    func testUpdateIsInvisible() {
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
        updatingKeychainItem.isInvisible = true

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

        XCTAssert(updatedKeychainItem?.isInvisible == updatingKeychainItem.isInvisible, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }

    func testUpdateIsNegative() {
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
        updatingKeychainItem.isNegative = true

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

        XCTAssert(updatedKeychainItem?.isNegative == updatingKeychainItem.isNegative, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }

    func testUpdateAccessible() {
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
        updatingKeychainItem.accessible = .afterFirstUnlock

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

        XCTAssert(updatedKeychainItem?.accessible == updatingKeychainItem.accessible, "Updated keychain item \(String(describing: updatedKeychainItem)) is not equal to updating keychain item \(String(describing: updatingKeychainItem))")
    }
    
    func test() {
        let service = "service"
        let account = "account"
        let accessGroup = "accessGroup"
        let keychainItemIdentifierTrue = AGenericPasswordKeychainItemIdentifier(service: service, account: account, accessGroup: accessGroup, isSynchronizable: true)
        let keychainItemIdentifierFalse = AGenericPasswordKeychainItemIdentifier(service: service, account: account, accessGroup: accessGroup, isSynchronizable: false)
        let trueData = Data([0x1, 0x1, 0x1, 0x1, 0x1])
        let keychainItemTrue = AGenericPasswordKeychainItem(identifier: keychainItemIdentifierTrue, data: trueData)
        let falseData = Data([0x2, 0x2, 0x2, 0x2, 0x2])
        let keychainItemFalse = AGenericPasswordKeychainItem(identifier: keychainItemIdentifierFalse, data: falseData)
        
        try? deleteGenericPasswordKeychainItem(identifier: keychainItemIdentifierTrue)
        try? deleteGenericPasswordKeychainItem(identifier: keychainItemIdentifierFalse)
        
        try? createGenericPasswordKeychainItem(keychainItemTrue)
        try? createGenericPasswordKeychainItem(keychainItemFalse)
        
        let kit = try? selectGenericPasswordKeychainItem(identifier: keychainItemIdentifierTrue)
        let kif = try? selectGenericPasswordKeychainItem(identifier: keychainItemIdentifierFalse)
        
        print(kit?.data == trueData)
        print(kif?.data == falseData)
    }

}
