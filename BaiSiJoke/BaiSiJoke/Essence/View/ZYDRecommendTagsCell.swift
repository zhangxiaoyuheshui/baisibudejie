//
//  ZYDRecommendTagsCell.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/8/25.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit
import Kingfisher
class ZYDRecommendTagsCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
        
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRecommendTags(_ tags: ZYDRecommendTags) {
        
        let url = URL(string: tags.image_list)
        
        headerImageView.kf.setImage(with: url)
        
        nameLabel.text = tags.theme_name
        
        countLabel.text = "\(tags.sub_number)"
        
    }
}
