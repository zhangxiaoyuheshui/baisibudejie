//
//  ZYDRecommendViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/11.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

import SVProgressHUD
import Alamofire

class ZYDRecommendViewController: UIViewController {

    let categroyIdentifier = "categroy"
    
    let userIdentifier = "user"

    let footerView = ZYDRefreshFooterView.footerView()

    @IBOutlet weak var categroyTableView: UITableView!
    
    @IBOutlet weak var userTableView: UITableView!
    
    
    var categroes = [ZYDRecommendCategory]()
    
    var parameters_record = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadCategroyData()
    }
    
    fileprivate func setupTableView() {
        
        // 1.类别的TableView
        categroyTableView.register(UINib.init(nibName: "ZYDRecommendCategoryCell", bundle: nil), forCellReuseIdentifier: categroyIdentifier)
        categroyTableView.rowHeight = 50.0
        // 不能上拉下拉出边界
        categroyTableView.bounces = false
        categroyTableView.showsVerticalScrollIndicator = false
        
        // 2.用户的TableView
        userTableView.register(UINib.init(nibName: "ZYDRecommendUserCell", bundle: nil), forCellReuseIdentifier: userIdentifier)
        userTableView.rowHeight = 75.0
        userTableView.showsVerticalScrollIndicator = false
        userTableView.addSubview(refreshControl)
        footerView.delegate = self
        userTableView.tableFooterView = footerView
        footerView.isHidden = true
        
        // 3.设置title
        title = "推荐关注"
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
    }
    
    fileprivate func loadCategroyData() {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
                
        let parameters = ["a":"category", "c": "subscribe"]
        
        Alamofire.request("http://api.budejie.com/api/api_open.php", method: .get, parameters:parameters).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                guard let r_dicts = value as? [String : Any] else {
                    return
                }
                let dicts = r_dicts["list"] as? [[String : Any]]
    
                guard let lists = dicts else {
                    return
                }
                for dict in lists {
                    let catagory = ZYDRecommendCategory(dict: dict)
                    self.categroes.append(catagory)
                }
                SVProgressHUD.dismiss()
    
                self.categroyTableView.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.categroyTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
                self.refreshControl.beginRefreshing()
                self.loadUsers()
                
            case .failure(let error):
                print("请求类别数据error = \(error)")
            }
            
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        let title = NSAttributedString(string: "loading...")
        control.attributedTitle = title
        control.addTarget(self, action: #selector(loadUsers), for: UIControlEvents.valueChanged)
        return control
    }()
    
    @objc fileprivate func loadUsers() {
        
        guard let row = categroyTableView.indexPathForSelectedRow?.row else {
            return
        }

        userTableView.contentOffset = CGPoint(x: 0, y: -64)
        
        let catagroy = categroes[row]
        
        let parameters = ["a":"list", "c": "subscribe", "category_id":"\(catagroy.id)", "page": "\(catagroy.currentPage)"]
        
        parameters_record = parameters

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            Alamofire.request("http://api.budejie.com/api/api_open.php", method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    
                    guard self.parameters_record == parameters else {
                        print("请求页面不一致！")
                        return
                    }
                    
                    guard let r_dicts = value as? [String : Any] else {
                        return
                    }
                    
                    catagroy.total_Count = (r_dicts["total"] as? Int) ?? 0
                    let dicts = r_dicts["list"] as? [[String : Any]]
                    
                    guard let lists = dicts else {
                        return
                    }
                    
                    for dict in lists {
                        let user = ZYDRecommendUser(dict: dict)
                        catagroy.users.append(user)
                    }
                    self.userTableView.reloadData()
                    
                    self.refreshControl.endRefreshing()
                    self.checkFooterViewState()
                    
                case .failure(let error):
                    print("下拉刷新请求错误\(error)")
                }
            })
        }
    }
    
    @objc fileprivate func loadMoreUses() {
        
        guard let row = categroyTableView.indexPathForSelectedRow?.row else {
            return
        }
        let catagroy = self.categroes[row]
        
        let parameters = ["a":"list", "c": "subscribe", "category_id":catagroy.id, "page": catagroy.currentPage + 1] as [String : Any]
        
        catagroy.currentPage += 1
        
        Alamofire.request("http://api.budejie.com/api/api_open.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
            case .success(let value) :
                
                guard let r_dicts = value as? [String : Any] else {
                    return
                }
                let dicts = r_dicts["list"] as? [[String : Any]]
                
                guard let lists = dicts else {
                    return
                }
                for dict in lists {
                    let user = ZYDRecommendUser(dict: dict)
                    catagroy.users.append(user)
                }
                self.userTableView.reloadData()
                self.checkFooterViewState()

            case .failure(let error) :
                print("请求user数据error = \(error)")
            }
        }
    }

    fileprivate func checkFooterViewState() {
        guard let row = categroyTableView.indexPathForSelectedRow?.row else {
            return
        }
        let catagroy = categroes[row]
        
        footerView.isHidden = (catagroy.users.count == 0)
    
        if catagroy.users.count == catagroy.total_Count {
            footerView.noDataload()
        }
        else {
            footerView.finishLoadData()
        }
    }
}

// MARK: UITableViewDataSource
extension ZYDRecommendViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categroyTableView {
            return categroes.count
        }
        else {
            guard let row = categroyTableView.indexPathForSelectedRow?.row else {
                return 0
            }
            let categroy = categroes[row]
            checkFooterViewState()
            return categroy.users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == categroyTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: categroyIdentifier)!
            cell.textLabel?.text = "\(categroes[indexPath.row].name)"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: userIdentifier) as! ZYDRecommendUserCell
            let row = categroyTableView.indexPathForSelectedRow?.row
            let categroy = categroes[row!]
            cell.set_User(categroy.users[indexPath.row])
            
            return cell

        }
    }
}

// MARK: UITableViewDelegate
extension ZYDRecommendViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard tableView == categroyTableView else {
            return
        }

        let catagroy = categroes[indexPath.row]
        
        guard catagroy.users.count > 0 else {
            refreshControl.beginRefreshing()
            userTableView.reloadData()
            loadUsers()
            return
        }
        userTableView.reloadData()
    }
}
extension ZYDRecommendViewController: ZYDRefreshFooterViewDelegate {
    func loadMoreData(_ footerView: ZYDRefreshFooterView) {
        loadMoreUses()
    }
}
