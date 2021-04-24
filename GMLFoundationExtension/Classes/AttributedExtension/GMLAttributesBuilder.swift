//
//  GMLAttributesBuilder.swift
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

/**
 * 富文本属性构建器
 * 为了不必再写多余的key值而冗余代码，使属性创建更简单
 */
public class GMLAttributesBuilder: NSObject {
    /// 默认属性，会自动添加到结果属性
    var attributes: GMLAttributesSet?
    private lazy var stack = [GMLAttributesContainer]()
    
    /**
     * 指定当前设置的属性索引，默认指向最后一个，== nil
     * 当设置的索引不满足时，自动指向最后一个
     */
    var currentIndex : Int? {
        didSet {
            if !valid(index: currentIndex) {
                currentIndex = nil
            }
        }
    }
    
}

public extension GMLAttributesBuilder {
    /// 弹入一个新的属性进行设置
    /// - Parameters:
    ///   - attributes: 添加的默认属性
    ///   - identifier: 该属性标识，如果存在，则覆盖之前的
    func push(attributes: GMLAttributesSet? = nil, identifier: String? = nil) -> Self {
        stack.append(container(attributes: attributes, identifier: identifier))
        return self
    }
    /// 弹出最近一个属性
    func popLast() -> GMLAttributesSet? {
        return stack.popLast()?.get()
    }
    /// 获取最后一个属性
    func last() -> GMLAttributesSet? {
        return stack.last?.get()
    }
    /// 获取指定索引下的富文本属性
    func attributes(at index: Int) -> GMLAttributesSet? {
        if index < 0 || stack.count <= index {
            return nil
        }
        return stack[index].get()
    }
    /// 判断指定标识的属性是否存在
    func contains(_ identifier: String) -> Bool {
        for item in stack {
            if let key = item.key(), key == identifier {
                return true
            }
        }
        return false
    }
    /// 获取指定标识下的富文本属性
    func attributes(for identifier: String) -> GMLAttributesSet? {
        for item in stack {
            if let key = item.key(), key == identifier {
                return item.get()
            }
        }
        return nil
    }
    /// 删除指定标识下的富文本属性
    func remove(for identifier: String) -> GMLAttributesSet? {
        for item in stack {
            if let key = item.key(), key == identifier {
                return item.get()
            }
        }
        return nil
    }
}

//MARK:- 增加 NSAttributedString.Key 处理方法
extension GMLAttributesBuilder {
    /// 字体设置
    func font(_ font: GMLFont) -> Self {
        currentContainer().set(.font, font)
        return self
    }
    /// 背景设置
    func backgroundColor(_ color: GMLColor) -> Self {
        currentContainer().set(.backgroundColor, color)
        return self
    }
    /// 字体颜色设置
    func foregroundColor(_ color: GMLColor) -> Self {
        currentContainer().set(.foregroundColor, color)
        return self
    }
    /// 设置段落结构
    func paragraphStyle(_ style: NSParagraphStyle) -> Self {
        currentContainer().set(.paragraphStyle, style)
        return self
    }
    
    
}

extension GMLAttributesBuilder {
    
    /**
     * 当前正在使用的属性容器
     * 为之后可以选择设置属性容器预留
     */
    func currentContainer() -> GMLAttributesContainer {
        if !valid(index: currentIndex) {
            currentIndex = nil
        }
        guard let index = currentIndex else {
            return lastContainer()
        }
        return stack[index]
    }
    
    /// 获取最后一个属性容器，没有就创建一个
    func lastContainer() -> GMLAttributesContainer {
        if let lastContainer = stack.last {
            return lastContainer
        }
        /// 没有先push一个新的, 再返回容器
        return push().stack.last!
    }
}

private extension GMLAttributesBuilder {
    /// 创建一个属性容器
    func container(attributes: GMLAttributesSet? = nil, identifier: String? = nil) -> GMLAttributesContainer {
        if let key = identifier {
            _ = remove(for: key)
        }
        var set = GMLAttributesSet()
        if self.attributes != nil {
            set.ml_append(dict: self.attributes!)
        }
        if attributes != nil {
            set.ml_append(dict: attributes!)
        }
        
        func identifierKey() -> String? {
            return identifier
        }
        func set(key: GMLAttributesKey, value: Any?) {
            set[key] = value
        }
        func get() -> GMLAttributesSet {
            return set
        }
        return (set(key:value:), get, identifierKey)
    }
    /// 判断指定索引是否有效
    func valid(index: Int?) -> Bool {
        guard let targetIndex = index else { return false }
        if targetIndex < 0 || targetIndex >= stack.count {
            return true
        }
        return false
    }
}
