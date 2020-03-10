//
//  Helpers.swift
//  ASecurityUnitTesting
//
//  Created by Ihor Myroniuk on 3/6/20.
//  Copyright © 2020 ihormyroniuk. All rights reserved.
//

import Foundation

public func ==(lhs: [String: Any], rhs: [String: Any] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}
