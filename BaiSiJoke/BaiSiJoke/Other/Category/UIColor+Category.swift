//
//  UIColor+Category.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/13.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static func color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
}
