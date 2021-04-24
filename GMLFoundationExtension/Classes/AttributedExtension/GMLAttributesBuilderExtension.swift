//
//  GMLAttributesBuilderExtension.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/30.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

//MARK:- NSParagraphStyle set
/// 设置段落属性内内容更方便
public extension GMLAttributesBuilder {
    func lineSpacing(_ lineSpacing: CGFloat) -> Self {
        paragraphStyle().lineSpacing = lineSpacing
        return self
    }
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        paragraphStyle().lineBreakMode = lineBreakMode
        return self
    }
    func alignment(_ alignment: NSTextAlignment) -> Self {
        paragraphStyle().alignment = alignment
        return self
    }
    
#if os(iOS)
    /// 设置段落行间距，并减去 UIFont 的 lineHeight - pointSize 的值，如果没有则与 lineSpacing() 相同
    /// - Parameter lineSpacing: 行间距
    func lineSpacingMinus(_ lineSpacing: CGFloat) -> Self {
        guard let font = currentContainer().get()[.font] as? GMLFont else {
            return self.lineSpacing(lineSpacing)
        }
        paragraphStyle().lineSpacing = lineSpacing - (font.lineHeight - font.pointSize)
        return self
    }
#endif
    
    /// 获取段落，没有就创建
    private func paragraphStyle<T: NSMutableParagraphStyle>() -> T {
        let paragraphStyleKey : GMLAttributesKey = .paragraphStyle
        
        func update(style: T) -> T {
            currentContainer().set(paragraphStyleKey, style)
            return style
        }
        if let style = currentContainer().get()[paragraphStyleKey] as? NSParagraphStyle {
            if let mStyle = style as? NSMutableParagraphStyle {
                return mStyle as! T
            }
            return update(style: style.mutableCopy() as! T)
        }
        return update(style: NSParagraphStyle.default.mutableCopy() as! T)
    }
}

//MARK:- Font/Color set
public extension GMLAttributesBuilder {
    
    func font(ofSize size: CGFloat, weight: GMLFontWeight = .regular) -> Self {
        return font(GMLFont.ml_font(ofSize: size, weight: weight))
    }
    
    func foregroundColor(_ hex: Int) -> Self {
        return foregroundColor(GMLColor(hex))
    }
    func backgroundColor(_ hex: Int) -> Self {
        return backgroundColor(GMLColor(hex))
    }
}


