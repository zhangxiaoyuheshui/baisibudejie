//
//  ZYDRecommendTags.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/25.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDRecommendTags: NSObject {
    var image_list: String = ""
    var theme_name: String = ""
    var sub_number: Int = 0

    
    init(dict: [String: Any]) {
        super.init()
//        setValuesForKeys(dict)
        image_list = dict["image_list"] as! String
        theme_name = dict["theme_name"] as! String
        sub_number = Int(dict["sub_number"] as! String)!
    }
    
}
