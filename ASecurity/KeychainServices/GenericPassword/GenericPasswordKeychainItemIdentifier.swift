import Foundation
import Security

public struct GenericPasswordKeychainItemIdentifier: Equatable, Hashable {

    private let service: String
    private let account: String
    private let accessGroup: String?
    private let isSynchronizable: Bool?

    public init(service: String, account: String, accessGroup: String?, isSynchronizable: Bool?) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
        self.isSynchronizable = isSynchronizable
    }

    // MARK: Keychain Item

    init?(dictionary: [String: Any]) {
        guard let service = dictionary[kSecAttrService as String] as? String else { return nil }
        guard let account = dictionary[kSecAttrAccount as String] as? String else { return nil }
        let accessGroup = dictionary[kSecAttrAccessGroup as String] as? String
        let isSynchronizable = dictionary[kSecAttrSynchronizable as String] as? Bool
        self.init(service: service, account: account, accessGroup: accessGroup, isSynchronizable: isSynchronizable)
    }

    var dictionary: [String: Any] {
        var dictionary = [String: Any]()
        dictionary[kSecClass as String] = kSecClassGenericPassword as String
        dictionary[kSecAttrService as String] = service
        dictionary[kSecAttrAccount as String] = account
        dictionary[kSecAttrAccessGroup as String] = accessGroup
        dictionary[kSecAttrSynchronizable as String] = isSynchronizable
        return dictionary
    }

}
