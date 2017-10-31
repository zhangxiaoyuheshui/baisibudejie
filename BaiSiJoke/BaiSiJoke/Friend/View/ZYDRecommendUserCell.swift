//
//  ZYDRecommendUserCell.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/22.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher

class ZYDRecommendUserCell: UITableViewCell {

    var user: ZYDRecommendUser?
    @IBOutlet weak var headerView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var fansCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set_User(_ user: ZYDRecommendUser) {
        self.user = user
        headerView.setHeaderImage(user.header)
        nameLabel.text = user.screen_name
        fansCountLabel.text = "\(user.fans_count)"
    }
}
