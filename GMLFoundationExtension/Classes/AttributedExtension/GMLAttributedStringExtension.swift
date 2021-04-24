//
//  GMLAttributedStringExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation


public extension NSAttributedString {
    var ml_allRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }
    var ml_lastLocation: Int? {
        if self.length == 0 {
            return nil
        }
        return self.length - 1
    }
}
