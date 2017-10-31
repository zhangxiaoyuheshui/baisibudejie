//
//  ZYDVerticalButton.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/5.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDVerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView == nil {
            return
        }
        imageView?.frame = CGRect(x: 0, y: 0, width: imageView!.frame.width, height: imageView!.frame.height)
        titleLabel?.frame = CGRect(x: 0, y: imageView!.frame.height, width: frame.width, height: frame.height - imageView!.frame.height)
    }

}
extension ZYDVerticalButton {
 
    fileprivate func setupUI() {
        titleLabel?.textAlignment = .center
    }
}
