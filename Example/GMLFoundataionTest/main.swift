//
//  main.swift
//  GMLFoundataionTest
//
//  Created by apple on 2020/4/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

print("Hello, World!")

let testArr = [1, 2, 3, 4, 5]
print(testArr.ml_index(at: 2) ?? -1)
let testArr2 : [NSObjectProtocol] = [NSObject(), NSArray(), NSDictionary(), NSString()]
print(testArr2.ml_index(at: [Int]() as NSArray) ?? -1)
