//
//  ZYDLoginRegisterViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/5.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDLoginRegisterViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var loginViewLeftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickLoginOrRegister(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        loginViewLeftConstraint.constant = sender.isSelected ? 0 : -(view.frame.width)
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

