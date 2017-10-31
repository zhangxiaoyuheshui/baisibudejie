//
//  ZYDEssenceContentViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/8.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import MJExtension

public enum ZYDContentType: Int {
    case all = 1
    case picture = 10
    case word = 29
    case voice = 31
    case video = 41
}

class ZYDEssenceContentViewController: UITableViewController {
 
    let indentifier = "cell"
    
    var contents: [ZYDContent] = [ZYDContent]()
    
    var parameters: [String: Any] = [String: Any]()
    
    var page: Int = 0
    
    var maxTime: String = ""
    
    var type: ZYDContentType = .all
    
    let footView: ZYDRefreshFooterView = ZYDRefreshFooterView.footerView()
    
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: ZYDSelectTabberNotification, object: nil)
//        tableView.register(ZYDContentCell., forCellReuseIdentifier: indentifier)
        
        tableView.register(UINib.init(nibName: "ZYDContentCell", bundle: nil), forCellReuseIdentifier: indentifier)
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        var top: CGFloat = 99
        var bottom: CGFloat = 49
        if view.frame.height == 768 {
            top += 24
            bottom += 34
        }
        // 设置Inset
        tableView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.separatorStyle = .none
        // 添加刷新控件
        setupRefresh()
    }

    @objc func refreshView()  {
        
        
        if currentIndex == tabBarController?.selectedIndex && view.isShowingOnKeyWindow() {
            print("点击tabbar刷新")
            tableView.mj_header.beginRefreshing()
        }
        // 记录当前选中
        currentIndex = tabBarController!.selectedIndex
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewContents))
        // 自动改变透明度
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
        
        tableView.tableFooterView = footView
        footView.delegate = self
        footView.finishLoadData()
        footView.isHidden = true
    }

}
// MARK: - 上拉刷新 下拉刷新操作
extension ZYDEssenceContentViewController {
    
    private func a() -> String {
        if parent.self!.isKind(of: ZYDNewViewController.self) {
            return "newlist"
        }
        return "list"
    }
    
    @objc fileprivate func loadNewContents() {
        
        var parameter = [String: Any]()
        parameter["a"] = a()
        parameter["c"] = "data"
        parameter["type"] = type.rawValue
        
        let url = URL(string: "http://api.budejie.com/api/api_open.php")
        Alamofire.request(url!, method: .get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
            case let .success(value):
                                
                guard let dict = value as? [String: Any] else {
                    return
                }
                
                guard let datas = dict["list"] as? [[String: Any]] else {
                    return
                }
                
                if let lastTime = dict["info"] as? [String: Any] {
                    self.maxTime = (lastTime["maxtime"] as? String) ?? ""
                }
                
                // 
                self.contents = ZYDContent.mj_objectArray(withKeyValuesArray: datas) as! [ZYDContent]
           
                self.tableView.mj_header.endRefreshing()
                self.page = 0
                self.tableView.reloadData()
                self.footView.isHidden = false
                
            case let .failure(error):

                print("load content \(error)")
            }
        }
    }
    
    fileprivate func loadMoreContents() {
        
        var parameter = [String: Any]()
        parameter["a"] = a()
        parameter["c"] = "data"
        parameter["type"] = type.rawValue
        let p = page + 1
        parameter["page"] = p
        parameter["maxtime"] = maxTime


        let url = URL(string: "http://api.budejie.com/api/api_open.php")
        Alamofire.request(url!, method: .get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
            case let .success(value):
                
                guard let dict = value as? [String: Any] else {
                    return
                }
                
                guard let datas = dict["list"] as? [[String: Any]] else {
                    return
                }
                
                if let lastTime = dict["info"] as? [String: Any] {
                    self.maxTime = (lastTime["maxtime"] as? String) ?? ""
                }
                
                self.contents = ZYDContent.mj_objectArray(withKeyValuesArray: datas) as! [ZYDContent]
                self.page += 1
                self.tableView.reloadData()
                self.footView.finishLoadData()
            case let .failure(error):
                
                print("load content \(error)")
            }
        }
    }
}
// MARK: - dataSource
extension ZYDEssenceContentViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier) as! ZYDContentCell
        cell.content = contents[indexPath.row]
        cell.content?.cellHeight
        cell.setupUI()
        return cell
    }
}
// MARK: - delegate
extension ZYDEssenceContentViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ZYDCommentViewController()
        vc.content = contents[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = contents[indexPath.row]
        // get - only
//        content.cellHeight = 0
        return content.cellHeight
    }
}

extension ZYDEssenceContentViewController: ZYDRefreshFooterViewDelegate {
    func loadMoreData(_ footerView: ZYDRefreshFooterView) {
        loadMoreContents()
    }
}
