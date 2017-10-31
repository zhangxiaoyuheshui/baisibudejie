//
//  ZYDMeWebViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/25.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDMeWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        guard let u = URL(string: url) else {
            return
        }
        webView.loadRequest(URLRequest(url: u))
        
        webView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func webBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func webForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    @IBAction func webRefresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
}
extension ZYDMeWebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
    }
    
}
