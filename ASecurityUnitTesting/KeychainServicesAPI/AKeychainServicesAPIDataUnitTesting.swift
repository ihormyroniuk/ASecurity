//
//  AKeychainServicesAPIDataUnitTesting.swift
//  ASecurityUnitTesting
//
//  Created by Ihor Myroniuk on 2/25/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import XCTest
@testable import ASecurity

class AKeychainServicesAPIDataUnitTesting: XCTestCase {
    
    private let genericPasswordKeychainItemIdentifier: AGenericPasswordKeychainItemIdentifier = {
        let service = "service"
        let account = "account"
        let item = AGenericPasswordKeychainItemIdentifier(service: service, account: account)
        return item
    }()

    private let dataNil: Data? = nil

    private let data1: Data = {
        let bytes: [UInt8] = [0x26, 0x54, 0x43, 0x51]
        let data = Data(bytes)
        return data
    }()

    private let data2: Data = {
        let bytes: [UInt8] = [0x50, 0x09, 0x67, 0x43, 0x04]
        let data = Data(bytes)
        return data
    }()

//    func testGenericPasswordKeychainItemSetData1() {
//        let keychainItem = self.genericPasswordKeychainItemIdentifier
//        let data = self.data1
//
//        do {
//            try setKeychainItemData(genericPasswordKeychainItemIdentifier, data: data)
//        } catch {
//            XCTAssert(false, "Set keychain item data throws error")
//        }
//        let itemData = try? selectGenericPasswordKeychainItem(identifier: keychainItem)
//
//        XCTAssert(true)
//        //XCTAssert(data == itemData, "Set data \(data) is not equal to get data \(String(describing: itemData))")
//    }

//    func testGenericPasswordKeychainItemSetData1DataNil() {
//        let keychainItem = self.genericPasswordKeychainItemIdentifier
//        let data1 = self.data1
//        let dataNil = self.dataNil
//
//        do {
//            try setKeychainItemData(genericPasswordKeychainItemIdentifier, data: data1)
//        } catch {
//            XCTAssert(false, "Set keychain item data throws error")
//        }
//        do {
//            try setKeychainItemData(genericPasswordKeychainItemIdentifier, data: dataNil)
//        } catch {
//            XCTAssert(false, "Set keychain item data throws error")
//        }
//        let itemData = try? getGenericPasswordKeychainItem(keychainItem)
//
//        XCTAssert(dataNil == itemData, "Set data \(String(describing: dataNil)) is not equal to get data \(String(describing: itemData))")
//    }
//
//    func testGenericPasswordKeychainItemSetData1Data2() {
//        let keychainItem = self.genericPasswordKeychainItemIdentifier
//        let data1 = self.data1
//        let data2 = self.data2
//
//        do {
//            try setKeychainItemData(genericPasswordKeychainItemIdentifier, data: data1)
//        } catch {
//            XCTAssert(false, "Set keychain item data throws error")
//        }
//        do {
//            try setKeychainItemData(genericPasswordKeychainItemIdentifier, data: data2)
//        } catch {
//            XCTAssert(false, "Set keychain item data throws error")
//        }
//        let itemData = try? getGenericPasswordKeychainItem(keychainItem)
//
//        XCTAssert(data2 == itemData, "Set data \(data2) is not equal to get data \(String(describing: itemData))")
//    }

}
