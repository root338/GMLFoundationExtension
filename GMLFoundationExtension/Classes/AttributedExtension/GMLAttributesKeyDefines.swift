//
//  GMLAttributesKeyDefines.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/30.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

typealias GMLAttributesSetFunc = (GMLAttributesKey, Any?) -> Void
typealias GMLAttributesGetFunc = () -> GMLAttributesSet
typealias GMLAttributesIdentifierFunc = () -> String?
typealias GMLAttributesContainer = (set: GMLAttributesSetFunc, get: GMLAttributesGetFunc, key: GMLAttributesIdentifierFunc)

//let GMLAttributesKeyPop: GMLAttributesKey = GMLAttributesKey(rawValue: "GMLAttributesKeyPop")

