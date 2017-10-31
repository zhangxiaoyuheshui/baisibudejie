//
//  ZYDPublishTagButton.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/30.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDPublishTagButton: UIButton {

    
    class func publishTagButton(_ isAdd: Bool) -> ZYDPublishTagButton {
        
        return ZYDPublishTagButton.init(isAdd)
        
    }
    
    convenience init(_ isAdd: Bool) {
        self.init(type: .custom)
        setupView(isAdd)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView(_ isAdd: Bool) {
        if isAdd {
            setImage(UIImage.init(named: "chose_tag_close_icon"), for: .normal)
        }
        backgroundColor = UIColor(red: 160.0 / 255, green: 220.0 / 255, blue: 72.0 / 255, alpha: 1)
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
}
