//
//  GMLArrayExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/8/1.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

/// 扩展数组方法的错误信息
public enum CGArrayError : Error {
    /// 索引越界
    case index
    /// 类型不支持
    case typeNoSupport(message: String)
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
    
    /// 获取指定对象在数组中的位置
    /// 注意：仅对实现 NSObjectProtocol 协议的对象进行处理
    /// - Parameter obj: 指定对象, swift 中有些支持桥接所以使用 Any 类型
    /// - Throws: 不支持类型数组报 CGArrayError.typeNoSupport(message:) 异常
    func ml_index(at obj: Any) throws -> Int? {
        guard let list = self as? [NSObjectProtocol] else {
            throw CGArrayError.typeNoSupport(message: "请使用 firstIndex(where:) 自定义实现")
        }
        return list.firstIndex {
            return $0.isEqual(obj)
        }
    }
    
    /// 替换数组中指定对象
    /// - Throws: 返回 ml_index(at:) 方法异常
    @discardableResult
    mutating func ml_replace(_ obj: Element, replaceObj: Element) throws -> Element? {
        guard let index = try ml_index(at: obj) else { return nil }
        replaceSubrange(index..<index+1, with: [replaceObj])
        return replaceObj
    }
    
    /// 替换数组中指定对象
    /// - Parameters:
    ///   - obj: 数组中的要被替换的对象
    ///   - replaceCollection: 替换的对象
    /// - Throws: 返回 ml_index(at:) 方法异常
    @discardableResult
    mutating func ml_replace(_ obj: Element, replaceCollection: [Element]) throws -> [Element]? {
        guard let index = try ml_index(at: obj) else { return nil }
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
    
    /// 获取数组对象位置
    /// 请直接使用 firstIndex(of:)
    func ml_index(at obj: Element) -> Int? {
        return firstIndex(of: obj)
    }
}

