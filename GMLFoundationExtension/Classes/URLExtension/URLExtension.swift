//
//  URLExtension.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/6/6.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

extension URL {
    
    
    var ml_isDirectory: Bool? {
        guard let resource = try? self.resourceValues(forKeys: Set<URLResourceKey>([.isDirectoryKey])) else {
            return nil
        }
        return resource.isDirectory
    }
}
