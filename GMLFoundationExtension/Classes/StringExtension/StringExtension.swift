//
//  StringExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation


/// 定义的一些常量字符串
public enum GMLConstantString : String {
    case space = " "
    case linebreak = "\n"
}

public extension String {
    
    /// 复制自身指定次数
    func copy(count: UInt) -> Self? {
        if count == 0 { return nil }
        if count == 1 { return self }
        var newStr = String()
        for _ in 0 ..< count {
            newStr += self
        }
        return newStr
    }
}
