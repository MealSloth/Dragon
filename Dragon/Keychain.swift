//
//  Keychain.swift
//  Dragon
//
//  Created by Michael Fourre on 8/30/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

struct Keychain {
    @discardableResult
    static func set<T>(value: T?, key: String?) -> Bool {
        var value = value
        return self.set(Data(buffer: UnsafeBufferPointer(start: &value, count: 1)), key: self.key(key))
    }
    
    @discardableResult
    static func unset(key: String?) -> Bool {
        return self.unset(self.key(key))
    }
    
    static func get<T>(key: String?) -> T? {
        return self.get(self.key(key))?.withUnsafeBytes({ $0.pointee })
    }
    
    private static func key(_ key: String?) -> String? {
        guard let key = key else { return nil }
        return "com.mealsloth.dragon:\(key)"
    }
    
    @discardableResult
    private static func set(_ data: Data?, key: String?) -> Bool {
        guard let data = data, let account = key else { return self.unset(key) }
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            ] as CFDictionary
        SecItemDelete(query)
        return SecItemAdd(query, nil) == noErr
    }
    
    @discardableResult
    private static func unset(_ key: String?) -> Bool {
        guard let account = key else { return false }
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            ] as CFDictionary
        return SecItemDelete(query) == noErr
    }
    
    private static func get(_ key: String?) -> Data? {
        guard let account = key else { return nil }
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            ] as CFDictionary
        var dataTypeRef: AnyObject?
        SecItemCopyMatching(query, &dataTypeRef)
        return dataTypeRef as? Data
    }
}
