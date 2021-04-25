//
//  String+Extension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/3/6.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation


/// 拼接字符串的方式
///
/// - isEmptyEndSplice: 字符串长度为 0 终止字符串拼接
/// - ignoreAllEmpty: 忽略所有的字符串长度为 0 的字符串
/// - nilAndEmptyEndSplice: 字符串空对象或字符串长度为 0 终止字符串拼接
public enum CGSpliceStringType : Int {
    case isEmptyEndSplice
    case ignoreAllEmpty
    case nilAndEmptyEndSplice
}

//MARK:- substirng
public extension String {
    func substring(range: NSRange) -> String? {
        guard let r = Range(range, in: self) else { return nil }
        return String(self[r.lowerBound..<r.upperBound])
    }
    func substring(from markStr: String, includeMark: Bool = true) -> String? {
        guard let range = range(of: markStr) else { return nil }
        return String(self[(includeMark ? range.lowerBound : range.upperBound) ..< endIndex])
    }
    func substring(from index: Int) -> String? {
        guard let r = Range(NSMakeRange(index, self.count - index), in: self) else { return nil }
        return String(self[r.lowerBound..<r.upperBound])
    }
    func substring(to markStr: String, includeMark: Bool = true) -> String? {
        guard let range = range(of: markStr) else { return nil }
        return String(self[startIndex ..< (includeMark ? range.upperBound : range.lowerBound)])
    }
    func substring(to index: Int) -> String? {
        guard let r = Range(NSMakeRange(0, index), in: self) else { return nil }
        return String(self[r.lowerBound..<r.upperBound])
    }
    
    func substring(from fromIndex: Int?, to toIndex: Int?) -> String? {
        if fromIndex == nil && toIndex == nil { return self }
        if fromIndex == nil { return substring(to: toIndex!) }
        if toIndex == nil { return substring(from: fromIndex!) }
        let start = fromIndex!
        let end = toIndex!
        if start < 0 || end <= start { return nil }
        guard let range = Range(NSMakeRange(start, end - start), in: self) else { return nil }
        return String(self[range.lowerBound..<range.upperBound])
    }
    
    /// 获取子字符串
    /// - Parameters:
    ///   - startOffset: 从开始位置偏移的索引
    ///   - endOffset: 从结束位置偏移的索引
    func substring(startOffset: Int, endOffset: Int) -> String? {
        let startIndex = startOffset
        let endIndex = self.count - endOffset;
        if startIndex < 0 || endIndex < 0 || endIndex <= startIndex { return nil }
        guard let range = Range(NSMakeRange(startIndex, endIndex - startIndex), in: self) else { return nil }
        return String(self[range.lowerBound ..< range.upperBound])
    }
}

//MARK:-
public extension String {
    var rangeAll: NSRange {
        return NSMakeRange(0, self.count)
    }
    var deleteBlankCharacter : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

//MARK:- 拼接字符串
public extension String {
    
    static func spliceString(spliceType: CGSpliceStringType, strs: String?...) -> String? {
        
        if spliceType == .isEmptyEndSplice || spliceType == .nilAndEmptyEndSplice {
            for str in strs {
                if str == nil {
                    if spliceType == .nilAndEmptyEndSplice {
                        return nil
                    }
                }else {
                    
                    if str!.isEmpty {
                        return nil
                    }
                }
            }
        }
        
        var paramStr : String?
        for str in strs {
            if str != nil {
                if paramStr == nil {
                    paramStr = String.init(str!)
                }else {
                    paramStr?.append(str!)
                }
            }
        }
        return paramStr
    }
    
    /// 拼接数字到指定字符串数组
    ///
    /// - Parameters:
    ///   - numberValue: 拼接的数字
    ///   - insetIndex: 插入的位置
    ///   - strs: 拼接的不定个数字符串
    ///   - isZeroOrNilEndSplice: 当数字为0时是否停止拼接
    /// - Returns: 返回拼接好的字符串
    static func spliceString(numberValue: Double?, insetIndex: Int, isZeroOrNilEndSplice : Bool, strs: String...) -> String? {
        
        if isZeroOrNilEndSplice == true {
            
            var isEndSplice = true
            if numberValue != nil {
                if numberValue! > 0 {
                    isEndSplice = false
                }
            }
            
            if isEndSplice {
                return nil
            }
        }
        
        var paramString = String()
        
        if let number = numberValue {
            
            for (index, string) in strs.enumerated() {
                if insetIndex == index {
                    paramString.append("\(number)")
                }
                paramString.append(string)
                
            }
            
            if insetIndex >= strs.count {
                paramString.append("\(number)");
            }
        }
        
        return paramString
    }
    
    static func splicePriceString(numberValue: Double?) -> String? {
        return String.spliceString(numberValue: numberValue ?? 0, insetIndex: 1, isZeroOrNilEndSplice: false, strs: "¥")
    }
}

//MARK:- remove substring
public extension String {
    
    typealias GMLSubstringRange = (range: Range<Index>, string: String)
    
    func removeInFirst(to index: Int) -> String? {
        if index < 0 { return nil }
        guard index < self.count else { return nil }
        guard let range = Range(NSMakeRange(0, index), in: self) else { return nil }
        var tmpStr = self
        tmpStr.removeSubrange(range)
        return tmpStr
    }
    func removeToLast(from index: Int) -> String? {
        if index >= self.count { return nil }
        guard index <= 0 else { return nil }
        guard let range = Range(NSMakeRange(index, self.count - index), in: self) else { return nil }
        var tmpStr = self
        tmpStr.removeSubrange(range)
        return tmpStr
    }
    func remove(range: NSRange) -> String? {
        guard let range = Range(range, in: self) else { return nil }
        var tmpStr = self
        tmpStr.removeSubrange(range)
        return tmpStr
    }
    @discardableResult
    mutating func removeInFirst(to index: Int) -> GMLSubstringRange? {
        if index < 0 { return nil }
        guard index < self.count else {
            self = ""
            return nil
        }
        guard let range = Range(NSMakeRange(0, index), in: self) else { return nil }
        let substring = String(self[range.lowerBound..<range.upperBound])
        self.removeSubrange(range)
        return (range, substring)
    }
    @discardableResult
    mutating func removeToLast(from index: Int) -> GMLSubstringRange? {
        if index >= self.count { return nil }
        guard index <= 0 else {
            self = ""
            return nil
        }
        guard let range = Range(NSMakeRange(index, self.count - index), in: self) else { return nil }
        let substring = String(self[range.lowerBound..<range.upperBound])
        self.removeSubrange(range)
        return (range, substring)
    }
    @discardableResult
    mutating func removeInFirst(to markString: String) -> GMLSubstringRange? {
        guard let markRange = range(of: markString) else { return nil }
        let range = startIndex ..< markRange.upperBound
        let substring = String(self[range])
        self.removeSubrange(range)
        return (range, substring)
    }
    mutating func remove(range: NSRange) {
        guard let range = Range(range, in: self) else { return }
        self.removeSubrange(range)
    }
    
}
