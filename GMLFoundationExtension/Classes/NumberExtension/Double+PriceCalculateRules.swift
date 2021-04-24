//
//  Double+PriceCalculateRules.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/3/20.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

extension Double {
    
    /// 银行家舍入法
    /// 四舍六入,逢五看左边，左边为奇数进位，左边为偶数舍去
    /// 已分为单位
    func roundingForBanker() -> Double {
        
        var resultValue : Int
        let integerValue    = Int(self)
        let decimalValue    = self - Double(integerValue)
        
        if decimalValue < 0.5 {
            resultValue = integerValue
        }else if decimalValue >= 0.6 {
            resultValue = integerValue + 1
        }else {
            
            let digitsValue = integerValue % 10
            if digitsValue / 2 == 0 {
                resultValue = integerValue
            }else {
                resultValue = integerValue + 1
            }
        }
        return Double(resultValue)
    }
}
