//
//  ZYDPictureViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/26.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDPictureViewController: UIViewController {
    
    var content: ZYDContent!
    
    /// Scrollview
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        view.backgroundColor = UIColor.black
        return view
    }()
    
    /// 返回的Button
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 15, y: 45, width: 35, height: 35)
        button.setBackgroundImage(UIImage(named: "show_image_back_icon"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    /// 图片
    lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("分享好友", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.frame = CGRect(x: screenWidth - 50 * 2 - 20 * 2, y: screenHeight - 50, width: 50, height: 30)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("保存图片", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.frame = CGRect(x: screenWidth - 50 - 20, y: screenHeight - 50, width: 50, height: 30)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    /// 设置UI
    private func setupUI() {
        view.addSubview(scrollView)
        view.addSubview(backButton)
        
        scrollView.addSubview(pictureView)
        let url = URL(string: content.large_image)
        pictureView.kf.setImage(with: url!)
        
        let pW = screenWidth
        let pH = pW / content.width * content.height
        pictureView.frame = CGRect(x: 0, y: 0, width: pW, height: pH)
        scrollView.contentSize = CGSize(width: pW, height: pH)

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0//(content.width * content.height) / (pW * pH)
        
        if !(pH > screenHeight) {
            pictureView.center = scrollView.center
        }
        
        view.addSubview(shareButton)
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(clickSaveImage), for: .touchUpInside)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 返回上一级页面
    @objc private func back() {
        dismiss(animated: true, completion: nil)
    }
    
    
    /// 保存照片
    @objc private func clickSaveImage() {
   
        UIImageWriteToSavedPhotosAlbum(pictureView.image!, self, #selector(saveImage(_:_:_:)), nil)
    }
    
    
    /// 监听保存照片返回的状态
    ///
    /// - Parameters:
    ///   - iamge: 图片
    ///   - error: 错误
    ///   - contentextInfo: info
    @objc func saveImage(_ iamge: UIImage, _ error: Error?, _ contentextInfo: Any?) {

        if error != nil {
            print(error!)
        } else {
            print("保存成功！")
        }
    }
}

