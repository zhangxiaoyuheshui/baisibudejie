//
//  ZYDContent.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/13.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDContent: NSObject {

    /**
    @property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
    */
    /// id
    var ID: String = ""
    /// 名称
    var name: String = ""
    /// 头像的URL
    var profile_image: String = ""
    /// 发帖时间
    var create_time: String = ""
    /// 文字内容
    var text: String = ""
    /// 顶的数量
    var ding: Int = 0
    /// 踩的数量
    var cai: Int = 0
    /// 转发的数量
    var repost: Int = 0
    /// 评论的数量
    var comment: Int = 0
    /// 图片的宽度
    var width: CGFloat = 0
    /// 图片的高度
    var height: CGFloat = 0
    /// 小图
    var small_image: String = ""
    /// 中图
    var middle_image: String = ""
    /// 大图
    var large_image: String = ""
    /// 播放数量
    var playcount: Int = 0
    /// 播放时长
    var voicetime: Int = 0
    /// 视频时长
    var videotime: Int = 0
    /// 类型
    var type: Int = 0
    
    var top_cmt:ZYDComment!
    
    var isBigPicture: Bool = false
    
    /// 额外的计算cell高度的属性
    var _cellHeight: CGFloat = 0
    var cellHeight: CGFloat {
        get {
            if _cellHeight == 0 {
                let t = text as NSString
                var size = CGSize(width: screenWidth - cellMargin, height: 10000)
                size = t.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 13)], context: nil).size
                _cellHeight = cellHeaderHeiht + size.height + cellFooterHeiht + 2 * cellTextMargin
                
                if type == ZYDContentType.picture.rawValue {
                    // 图片显示出来的宽度
                    let pictureW: CGFloat = screenWidth - cellMargin;
                    // 显示显示出来的高度
                    var pictureH: CGFloat = pictureW * height / width;
                    
                    if pictureH >= cellImageMaxH {
                        pictureH = cellImageBreakH
                        isBigPicture = true
                    }
                    
                    pictureFrame = CGRect(x: cellTextMargin, y: cellHeaderHeiht + size.height + 2 * cellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + cellTextMargin)
                } else if type == ZYDContentType.voice.rawValue {
                    // 图片显示出来的宽度
                    let pictureW: CGFloat = screenWidth - cellMargin;
                    // 显示显示出来的高度
                    let pictureH: CGFloat = pictureW * height / width;
                    
                    voiceFrame = CGRect(x: cellTextMargin, y: cellHeaderHeiht + size.height + 2 * cellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + cellTextMargin)
                } else if type == ZYDContentType.video.rawValue {
                    // 图片显示出来的宽度
                    let pictureW: CGFloat = screenWidth - cellMargin;
                    // 显示显示出来的高度
                    let pictureH: CGFloat = pictureW * height / width;
                    
                    videoFrame = CGRect(x: cellTextMargin, y: cellHeaderHeiht + size.height + 2 * cellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + cellTextMargin)
                }
                

                if let comment = top_cmt {
                    let text = comment.content as NSString
                    var size = CGSize(width: screenWidth - cellMargin, height: 10000)
                    size = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)], context: nil).size
                    _cellHeight = _cellHeight + 21 + size.height
                }
                
            }
            return _cellHeight
        }
    }
    
    var pictureFrame: CGRect!
    var voiceFrame: CGRect!
    var videoFrame: CGRect!

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return [
            "small_image" : "image0",
            "middle_image" : "image2",
            "large_image" : "image1",
            "ID": "id",
            "top_cmt": "top_cmt[0]",
        ]
    }
    
}
