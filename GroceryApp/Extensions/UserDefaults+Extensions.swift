//
//  UserDefaults+Extensions.swift
//  GroceryApp
//
//  Created by Brenda Saavedra Cantu on 22/06/23.
//

import Foundation

extension UserDefaults {
    var userId: UUID? {
        get {
            guard let userIdAsString = string(forKey: Constants.Defaults.userId) else {
                return nil
            }
            return UUID(uuidString: userIdAsString)
        }
        
        set {
            set(newValue?.uuidString, forKey: Constants.Defaults.userId)
        }
    }
}
