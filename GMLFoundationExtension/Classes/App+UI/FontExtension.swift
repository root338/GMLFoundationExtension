//
//  FontExtension.swift
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
public typealias GMLFont = UIFont
#elseif os(OSX)
public typealias GMLFont = NSFont
#endif

public enum GMLFontWeight {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    var weight : GMLFont.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        }
    }
}

public extension GMLFont {
    
    static func ml_font(ofSize fontSize: CGFloat, weight: GMLFontWeight = .regular) -> GMLFont {
        
        if #available(OSX 10.11, iOS 8.2, *) {
            return systemFont(ofSize: fontSize, weight: weight.weight)
        }
        switch weight {
        case .bold: return boldSystemFont(ofSize: fontSize)
        default: return systemFont(ofSize: fontSize)
        }
    }
    
    
}
