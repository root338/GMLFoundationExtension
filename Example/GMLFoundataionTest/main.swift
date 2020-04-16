//
//  main.swift
//  GMLFoundataionTest
//
//  Created by apple on 2020/4/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

protocol TestP : NSObjectProtocol {
    
}
class TestPO: NSObject, TestP {
    
}

print("Hello, World!")

var testArr = [1, 2, 3, 4, 5]
print(testArr.ml_index(at: 2) ?? -1)
var testArr2 = [NSObject(), NSArray(), NSDictionary(), NSString()]
print(testArr2.ml_index(at: [Int]()) ?? -1)

//print(testArr2.ml_index(at: <#T##NSObject#>))

_ = testArr.ml_replace(2, replaceObj: 8)
print(testArr)
//_ = testArr2.ml_replace(<#T##obj: NSObjectProtocol##NSObjectProtocol#>, replaceObj: <#T##NSObjectProtocol#>)

var testArr3 : [TestP] = [TestPO(), TestPO(), TestPO()]
 testArr3.ml_index(at: testArr3[0])
