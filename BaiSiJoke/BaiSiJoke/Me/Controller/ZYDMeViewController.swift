//
//  ZYDMeViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/10.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDMeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupTableView()
    }

    /// 设置导航
    private func setupNavigation() {
        // 设置导航栏左边的按钮
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "mine-setting-icon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "mine-setting-icon-click"), for: .highlighted)
        button.sizeToFit()
        //        button.addTarget(self, action: #selector(tagClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "meCell")

        tableView.sectionHeaderHeight = cellTextMargin
        tableView.sectionFooterHeight = 0
        
        tableView.contentInset = UIEdgeInsets(top: cellTextMargin - 35, left: 0, bottom: 0, right: 0)
        
        tableView.tableFooterView = ZYDMeFooterView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ZYDMeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "meCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "meCell")
        }
        
        if indexPath.section == 0 {
            cell?.textLabel?.text = "登录注册"
        } else {
            cell?.textLabel?.text = "离线下载"
        }
        
        return cell!
        
    }
}


