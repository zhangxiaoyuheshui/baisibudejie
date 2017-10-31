//
//  ZYDAddTagViewController.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/10/31.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

class ZYDAddTagViewController: UIViewController {

    
    var tagButtons: [ZYDPublishTagButton] = [ZYDPublishTagButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNav()
        setupView()
    }

    private func setupNav() {
        
        navigationItem.titleView = ZYDPublishNavigationController.titleView(titile: "发表文字", font: UIFont.systemFont(ofSize: 17), color: UIColor.black)
        navigationItem.leftBarButtonItem = ZYDPublishNavigationController.itemButton(title: "返回", self, #selector(cancel)).0
        let rightBarButtonWithButton = ZYDPublishNavigationController.itemButton(title: "完成", self, #selector(post))
        navigationItem.rightBarButtonItem = rightBarButtonWithButton.0
        
    }

    func setupView() {
        textField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")

        let btn1 = ZYDPublishTagButton.init(true)
        btn1.setTitle("搞笑", for: .normal)
        let btn2 = ZYDPublishTagButton.init(true)
        btn2.setTitle("糗事", for: .normal)
        
        // 3.计算button的位置
        tagButtons.append(btn1)
        tagButtons.append(btn2)
        
       let _ = setTagButtonsFrame(tagButtons)
    }
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func post() {
        
        
    }

    private func setTagButtonsFrame(_ buttons: [ZYDPublishTagButton]) -> CGFloat {
        
        let maxWidth = (screenWidth - cellTextMargin * 2)
        
        var maxHeight: CGFloat = 40.0
        
        let buttonHeight: CGFloat = 40.0
        
        let y: CGFloat = 5 + 64 + 24
        for i in 0..<buttons.count  {
            
            let button = buttons[i]
            var width = button.titleLabel!.text!.width(CGSize(width: 1000.0, height: 40.0), [NSFontAttributeName: button.titleLabel?.font ?? UIFont.systemFont(ofSize: 15.0)])
            
            width += (cellTextMargin + 18)
            
            if width > maxWidth {
                width = maxWidth
            }
            
            if i == 0 {
                button.frame = CGRect(x: cellTextMargin, y: y, width: width, height: buttonHeight - cellTextMargin)
            } else {
                let previousButton = buttons[i - 1]
                let previousButtonMaxX = previousButton.frame.maxX
                if  previousButtonMaxX + width > maxWidth{
                    button.frame = CGRect(x: cellTextMargin, y: maxHeight + y, width: width, height: buttonHeight - cellTextMargin)
                    maxHeight += buttonHeight
                } else {
                    button.frame = CGRect(x: previousButtonMaxX + 10, y: maxHeight - buttonHeight + y, width: width, height: buttonHeight - cellTextMargin)
                }
            }
            
            if i == buttons.count - 1 {
                let previousButton = buttons[i]
                let previousButtonMaxX = previousButton.frame.maxX
                let placehoderTextW = textField.placeholder!.width(CGSize(width: 1000.0, height: 40.0), [NSFontAttributeName: button.titleLabel!.font])
                let textW = textField.text!.width(CGSize(width: 1000.0, height: 40.0), [NSFontAttributeName: button.titleLabel!.font])

                let txFieldWidth: CGFloat = textField.text!.isEmpty ? placehoderTextW : textW
                
                if (previousButtonMaxX + txFieldWidth) > maxWidth {
                    textField.frame = CGRect(x: cellTextMargin, y: maxHeight + y, width: txFieldWidth, height: 30)
                    maxHeight += buttonHeight
                }
                else {
                    textField.frame = CGRect(x: previousButtonMaxX + 10, y: maxHeight - buttonHeight + y, width: maxWidth, height: 30)
                }
                view.addSubview(textField)
            }
            view.addSubview(button)
            print(button)
        }
        return maxHeight + buttonHeight
    }

    @objc private func textChange(_ textField: UITextField) {
        let h = setTagButtonsFrame(tagButtons)
        if textField.text!.isEmpty {
            tagLabel.isHidden = true
            return
        }
        tagLabel.isHidden = false
        tagLabel.frame = CGRect(x: 0, y: h + 5 + 40, width: screenWidth, height: 40)
        tagLabel.text = "添加标签:" + textField.text!
        print(tagLabel)
    }
    // MARK: - 控件

    fileprivate func addButton() {
        let btn = ZYDPublishTagButton.init(true)
        btn.setTitle(textField.text, for: .normal)

        tagButtons.append(btn)
        textField.text = "" // 清空
        let _ = setTagButtonsFrame(tagButtons)

        tagLabel.isHidden = true
    }
    
    
    // MARK: - 控件
    lazy var textField: UITextField = {
        let tx = UITextField()
        tx.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        tx.placeholder = "多个标签用逗号或者换行隔开"
        tx.addTarget(self, action: #selector(textChange(_:)), for: .editingChanged)
        tx.font = UIFont.systemFont(ofSize: 15.0)
        tx.delegate = self
        return tx
    }()

    lazy var tagLabel: UILabel = {
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        l.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        l.textColor = UIColor.white
        l.font = UIFont.systemFont(ofSize: 15.0)
        l.isHidden = true
        self.view.addSubview(l)
        return l
    }()
}

extension ZYDAddTagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.hasText {
            addButton()
        }
        
        return true
    }
}
