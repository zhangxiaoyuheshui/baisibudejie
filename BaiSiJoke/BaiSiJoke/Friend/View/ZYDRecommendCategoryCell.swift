//
//  ZYDRecommendCategoryCell.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/22.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDRecommendCategoryCell: UITableViewCell {

    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red: 244.0/255, green: 244.0/255, blue: 244.0/255, alpha: 1)
        textLabel?.adjustsFontSizeToFitWidth = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: (textLabel?.frame.origin.x)!, y: 2, width: (textLabel?.frame.width)!, height: contentView.frame.height - 4)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if !selected {
            textLabel?.textColor = UIColor.lightGray
            redView.isHidden = true
        }
        else {
            textLabel?.textColor = UIColor.red
            redView.isHidden = false
        }
        
    }
    
}
