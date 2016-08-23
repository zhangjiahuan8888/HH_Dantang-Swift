//
//  HHCommon.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//


import UIKit

/// 屏幕的宽
let KSCREENWIDTH = UIScreen.mainScreen().bounds.size.width
/// 屏幕的高
let KSCREENHEIGHT = UIScreen.mainScreen().bounds.size.height

/// RGBA的颜色设置
func HHColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func HHGlobalColor() -> UIColor {
    return HHColor(240, g: 240, b: 240, a: 1)
}

/// 红色
func HHGlobalRedColor() -> UIColor {
    return HHColor(245, g: 80, b: 83, a: 1.0)
}

/// 服务器地址
let BASE_URL = "http://api.dantangapp.com/"

/*
static NSString *const kGoTopNotificationName = @"goTop";//进入置顶命令
static NSString *const kLeaveTopNotificationName = @"leaveTop";//离开置顶命令
static CGFloat const kTopBarHeight = 60.;
static CGFloat const kBottomBarHeight = 60.;
static CGFloat const kTabTitleViewHeight = 45.;
 */

/// 间距
let kMargin: CGFloat = 10.0
/// 我的界面头部图像的高度
let kYMMineHeaderImageHeight: CGFloat = 200


let kGoTopNotificationName = "goTop"
let kLeaveTopNotificationName = "leaveTop"
let kBottomBarHeight = 60
let kTabTitleViewHeight:CGFloat = 45