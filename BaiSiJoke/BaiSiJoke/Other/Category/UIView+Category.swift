//
//  UIView+Category.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/7.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

extension UIView {
   
    public func isShowingOnKeyWindow() -> Bool {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return false
        }
        
        // 以主窗口的左上角为原点，计算self的矩形框
        let newFrame = keyWindow.convert(self.frame, from: self.superview)
        let windowBounds = keyWindow.bounds
        
        // 主窗口的bounds和self的矩形框是否有重叠
        let isIntersects = newFrame.intersects(windowBounds)
        
        return isIntersects && (self.isHidden == false) && (self.alpha > 0.01) && (self.window == keyWindow)
    }
    
}
