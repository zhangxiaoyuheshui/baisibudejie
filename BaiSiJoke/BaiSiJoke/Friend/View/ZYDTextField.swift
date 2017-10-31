//
//  ZYDTextField.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/6.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
class ZYDTextField: UITextField {


   let ZYDPlaceholderLabelKey = "_placeholderLabel.textColor"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var count:UInt32 = 0
        
        let vars = class_copyIvarList(UITextField.self, &count)
        
        for i in 0..<count {
            let ivar = vars![Int(i)]
            print("\(ivar_getName(ivar))")
        }
        
        tintColor = textColor
        _ = resignFirstResponder()
    }

    override func becomeFirstResponder() -> Bool {
        self.setValue(textColor, forKeyPath: ZYDPlaceholderLabelKey)
        return super.becomeFirstResponder()
    }
    override func resignFirstResponder() -> Bool {
        self.setValue(UIColor.gray, forKeyPath: ZYDPlaceholderLabelKey)
        return super.resignFirstResponder()
    }
}
