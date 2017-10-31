//
//  ZYDContentCell.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/14.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher

class ZYDContentCell: UITableViewCell {

    @IBOutlet weak var isVImage: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dingButton: UIButton!
    
    @IBOutlet weak var caiButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
        
    @IBOutlet weak var contentTextLabel: UILabel!
    
    
    @IBOutlet weak var commentView: UIView!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var commentContentLabel: UILabel!
    lazy var pictureView: ZYDContentPicture = {
        let view = ZYDContentPicture.picture()
        self.addSubview(view)
        return view
    }()
    lazy var voiceView: ZYDContentVoice = {
        
        let view = ZYDContentVoice.voiceView()
        self.addSubview(view)
        return view
    }()
    lazy var videoView: ZYDContentVideo = {
        let view = ZYDContentVideo.contentVideo()
        self.addSubview(view)
        return view
    }()
    var content: ZYDContent!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
     func setupUI() {
        
        headerImage.setHeaderImage(content.profile_image)
        
        nameLabel.text = content.name
        timeLabel.text = countTime(content.create_time)
        contentTextLabel.numberOfLines = 0
        contentTextLabel.text = content.text
        
        setButtonText(dingButton, content.ding, "顶")
        setButtonText(caiButton, content.cai, "踩")
        setButtonText(shareButton, content.repost, "分享")
        setButtonText(commentButton, content.comment, "评论")

        if content.type == ZYDContentType.picture.rawValue {
            pictureView.isHidden = false
            voiceView.isHidden = true
            videoView.isHidden = true
            pictureView.setupView(content)
            if let f = content.pictureFrame {
                pictureView.frame = f
            }
        } else if content.type == ZYDContentType.voice.rawValue {
            pictureView.isHidden = true
            voiceView.isHidden = false
            videoView.isHidden = true
            voiceView.setupView(content)
            if let f = content.voiceFrame {
                voiceView.frame = f
            }
        } else if content.type == ZYDContentType.video.rawValue {
            pictureView.isHidden = true
            voiceView.isHidden = true
            videoView.isHidden = false
            videoView.setupView(withContent: content)
            if let f = content.videoFrame {
                videoView.frame = f
            }
        } else {
            pictureView.isHidden = true
            voiceView.isHidden = true
            videoView.isHidden = true
        }
        
        if let coment = content.top_cmt {
            commentView.isHidden = false
            commentContentLabel.text = coment.content
        } else {
            commentView.isHidden = true
        }
    }
    
    fileprivate func setButtonText(_ button: UIButton, _ count: Int,_ placeholder: String)  {
        
        var placeholder = placeholder
        if count >= 1000 {
            placeholder = "\(count / 1000)" + "\(count % 1000)" + " 万"
        }
        else if (count > 0) {
            placeholder = "\(count)"
        }
        button.setTitle(placeholder, for: .normal)
    }
    
    fileprivate func countTime(_ creatTime: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formater.date(from: creatTime) else {
            return "error"
        }
        if date.isThisYear() {
            let coms = Date().deltaFrom(date)
            if date.isToday() {
                if coms.hour! >= 1 {
                    return "\(coms.hour!)小时之前"
                }
                else if coms.minute! > 1 {
                    return "\(coms.minute!)分钟之前"
                }
                else {
                    return "刚刚"
                }
            }
            else if (date.isYesToday()) {
                formater.dateFormat = "昨天HH:mm:ss";
                return formater.string(from: date)
            }
            else {
                formater.dateFormat = "YY-dd HH:mm:ss";
                return formater.string(from: date)
            }
        }
        else {
            return creatTime
        }
    }
}
