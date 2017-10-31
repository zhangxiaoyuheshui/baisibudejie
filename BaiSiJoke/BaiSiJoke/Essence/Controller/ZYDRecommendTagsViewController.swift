//
//  ZYDRecommendTagsViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/25.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Alamofire

class ZYDRecommendTagsViewController: UITableViewController {

    fileprivate let cellIdentifier = "tags"
    
    fileprivate var tags = [ZYDRecommendTags]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
    deinit {
        print("释放 - ZYDRecommendTagsViewController")
    }
}
// MARK: - 设置ui和数据
extension ZYDRecommendTagsViewController {
    
    fileprivate func setupUI() {
     
        tableView.register(UINib.init(nibName: "ZYDRecommendTagsCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.rowHeight = 70
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor(red: 220.0 / 255, green: 220.0 / 255, blue: 220.0 / 255, alpha: 1)
    
    }
    
    fileprivate func loadData() {
        
        let parameters = ["a":"tag_recommend", "c": "topic", "action": "sub"]
        
        Alamofire.request("http://api.budejie.com/api/api_open.php", method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                guard let datas = value as? [[String: Any]] else {
                    return
                }
                for dict in datas {
                    let tag = ZYDRecommendTags(dict: dict)
                    self.tags.append(tag)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print("Tags response error = \(error)")
            }
        }
    }
}

// MARK: - Table view data source

extension ZYDRecommendTagsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ZYDRecommendTagsCell
        
        cell.setRecommendTags(tags[indexPath.row])
        
        return cell
        
    }

}
