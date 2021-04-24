//
//  ColorExtension.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/6/1.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


#if os(iOS)
public typealias GMLColor = UIColor
#elseif os(OSX)
public typealias GMLColor = NSColor
#endif

public extension GMLColor {
    
    /// 十六进制的 ARGB 值生成颜色
    /// - Parameter hex: 十六进制 ARGB 值 例如: 0xFFFFFF
    convenience init(_ hex: Int) {
        
        let maxValue : CGFloat = 255.0
        
        let alpha = hex > 0x01000000 ? (CGFloat(hex >> 24) / maxValue)  : 1
        let red = CGFloat(hex >> 16 & 0xFF) / maxValue
        let green = CGFloat(hex >> 8 & 0xFF) / maxValue
        let blue = CGFloat(hex & 0xFF) / maxValue
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
