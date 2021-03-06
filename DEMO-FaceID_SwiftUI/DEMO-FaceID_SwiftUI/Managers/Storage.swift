//
//  Storage.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 13.07.2021.
//

import Foundation

struct Storage {
    @UserDefault(key: .isFirstLaunch, defaultValue: true)
    var isFirstLaunch: Bool

    @UserDefault(key: .isInBackground, defaultValue: false)
    var isInBackground: Bool
}

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let key: Key
    let defaultValue: T

    var wrappedValue: T {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

protocol PropertyListValue {}
extension String: PropertyListValue {}
extension Bool: PropertyListValue {}

extension Key {
    static let isFirstLaunch: Key = "isFirstLaunch"
    static let isInBackground: Key = "isInBackground"
}


