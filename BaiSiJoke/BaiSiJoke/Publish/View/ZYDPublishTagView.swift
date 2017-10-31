//
//  ZYDPublishTagView.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/30.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDPublishTagView: UIView {

    @IBOutlet weak var tagVeiw: UIView!
    
    class func publishTagView() -> ZYDPublishTagView {
        let view = Bundle.main.loadNibNamed("ZYDPublishTagView", owner: nil, options: nil)?.first as! ZYDPublishTagView
        return view
    }
    
}
