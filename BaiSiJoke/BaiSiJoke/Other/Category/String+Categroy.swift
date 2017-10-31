//
//  String+Categroy.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/31.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit


extension String {

    public func height(_ size: CGSize, _ attributes: [String: Any]?) -> CGFloat {
    
        let string = self as NSString
        
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return stringSize.height

    }
    
    public func width(_ size: CGSize, _ attributes: [String: Any]?) -> CGFloat {
        
        let string = self as NSString
        
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return stringSize.width
        
    }
    
}
