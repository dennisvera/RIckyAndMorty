//
//  Helper.swift
//  RMUIChallenge
//
//  Copyright © 2020 com.adt.myadtmobileenterprise. All rights reserved.
//

import Foundation

struct Helper {
  
  // MARK: - Helper Methods
  
  static func set<T: RawRepresentable>(with str: String?) -> T? where T.RawValue == String {
    guard let rawValue = str, let value = T(rawValue: rawValue) else { return nil }
    return value
  }
}
