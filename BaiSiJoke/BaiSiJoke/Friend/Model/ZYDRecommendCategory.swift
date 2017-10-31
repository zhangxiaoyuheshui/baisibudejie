//
//  ZYDRecommendCategory.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/14.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDRecommendCategory: NSObject {

    var id: Int = 0
    var count: Int = 0
    var name: String = ""
    var currentPage = 1
    var total_Count = 0
    
    init(dict: [String: Any]) {
        super.init()
        id = dict["id"] as! Int
        count = dict["count"] as! Int
        name = dict["name"] as! String
        
    }
    lazy var users: [ZYDRecommendUser] = {
        let s = [ZYDRecommendUser]()
        return s
    }()
}
