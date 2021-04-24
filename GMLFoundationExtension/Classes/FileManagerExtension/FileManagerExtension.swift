//
//  FileManagerExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

public extension FileManager {
    
    enum URLResourceError: Error {
        case isEmpty
    }
    
    enum EnumeratorOperate {
        case none
        case `continue`
        case `return`
    }
    
    /// 验证文件路径是否是文件夹
    /// - Returns: 返回是否是文件夹，nil表示不是有效路径
    func isDirectory(filePath: String) -> Bool? {
        let boolPointer = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        let result = self.fileExists(atPath: filePath, isDirectory: boolPointer)
        let isDirectory = boolPointer.pointee.boolValue
        boolPointer.deallocate()
        return result == false ? nil : isDirectory
    }
    
    /// 枚举指定目录
    /// - Parameters:
    ///   - filePath: 文件路径
    ///   - isDepth: 是否深度遍历子目录
    ///   - handle: 处理遍历文件路径 (文件路径, 是否目录) -> 执行选项
    func enumerator(at filePath: String, isDepth: Bool = false, handle: (String, Bool) -> EnumeratorOperate) {
        guard let isDir = self.isDirectory(filePath: filePath) else {
            return
        }
        guard isDir else {
            _ = handle(filePath, false)
            return
        }
        guard let directoryEnumerator = enumerator(atPath: filePath) else {
            return
        }
        while let fileName = directoryEnumerator.nextObject() as? String {
            let path = filePath.ml_append(pathComponent: fileName)
            guard let isDir = isDirectory(filePath: path) else { return }
            var operate = EnumeratorOperate.none
            operate = handle(path, isDir)
            switch operate {
            case .none:
                if isDepth { continue }
                enumerator(at: path, isDepth: isDepth) {
                    operate = handle($0,$1)
                    return operate
                }
            case .continue: continue
            case .return: return
            }
            if operate == .return {
                return
            }
        }
    }
    
    /// 当前路径下的子目录数组
    func ml_currentsubpaths(atPath path: String) -> [String]? {
        guard let dirEnum = self.enumerator(atPath: path) else { return nil }
        var subpaths = [String]()
        while let path = dirEnum.nextObject() as? String {
            subpaths.append(path)
        }
        return subpaths
    }
    
    func enumerator(at url: URL, options: (resourceKeys: [URLResourceKey]?, enumOptions: DirectoryEnumerationOptions) = ([.isDirectoryKey], [.skipsSubdirectoryDescendants, .skipsHiddenFiles]), handle: (URL, () throws -> URLResourceValues) -> EnumeratorOperate, errorHandle: ((URL, Error) -> Bool)? = nil) {
        guard let directoryEnumerator = enumerator(at: url, includingPropertiesForKeys: options.resourceKeys, options: options.enumOptions, errorHandler: errorHandle) else {
            return
        }
        var resourceKeySet : Set<URLResourceKey>?
        for case let fileURL as URL in directoryEnumerator {
            func getURLResourceValue() throws -> URLResourceValues {
                if resourceKeySet == nil {
                    if options.resourceKeys == nil {
                        throw URLResourceError.isEmpty
                    }
                    resourceKeySet = Set<URLResourceKey>(options.resourceKeys!)
                }
                let values = try fileURL.resourceValues(forKeys: resourceKeySet!)
                return values
            }
            switch handle(fileURL, getURLResourceValue) {
            case .none: fallthrough
            case .continue: continue
            case .return: return
            }
        }
    }
}
