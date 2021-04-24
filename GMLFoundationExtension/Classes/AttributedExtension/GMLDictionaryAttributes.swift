//
//  GMLDictionaryAttributes.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

public extension Dictionary {
    static func container() -> (set: (Key, Value) -> Void, get: () -> [Key : Value]) {
        var dict = [Key : Value]()
        func set(key: Key, value: Value) {
            dict[key] = value
        }
        func get() -> [Key : Value] {
            return dict
        }
        return (set(key:value:), get)
    }
}
