//
//  StringPathExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

public extension String {
    var ml_pathExtension: String {
        return (self as NSString).pathExtension
    }
    var ml_pathComponent: [String] {
        return (self as NSString).pathComponents
    }
    var ml_lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    var ml_deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    func ml_append(pathExtension: String) -> String? {
        return (self as NSString).appendingPathExtension(pathExtension)
    }
    func ml_append(pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
    
    var isExistFilePath: Bool {
        return FileManager.default.fileExists(atPath: self)
    }
    /// 是否是文件夹，nil不是有效路径，true是文件夹/false是文件
    var ml_isFileDirectory: Bool? {
        return FileManager.default.isDirectory(filePath: self)
    }
}
