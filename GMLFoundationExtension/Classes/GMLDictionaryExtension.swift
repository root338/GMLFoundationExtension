//
// Created by apple on 2018/8/13.
// Copyright (c) 2018 ym. All rights reserved.
//

import Foundation

extension Dictionary {
    func ml_toJSONString(encoding: String.Encoding = String.Encoding.utf8) throws -> String? {
        let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary where Key : Hashable {
    
    /// 追加 Dictionary 数据
    @discardableResult
    mutating func ml_append(dict: [Key : Value]) -> [Key : Value]? {
        var didAddValue = [Key : Value]()
        for (key, value) in dict {
            if let addValue = self.updateValue(value, forKey: key) {
                didAddValue[key] = addValue
            }
        }
        return didAddValue.count == 0 ? nil : didAddValue
    }
    func ml_splice(dict: [Key : Value]) -> Self {
        var newValue = self
        for (key, value) in dict {
            newValue.updateValue(value, forKey: key)
        }
        return newValue
    }
}
