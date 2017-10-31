//
//  ZYDHeaderFooterView.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/13.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit


class ZYDHeaderFooterView: UITableViewHeaderFooterView {

    static let headerViewIdentifier = "headerView"
    
    let titleLabel: UILabel
    
    /// 创建View
    ///
    /// - Parameter tableView: TableView
    /// - Returns: View
    static func hearderFooterView(_ tableView: UITableView) -> ZYDHeaderFooterView {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZYDHeaderFooterView.headerViewIdentifier)
        if view == nil {
            return ZYDHeaderFooterView(reuseIdentifier: ZYDHeaderFooterView.headerViewIdentifier)
        }
        return view as! ZYDHeaderFooterView
    }
    /// 初始化方法
    ///
    /// - Parameter reuseIdentifier: ID
    override init(reuseIdentifier: String?) {
        titleLabel = UILabel()
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    /// 设置页面
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.backgroundColor = UIColor.color(222, 222, 222, 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
