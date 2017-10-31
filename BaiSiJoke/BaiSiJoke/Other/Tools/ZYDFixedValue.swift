//
//  ZYDFixedValue.swift
//  BaiSiJoke
//
//  Created by zhangyu on 2017/9/19.
//  Copyright © 2017年 zhangyu. All rights reserved.
//

import UIKit

let cellMargin: CGFloat = 30

let cellTextMargin: CGFloat = 10

let cellHeaderHeiht: CGFloat = 50 + 5 + 10

let cellFooterHeiht: CGFloat = 44 + 10

let screenWidth = UIScreen.main.bounds.width

let screenHeight = UIScreen.main.bounds.height

let cellImageMaxH: CGFloat = 1500

let cellImageBreakH: CGFloat = 250

let ZYDNavigationBarHeight: CGFloat = 44.0
/**
 
 iPhoneX的可布局范围是734（包括TabBar的高度 44 和navigationBar的高度 44， 不包括statusBar的高度），正常机型的尺寸是（height - 20）的可布局范围，不包括statusBar，这样812 - 734 = 78，多出来的内容，78 - 34（底下的内容是34） = 44，上面多出来的的是44，44 - 20（statusBar的高度） = 24 ，24 是上面多出来的内容。
 
*/
let iPhoneXHeight: CGFloat = 812

let iPhoneXTopHeight: CGFloat = 24

let iPhoneXBottomHeight: CGFloat = 34

let ZYDSelectTabberNotification = Notification.Name(rawValue: "ZYDSelectTabberNotification")
