//
//  ZYDFriendViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/10.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDFriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏标题
        navigationItem.title = "我的关注"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "friendsRecommentIcon", highImage: "friendsRecommentIcon-click", targat: self, action: #selector(tagClick))
        
    }
    
    @objc func tagClick() {
        
        let vc = UIStoryboard(name: "ZYFriendStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ZYRecommendVC")
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
