//
//  ZYDNewViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/10.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDNewViewController: ZYDEssenceViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 设置导航栏左边的按钮
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "MainTagSubIcon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "MainTagSubIconClick"), for: .highlighted)
        button.sizeToFit()
        button.addTarget(self, action: #selector(tagClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)

    }

    @objc override func tagClick() {
        print("tagClick")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
