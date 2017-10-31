//
//  ZYDRecommendUser.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/22.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDRecommendUser: NSObject {

    
    var header: String = ""
    var fans_count: Int = 0
    var screen_name: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        
        header = dict["header"] as! String
        fans_count = dict["fans_count"] as! Int
        screen_name = dict["screen_name"] as! String
//        setValuesForKeys(dict)
    }
}
