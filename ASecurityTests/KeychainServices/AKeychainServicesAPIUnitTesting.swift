//
//  AKeychainServicesAPIUnitTesting.swift
//  ASecurityTests
//
//  Created by Ihor Myroniuk on 2/20/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import XCTest
@testable import ASecurity

class AKeychainServicesAPIUnitTesting: XCTestCase {

    // MARK: Data

    private let item: KeychainItem = {
        let `class` = KeychainItemClassValue.genericPassword
        let service = "service"
        let account = "account"
        let item = createKeychainItem(class: `class`, service: service, account: account)
        return item
    }()

    private let dataNil: Data? = nil

    private let data1: Data? = {
        let bytes: [UInt8] = [0x26, 0x54, 0x43, 0x51]
        let data = Data(bytes)
        return data
    }()

    private let data2: Data? = {
        let bytes: [UInt8] = [0x50, 0x09, 0x67, 0x43, 0x04]
        let data = Data(bytes)
        return data
    }()

    // MARK: Tests

    func testDataNil() {
        let item = self.item
        let dataNil: Data? = nil

        try? setKeychainItemData(item, data: dataNil)
        let itemData = try? getKeychainItemData(item, matchLimit: .one, returnData: true)

        XCTAssert(dataNil == itemData, "Set data \(String(describing: dataNil)) is not equal to get data \(String(describing: itemData))`")
    }

    func testData1() {
        let item = self.item
        let data1 = self.data1

        try? setKeychainItemData(item, data: data1)
        let itemData = try? getKeychainItemData(item, matchLimit: .one, returnData: true)

        XCTAssert(data1 == itemData, "Set data \(String(describing: data1)) is not equal to get data \(String(describing: itemData))`")
    }

    func testDataNilData1() {
        let item = self.item
        let dataNil = self.dataNil
        let data1 = self.data1

        try? setKeychainItemData(item, data: dataNil)
        try? setKeychainItemData(item, data: data1)
        let itemData = try? getKeychainItemData(item, matchLimit: .one, returnData: true)

        XCTAssert(data1 == itemData, "Set data \(String(describing: data1)) is not equal to get data \(String(describing: itemData))`")
    }

    func testData1DataNil() {
        let item = self.item
        let data1 = self.data1
        let dataNil = self.dataNil

        try? setKeychainItemData(item, data: data1)
        try? setKeychainItemData(item, data: dataNil)
        let itemData = try? getKeychainItemData(item, matchLimit: .one, returnData: true)

        XCTAssert(dataNil == itemData, "Set data \(String(describing: dataNil)) is not equal to get data \(String(describing: itemData))`")
    }

    func testData2Data1() {
        let item = self.item
        let data2 = self.dataNil
        let data1 = self.data1

        try? setKeychainItemData(item, data: data2)
        try? setKeychainItemData(item, data: data1)
        let itemData = try? getKeychainItemData(item, matchLimit: .one, returnData: true)

        XCTAssert(data1 == itemData, "Set data \(String(describing: data1)) is not equal to get data \(String(describing: itemData))`")
    }

    func testClass() {
        let `class` = KeychainItemClassValue.genericPassword
        let expectedClass = kSecClassGenericPassword
        let service = "service"
        let account = "account"

        let item = createKeychainItem(class: `class`, service: service, account: account)
        let itemClass = item[kSecClass as String] as AnyObject as! CFString

        XCTAssert(expectedClass == itemClass, "Set class \(`class`) is not equal to item class \(String(describing: itemClass))`")
    }

    func testService() {
        let `class` = KeychainItemClassValue.genericPassword
        let service = "service"
        let account = "account"

        let item = createKeychainItem(class: `class`, service: service, account: account)
        let itemService = item[kSecAttrService as String] as? String

        XCTAssert(service == itemService, "Set service \(service) is not equal to item service \(String(describing: itemService))`")
    }

    func testAccount() {
        let `class` = KeychainItemClassValue.genericPassword
        let service = "service"
        let account = "account"

        let item = createKeychainItem(class: `class`, service: service, account: account)
        let itemAccount = item[kSecAttrAccount as String] as? String

        XCTAssert(account == itemAccount, "Set account \(account) is not equal to item account \(String(describing: itemAccount))`")
    }

}
