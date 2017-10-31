//
//  ZYDRefreshFooterView.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/23.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

protocol ZYDRefreshFooterViewDelegate: NSObjectProtocol {
    
    func loadMoreData(_ footerView: ZYDRefreshFooterView)
}

class ZYDRefreshFooterView: UIView {
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var loadMoreButton: UIButton!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    public weak var delegate: ZYDRefreshFooterViewDelegate?
    
    public class func footerView() -> ZYDRefreshFooterView {
        return Bundle.main.loadNibNamed("ZYDRefreshFooterView", owner: nil, options: nil)?.last as! ZYDRefreshFooterView
    }
    
    
    @IBAction func clickLoadMoreBUtton(_ sender: UIButton) {
        loadMoreButton.isHidden = true
        loadingView.isHidden = false
        noDataLabel.isHidden = true
        delegate?.loadMoreData(self)
    }
    
    public func finishLoadData() {
        loadMoreButton.isHidden = false
        loadingView.isHidden = true
        noDataLabel.isHidden = true
    }
    public func noDataload() {
        loadMoreButton.isHidden = true
        loadingView.isHidden = true
        noDataLabel.isHidden = false
    }

}
