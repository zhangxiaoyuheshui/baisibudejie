//
//  ZYDNavigationViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/10.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            let button = UIButton(type: .custom)
            button.setTitle("返回", for: .normal)
            button.setImage(UIImage(named:"navigationButtonReturn"), for: .normal)
            button.setImage(UIImage(named:"navigationButtonReturnClick"), for: .highlighted)
            button.addTarget(self, action: #selector(back), for: .touchUpInside)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.setTitleColor(UIColor.red, for: .highlighted)
            button.sizeToFit()
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            button.contentHorizontalAlignment = .left
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: animated)
        
    }

}
extension ZYDNavigationViewController {
    @objc func back() {
        popViewController(animated: true)
    }
}
