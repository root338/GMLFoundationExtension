//
//  GMLArrayExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/8/1.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

enum CGArrayError : Error {
    case index
    
}

extension Array {
    func ml_toJSONString(encoding: String.Encoding = String.Encoding.utf8) throws -> String? {
        let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return String(data: data, encoding: .utf8)
    }
}

extension Array {
    
    func subarray(startIndex: Int, endIndex: Int) throws -> Array {
        guard startIndex < self.count else {
            throw CGArrayError.index
        }
        guard startIndex <= endIndex else {
            throw CGArrayError.index
        }
        
        return Array(self[startIndex..<endIndex])
    }
    
    func subarray(range: NSRange) throws -> Array {
        
        return try self.subarray(startIndex: range.location, endIndex: range.location + range.length)
    }
}

extension Array where Element : Equatable {
    @discardableResult
    mutating func ml_remove(at obj: Element) -> Element? {
        
        if self.contains(obj) {
            for (index, targetObj) in self.enumerated() {
                if targetObj == obj {
                    return self.remove(at: index)
                }
            }
        }
        return nil
    }
    
    @discardableResult
    mutating func ml_remove(at subarray: [Element]) -> [Element] {
        var removeObjs = [Element]()
        for obj in subarray {
            if let removeObj = ml_remove(at: obj) {
                removeObjs.append(removeObj)
            }
        }
        return removeObjs
    }
}
