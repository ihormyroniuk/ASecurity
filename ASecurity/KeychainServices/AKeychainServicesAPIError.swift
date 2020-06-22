//
//  AKeychainServicesAPIError.swift
//  ASecurity
//
//  Created by Ihor Myroniuk on 3/10/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

public struct AKeychainServicesAPIError: LocalizedError {
    let status: OSStatus

    public var errorDescription: String? {
        return "\(status) \(String(describing: SecCopyErrorMessageString(status, nil)))"
    }

    public var localizedDescription: String {
        return "\(status) \(String(describing: SecCopyErrorMessageString(status, nil)))"
    }
}
