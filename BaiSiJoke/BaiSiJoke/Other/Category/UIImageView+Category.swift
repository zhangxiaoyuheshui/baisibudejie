//
//  UIImageView+Category.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/20.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import Foundation
import Kingfisher
extension UIImageView {
    public func setHeaderImage(_ imageUrl: String) {
        if let url = URL(string: imageUrl) {
            kf.setImage(with: url, placeholder: UIImage(named: "defaultUserIcon"), options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                if error != nil {
                    return
                }
                self.image = image?.cicleImage()
            })
        }
    }
}
