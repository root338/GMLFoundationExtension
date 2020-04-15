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
enum CGSpliceStringType : Int {
    case isEmptyEndSplice
    case ignoreAllEmpty
    case nilAndEmptyEndSplice
}

//enum CGSpliceNumberStringType : Int {
//    case
//}

//MARK:- 拼接字符串
extension String {
    
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
