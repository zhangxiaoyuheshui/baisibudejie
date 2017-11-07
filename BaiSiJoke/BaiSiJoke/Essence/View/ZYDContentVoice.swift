//
//  ZYDContentVoice.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/10.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
class ZYDContentVoice: UIView {

    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var playCountLabel: UILabel!
    
    @IBOutlet weak var voiceTimeLabel: UILabel!
    
    @IBOutlet weak var palyButton: UIButton!
    
    var content: ZYDContent!
    
    var playItem: AVPlayerItem!
    
    var player: AVPlayer!
    
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var isTouchSlider = false
    
    static func voiceView() -> ZYDContentVoice {
        return Bundle.main.loadNibNamed("ZYDContentVoice", owner: nil, options: nil)!.last as! ZYDContentVoice
    }
    
    
    public func setupView(_ content: ZYDContent) {
        
        self.content = content
        
        let url = URL(string: content.large_image)
        
        pictureView.kf.setImage(with: url!)
        
        playCountLabel.text = "\(content.playcount)播放"
       
        let min = content.voicetime / 60
        
        let second = content.voicetime % 60
        
        voiceTimeLabel.text = "\(min):\(second)"
        
    }
    
    @IBAction private func play(_ sender: UIButton) {
       
        guard player == nil else {
            if #available(iOS 10.0, *) {
                if player.timeControlStatus == .paused {
                    player.play()
                }
                if player.timeControlStatus == .playing {
                    player.pause()
                }
            }
            return
        }
        
        guard let url = URL(string: content.voiceuri) else {
            return
        }
        
        playItem = AVPlayerItem(url: url)
        
        player = AVPlayer(playerItem: playItem)
        
        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: DispatchQueue.main) { [weak self] (cmTime: CMTime) in
            let current = CMTimeGetSeconds(cmTime)
            let min = (Int(current) / 60) > 9 ? "\((Int(current) / 60))" : "0\((Int(current) / 60))"
            let second = (Int(current) % 60) > 9 ? "\((Int(current) % 60))" : "0\((Int(current) % 60))"
            self?.currentTime.text = "\(min):\(second)"
            guard self?.isTouchSlider == false else {
                return
            }
            self?.slider.value = Float(current / Float64((self?.content.voicetime)!))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playEnd), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: nil)
    }
    
    
    @objc private func playEnd() {
        changeProgressViewToInit(0)
        playItem.removeObserver(self, forKeyPath: "status")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if  keyPath == "status" {
            switch playItem.status {
            case .unknown:
                print("loading...")
                indicatorView.alpha = 1.0
            case .readyToPlay:
                print("can paly")
                indicatorView.alpha = 0.0
                player.play()
            case .failed:
                let alert = UIAlertView(title: "播放失败", message: "请重试", delegate: nil, cancelButtonTitle: "取消")
                alert.show()
                print("failed")
            }
        }
    }
    
    public func changeProgressViewToInit(_ progress:Int) {
        voiceTimeLabel.isHidden = true
        progressView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        currentTime.text = "00:00"
        indicatorView.alpha = 0.0
        totalTime.text = voiceTimeLabel.text
        slider.value = 0.0
        player = nil
        NotificationCenter.default.removeObserver(self)
    }
   
    
    @IBAction func changPlayerProgress(_ sender: UISlider) {
        
        // 没有用到
        
    }
    
    @IBAction func touchUpInside(_ sender: UISlider) {
        player.seek(to: CMTimeMakeWithSeconds(Float64(sender.value * Float(content.voicetime)), 1))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.03) {
            self.isTouchSlider = false
        }
    }
    
    @IBAction func touchDown(_ sender: UISlider) {
        isTouchSlider = true
    }
    
}
