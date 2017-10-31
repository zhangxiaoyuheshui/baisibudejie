//
//  ZYDPublishViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/28.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDPublishViewController: UIViewController {

    var buttons: [ZYDVerticalButton] = [ZYDVerticalButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = ["publish-video",
                      "publish-picture",
                      "publish-text",
                      "publish-audio",
                      "publish-review",
                      "publish-offline"]
        let titles = ["发视频",
                      "发图片",
                      "发段子",
                      "发声音",
                      "审帖",
                      "离线下载"]
        
        let maxCols: CGFloat = 3
    
        let buttonW: CGFloat = 72
        
        let buttonH = buttonW + 30
        
        let buttonMargn: CGFloat = 15
        
        let buttonSpace: CGFloat = (screenWidth - buttonW * maxCols - buttonMargn * 2) / (maxCols - 1)
        
        let startY: CGFloat = screenHeight / 2 - buttonW
        
        for i in 0...5 {
            let button = ZYDVerticalButton()
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setImage(UIImage(named: images[i]), for: .normal)
            
            let row = i / Int(maxCols)
            let col = CGFloat(i).truncatingRemainder(dividingBy: maxCols)
            
            button.frame = CGRect(x: buttonMargn + col * (buttonSpace + buttonW), y: startY + CGFloat(row) * (buttonH + buttonMargn), width: buttonW, height: buttonH)
            view.addSubview(button)
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            button.isHidden = true
            buttons.append(button)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i + 1) * 0.1, execute: {
                
                button.isHidden = false
                
                let spring = CASpringAnimation(keyPath: "position.y")
                // 阻尼系数， 越大，体制越快
                spring.damping = 10
                // 刚度系数，刚度系数越大，形变产生的力就越大，运动越快
                spring.stiffness = 100
                // 质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
                spring.mass = 1
                // 初始速度，动画试图的初始速度大小，速度为正数时，速度方向与运动方向一致，负数时，速度方向与运动方向相反
                spring.initialVelocity = 0
                spring.fromValue = row * (-30)
                spring.toValue = button.layer.position.y
                // 结算时间
                spring.duration = spring.settlingDuration
                button.layer.add(spring, forKey: spring.keyPath)
            })
            
        }
        
    }

    @IBAction func dissMissButton(_ sender: UIButton) {
        
        for i in 1...buttons.count {
            let button = buttons[i - 1]
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i) * 0.1, execute: {
                let spring = CASpringAnimation(keyPath: "position.y")
                spring.damping = 10
                spring.stiffness = 100
                spring.mass = 1
                spring.initialVelocity = 0
                spring.fromValue = button.layer.position.y
                spring.toValue = screenHeight + 100
                spring.duration = 1
                button.layer.add(spring, forKey: spring.keyPath)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + spring.duration, execute: {
                    button.isHidden = true
                })
                if i == self.buttons.count {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                        self.dismiss(animated: false, completion: nil)
                    })
                }
            })
        }
    }
    private func setupUI() {
        
    }
    
    @objc private func buttonClick(_ button: UIButton) {
        for i in 1...buttons.count {
            let button = buttons[i - 1]
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i) * 0.1, execute: {
                let spring = CASpringAnimation(keyPath: "position.y")
                spring.damping = 10
                spring.stiffness = 100
                spring.mass = 1
                spring.initialVelocity = 0
                spring.fromValue = button.layer.position.y
                spring.toValue = screenHeight + 100
                spring.duration = 1
                button.layer.add(spring, forKey: spring.keyPath)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + spring.duration, execute: {
                    button.isHidden = true
                })
                if i == self.buttons.count {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                        self.dismiss(animated: false, completion: {
                            // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
                            let root = UIApplication.shared.keyWindow?.rootViewController
                            let vc = ZYDPublishNavigationController(rootViewController: ZYDPublishTextViewController())
                            root?.present(vc, animated: true, completion: nil)
                            
                        })
                    })
                }
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    lazy var sloganImageView: UIImageView = {
        let image = UIImage(named: "app_slogan")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
}
