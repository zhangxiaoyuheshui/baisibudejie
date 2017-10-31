//
//  ZYDContentVideo.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/11.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher

class ZYDContentVideo: UIView {

    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var playCountLabel: UILabel!
    
    @IBOutlet weak var videoTimeLabel: UILabel!
    
    @IBOutlet weak var palyButton: UIButton!

    
    
    static public func contentVideo() -> ZYDContentVideo {
        return Bundle.main.loadNibNamed("ZYDContentVideo", owner: nil, options: nil)?.last as! ZYDContentVideo
    }
    
    public func setupView(withContent content: ZYDContent) {
        
        let url = URL(string: content.large_image)
        
        pictureView.kf.setImage(with: url!)
        
        playCountLabel.text = "\(content.playcount)播放"
        
        let min = content.videotime / 60
        
        let second = content.videotime % 60
        
        videoTimeLabel.text = "\(min):\(second)"

        
    }
}
