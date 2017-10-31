//
//  UIImage+Category.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/20.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

extension UIImage {
  
    public func cicleImage() -> UIImage {
        
        // 开启图形上下文 false代表透明
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        // 获取上下文
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // 添加一个圆
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ctx?.addEllipse(in: rect)
        
        // 裁剪
        ctx?.clip()
        
        // 将图片画上去
        draw(in: rect)
        
        // 获取图片
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    
}
