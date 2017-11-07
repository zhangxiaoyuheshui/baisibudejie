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
    
    
    // MARK: - 音频播放
    
    func setupPlayer() {
        
        // 1.设置初始化信息
        voiceTimeLabel.isHidden = true
        progressView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        currentTime.text = "00:00"
        indicatorView.alpha = 0.0
        totalTime.text = voiceTimeLabel.text
        slider.value = 0.0

        // 2.设置button
        palyButton.setImage(UIImage(named: "icon_play"), for: .normal)
        palyButton.setImage(UIImage(named: "icon_stop"), for: .selected)
        
        // 3.初始化playItem
        guard let url = URL(string: content.voiceuri) else {
            return
        }
        playItem = AVPlayerItem(url: url)
        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        
        //
        player = AVPlayer(playerItem: playItem)
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
    
    @IBAction private func play(_ sender: UIButton) {
        if sender.isSelected {
            player.pause()
        } else {
            player.play()
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    @objc private func playEnd() {
        NotificationCenter.default.removeObserver(self)
        playItem.removeObserver(self, forKeyPath: "status")
        playItem = nil
        player = nil
        palyButton.isSelected = true
        setupPlayer()
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
            case .failed:
                print("failed")
            }
        }
    }
    // MARK: - slider
    @IBAction private func touchUpInside(_ sender: UISlider) {
        // player.currentItem.currentTime.timescale
        player.seek(to: CMTimeMakeWithSeconds(Float64(sender.value * Float(content.voicetime)), player.currentItem!.currentTime().timescale))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.03) {
            self.isTouchSlider = false
        }
    }
    
    @IBAction private func touchDown(_ sender: UISlider) {
        isTouchSlider = true
    }
    
    // MARK: - deinit
    deinit {
        // 未播放结束离开页面
        if playItem != nil {
            NotificationCenter.default.removeObserver(self)
            playItem.removeObserver(self, forKeyPath: "status")
        }
    }
}
