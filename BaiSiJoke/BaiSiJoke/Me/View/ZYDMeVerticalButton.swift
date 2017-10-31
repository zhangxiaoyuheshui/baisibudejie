//
//  ZYDMeVerticalButton.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/24.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher

class ZYDMeVerticalButton: UIButton {
    
    var content: ZYDMeContent! {
        didSet {
            setTitle(content.name, for: .normal)
            let url = URL(string: content.icon)
            kf.setImage(with: url!, for: .normal)
            addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        }
    }
    
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
        let imageViewWH: CGFloat = 40.0
        let margin: CGFloat = 10
        imageView?.frame = CGRect(x: 0, y: margin, width: imageViewWH, height: imageViewWH)
        imageView?.center = CGPoint(x: frame.width / 2, y: margin + imageViewWH / 2)
        titleLabel?.frame = CGRect(x: 0, y: imageViewWH + margin, width: frame.width, height: frame.height - imageViewWH - margin)

    }
    
}
extension ZYDMeVerticalButton {
    
    fileprivate func setupUI() {
        titleLabel?.textAlignment = .center
        setBackgroundImage(UIImage.init(named: "mainCellBackground"), for: .normal)
        setTitleColor(UIColor.darkGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @objc fileprivate func click(_ btn: ZYDMeVerticalButton) {
        
        print("Button Click --- ", content.url)
        
        guard content.url.hasPrefix("http:") else {
            return
        }
        
        guard let tab = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
            return
        }
        let webVC = ZYDMeWebViewController()
        webVC.url = content.url
        
        let vc = tab.childViewControllers[tab.selectedIndex] as! UINavigationController
        vc.pushViewController(webVC, animated: true)
    }
}

