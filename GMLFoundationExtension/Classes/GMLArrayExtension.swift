//
//  GMLArrayExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/8/1.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

public enum CGArrayError : Error {
    case index
}

public extension Array {
    func ml_toJSONString(encoding: String.Encoding = String.Encoding.utf8) throws -> String? {
        let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return String(data: data, encoding: .utf8)
    }
}

public extension Array {
    
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
    
    func ml_index(at obj: Any) -> Int? {
        guard let list = self as? [NSObjectProtocol] else {
            return nil
        }
        return list.firstIndex {
            return $0.isEqual(obj)
        }
    }
    
    mutating func ml_replace(_ obj: Element, replaceObj: Element) -> Element? {
        guard let index = ml_index(at: obj) else { return nil }
        replaceSubrange(index..<index+1, with: [replaceObj])
        return replaceObj
    }
    mutating func ml_replace(_ obj: Element, replaceCollection: [Element]) -> [Element]? {
        guard let index = ml_index(at: obj) else { return nil }
        replaceSubrange(index..<index+1, with: replaceCollection)
        return replaceCollection
    }
}

public extension Array where Element : Equatable {
    @discardableResult
    mutating func ml_remove(at obj: Element) -> Element? {
        guard self.contains(obj) else { return nil }
        for (index, targetObj) in self.enumerated() {
            if targetObj != obj {
                continue
            }
            return self.remove(at: index)
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
    
    func ml_index(at obj: Element) -> Index? {
        return self.firstIndex {
            return $0 == obj
        }
    }
}

