//
//  ZYDPublishNavigationController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/27.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDPublishNavigationController: UINavigationController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)        
        let bar = UINavigationBar.appearance()
        bar.setBackgroundImage(UIImage.init(named: "navigationbarBackgroundWhite"), for: .default)
        bar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 40)];
        
    }
    
    
    /// 创建当前控制器指定的titleView
    static func titleView(titile: String, font: UIFont?, color: UIColor?) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: ZYDNavigationBarHeight)
        view.backgroundColor = UIColor.clear
        
        let label = UILabel(frame: view.bounds)
        label.text = titile
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        if font != nil {
            label.font = font
        }
        if color != nil {
            label.textColor = color
        }
        view.addSubview(label)
        return view
    }
    
    static func itemButton(title: String,_ target: Any?, _ SEL: Selector) -> (UIBarButtonItem, UIButton) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.addTarget(target, action: SEL, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let barButton = UIBarButtonItem(customView: button)
        return (barButton, button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
