//
//  ZYDTextView.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/30.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDTextView: UITextView {

    var placeholder: String = ""

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        let name = NSNotification.Name.UITextViewTextDidChange
        NotificationCenter.default.addObserver(self, selector: #selector(textViewChange), name: name, object: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        if !self.text.isEmpty {
            return
        }
        let x: CGFloat = 3.0
        let y: CGFloat = 7.0
        let textRect = CGRect(x: x, y: y, width: screenWidth - 2 * x, height: frame.height)
        let text = placeholder as NSString
        text.draw(in: textRect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.lightGray])
    }
    
    @objc private func textViewChange() {
       setNeedsDisplay()
    }
}
