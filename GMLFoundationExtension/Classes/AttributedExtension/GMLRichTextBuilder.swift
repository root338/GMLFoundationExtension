//
//  GMLRichTextBuilder.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/30.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

public typealias GMLAttributedAppendCallback = ((NSMutableAttributedString) -> Void)

/// 富文本构建器
public class GMLRichTextBuilder: NSObject {
    
    var defaultAttributes: GMLAttributesSet?
    private lazy var attributedStringStack = [NSMutableAttributedString]()
}
//MARK:- 对容器进行操作
public extension GMLRichTextBuilder {
    /// 压入一个新的富文本
    func push(_ text: String, attributes: GMLAttributesSet? = nil) -> Self {
        attributedStringStack.append(NSMutableAttributedString(string: text, attributes: append(attributes)))
        return self
    }
    /// 弹出最后一个富文本
    func popLast() -> NSMutableAttributedString? {
        return attributedStringStack.popLast()
    }
    /// 获取最后一个富文本
    var last: NSMutableAttributedString? {
        return attributedStringStack.last
    }
    /// 当前指定的富文本
    var currentAtt: NSMutableAttributedString? {
        return attributedStringStack.last
    }
}
//MARK:- 对指定富文本进行操作
public extension GMLRichTextBuilder {
    //MARK:- 富文本修改
    
    func append(_ att: NSAttributedString) -> Self {
        currentAttributedString().append(att)
        return self
    }
    
    /// 对当前富文本追加新的富文本
    /// - Parameters:
    ///   - text: 添加的文本
    ///   - attributes: 设置的属性
    ///   - didAddConfig: 已经添加回调，传入的是新添加的富文本
    func append(_ text: String?, attributes: GMLAttributesSet? = nil, didAddCallback: GMLAttributedAppendCallback? = nil) -> Self {
        guard let string = text else {
            return self
        }
        let newAtt = NSMutableAttributedString(string: string, attributes: append(attributes))
        currentAttributedString().append(newAtt)
        didAddCallback?(newAtt)
        return self
    }
    /// 添加预定义的常量字符串
    /// - Parameters:
    ///   - str: 预定义的常量字符串
    ///   - count: 添加的个数
    func append(_ str: GMLConstantString, count : UInt = 1, attributes: GMLAttributesSet? = nil, didAddCallback: GMLAttributedAppendCallback? = nil) -> Self {
        guard let appendStr = str.rawValue.copy(count: count) else {
            return self
        }
        return append(appendStr, attributes: attributes, didAddCallback: didAddCallback)
    }
    
    func insert(_ att: NSAttributedString, at location: Int) -> Self {
        currentAttributedString().insert(att, at: location)
        return self
    }
    func insert(_ text: String?, attributes: GMLAttributesSet? = nil, at location: Int, didAddCallback: GMLAttributedAppendCallback? = nil) -> Self {
        guard let string = text else {
            return self
        }
        let newAtt = NSMutableAttributedString(string: string, attributes: append(attributes))
        currentAttributedString().insert(newAtt, at: location)
        didAddCallback?(newAtt)
        return self
    }
    
    //MARK:- 富文本属性修改
    /// 对当前富文本添加属性
    func add(attributes: GMLAttributesSet) -> Self {
        return add(attributes: attributes, range: NSRange(location: 0, length: currentAttributedString().length))
    }
    /// 对当前富文本指定区域添加属性
    func add(attributes: GMLAttributesSet, range: NSRange) -> Self {
        currentAttributedString().addAttributes(attributes, range: range)
        return self
    }
}

//MARK:- 获取富文本信息
public extension GMLRichTextBuilder {
    /// 获取最后一个字符的富文本属性
    func lastAttributes() -> GMLAttributesSet? {
        guard let targetAtt = currentAtt else {
            return nil
        }
        if let att = currentAtt, let location = att.ml_lastLocation {
            return targetAtt.attributes(at: location, effectiveRange: nil)
        }
        return nil
    }
    
//    func attributes(range: NSRange) -> GMLAttributesSet? {
//
//        currentAttributedString().attributes(at: <#T##Int#>, effectiveRange: NSRangePointer?)
//    }
}

extension GMLRichTextBuilder {
    func currentAttributedString() -> NSMutableAttributedString {
        if attributedStringStack.count == 0 {
            attributedStringStack.append(NSMutableAttributedString())
        }
        return attributedStringStack.last!
    }
    
}

private extension GMLRichTextBuilder {
    func append(_ attributes: GMLAttributesSet?) -> GMLAttributesSet? {
        if let a = attributes, let defaultA = defaultAttributes {
            return defaultA.ml_splice(dict: a)
        }
        return attributes != nil ? attributes : defaultAttributes
    }
}
