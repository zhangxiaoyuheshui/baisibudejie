//
//  ZYDContentVoice.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/10.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher
class ZYDContentVoice: UIView {

    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var playCountLabel: UILabel!
    
    @IBOutlet weak var voiceTimeLabel: UILabel!
    
    @IBOutlet weak var palyButton: UIButton!
    
    
    static func voiceView() -> ZYDContentVoice {
        return Bundle.main.loadNibNamed("ZYDContentVoice", owner: nil, options: nil)!.last as! ZYDContentVoice
    }
    
    
    public func setupView(_ content: ZYDContent) {
        
        let url = URL(string: content.large_image)
        
        pictureView.kf.setImage(with: url!)
        
        playCountLabel.text = "\(content.playcount)播放"
       
        let min = content.voicetime / 60
        
        let second = content.voicetime % 60
        
        voiceTimeLabel.text = "\(min):\(second)"
    }
    
    @IBAction func play(_ sender: UIButton) {
        
    }
    
    
}
