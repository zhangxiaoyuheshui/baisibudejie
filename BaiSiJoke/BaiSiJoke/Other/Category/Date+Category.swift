//
//  Date+Category.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/15.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import Foundation

extension Date {
    
    /// 时间差
    ///
    /// - Parameter fromDate: 起始时间
    /// - Returns: DateComponents 对象
    public func deltaFrom(_ fromDate: Date) -> DateComponents {
        
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [Calendar.Component.year, .month, .day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: fromDate, to: self)
    }
    
    
    /// 是否是同一年
    ///
    /// - Returns: 是返回 ture ；否返回 false
    public func isThisYear() -> Bool {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let selfYear = calendar.component(.year, from: self)
        return currentYear == selfYear
    }
    
    /// 是否是今天的时间
    ///
    /// - Returns: Bool
    public func isToday() -> Bool{
       
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970

        return (currentTime - selfTime) <= (24 * 60 * 60)
    }
    
    /// 是否是昨天的时间
    ///
    /// - Returns: Bool
    public func isYesToday() -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970
        
        return (currentTime - selfTime) > (24 * 60 * 60)
    }
}
