//
//  UIBarButtonItem+ZYExtension.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/11.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(image: String, highImage: String, targat:Any, action: Selector)  {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named:image), for: .normal)
        button.setBackgroundImage(UIImage(named:highImage), for: .highlighted)
        button.addTarget(targat, action: action, for: .touchUpInside)
        button.sizeToFit()
        self.init(customView: button)
    }
    
}
