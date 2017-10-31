//
//  ZYDTopWindow.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/20.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDTopWindow: NSObject {
    
    static let window: UIWindow = UIWindow()
    
    class func showWindow() {
        ZYDTopWindow.window.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20)
        ZYDTopWindow.window.windowLevel = UIWindowLevelAlert
        ZYDTopWindow.window.backgroundColor = UIColor.clear
        ZYDTopWindow.window.isHidden = false;

        let tap = UITapGestureRecognizer(target: self, action: #selector(windowClick))
        ZYDTopWindow.window.addGestureRecognizer(tap)
    }
    
    @objc class private func windowClick() {
        
        let keyWindow = UIApplication.shared.keyWindow
        
        ZYDTopWindow.searchScroolViewInView(keyWindow ?? UIWindow())
        
    }
    
    public class func searchScroolViewInView(_ superView: UIView) {
        
        for subView in superView.subviews {
            
            if subView.isKind(of: UIScrollView.self) && subView.isShowingOnKeyWindow() {
                let view = subView as! UIScrollView
                var offset = view.contentOffset
                offset = CGPoint(x: offset.x, y: -(view.contentInset.top))
                view.setContentOffset(offset, animated: true)
            }
            
            // 继续查找子控件
            ZYDTopWindow.searchScroolViewInView(subView)
        }
        
    }
    
    

}
