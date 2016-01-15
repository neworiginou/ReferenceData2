//
//  Define.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：全局定义类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation
    
// MARK: 友盟key

let UMENG_APP_KEY: NSString! = "538beda456240ba944134784"                   //友盟
let WECHAT_KEY: NSString! = "wxfbb227bd73547d75"                            //微信     wx957310cb04aee1be
let WECHAT_SECRET: NSString! = "91eca39ca6395c6624ced8a534258937"

//let QZONE_APPID: NSString! = "1102968215"
//let QZONE_APPKEY: NSString! = "zdmD0aAtpAhEoNLy"
let kAutoLogin:String = "autoLogin"
let JPush_APPKEY: NSString! = "9b7930d4c9b1d3a1f8af4e19"                    //极光推送key


//  MARK: 设备

let iOS7: Bool = NSString(string: UIDevice.currentDevice().systemVersion).floatValue >= 7.0 ? true : false
let iOS8: Bool = NSString(string: UIDevice.currentDevice().systemVersion).floatValue >= 8.0 ? true : false

let iPhone6: Bool = UIScreen.instancesRespondToSelector(Selector("currentMode")) ? CGSizeEqualToSize(CGSizeMake(750, 1334), UIScreen.mainScreen().currentMode!.size) : false
let iPhone6plus: Bool = UIScreen.instancesRespondToSelector(Selector("currentMode")) ?
    (
    CGSizeEqualToSize(CGSizeMake(1242, 2208), UIScreen.mainScreen().currentMode!.size)
    )
    :false
let iPhone6plusFangDa:Bool =  UIScreen.instancesRespondToSelector(Selector("currentMode")) ?
    (
            CGSizeEqualToSize(CGSizeMake(1125, 2001), UIScreen.mainScreen().currentMode!.size)
    )
    :false

let iPhone5: Bool = UIScreen.instancesRespondToSelector(Selector("currentMode")) ? CGSizeEqualToSize(CGSizeMake(640, 1136), UIScreen.mainScreen().currentMode!.size) : false
let iPhone4:Bool = UIScreen.instancesRespondToSelector(Selector("currentMode")) ? CGSizeEqualToSize(CGSizeMake(640,960), UIScreen.mainScreen().currentMode!.size) : false

// MARK: 方法
let shareAppDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
let documentPath: NSString = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).objectAtIndex(0) as NSString

let contentHeight: CGFloat = (UIScreen.mainScreen().bounds.size.height - 64)
let kScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
let kScreenRate: CGFloat = UIScreen.mainScreen().bounds.size.width / 375.0 // 屏幕比例
let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height//MYP add

let kScreenReverseRate: CGFloat = UIScreen.mainScreen().bounds.size.width / 375.0//相对于6屏幕尺寸的比例
let kScreen4SRate:CGFloat = UIScreen.mainScreen().bounds.width/320;
let kScreenHeightRate:CGFloat = (UIScreen.mainScreen().bounds.height-20)/647;
let kScreen6Rate:CGFloat = 1334/1136;
let kScreen6PRate:CGFloat = 1920/1136;
let kRate: CGFloat = iPhone6plus ? 1 : 1

// 线的固定比例 不与布局比例共用
let x3Rate: CGFloat = iPhone6plus ? 1.5 : 1
let lineHeight: CGFloat = 0.5 * x3Rate

let kPageCount: Int = 10  // 一页的数量

class Define: NSObject
{
    class func font(size: CGFloat) -> UIFont
    {
        return UIFont(name: "Helvetica Neue", size: size)!
    }
}


let appID: NSString! = ""
let ITUNSE_DOWNLOAD_URL: NSString! = ""
let kNotificationSwitch :NSString! = "notificationswitch"   // 推送开关  0 : 关  1：开

//MARK:修改用户名之类的通知
 let kUpdateUserInfo = "Notify_UpdateUserInfo" //修改姓名，修改性别的通知
 let kGetUserInfo = "Notify_getUserInfo" // 获取个人信息的通知
 let kGetIntegral = "Notify_getIntegral"        //积分变更的通知

// MARK: 颜色
                //CD前缀 For ColorDefine

//大背景色
let CD_BackGroundColor:UIColor!       = "#f5f5f5".UIColor//大背景色

//主色调
let CD_MainColor:UIColor!             = "#ff6600".UIColor//主色调 红黄色？叫不出来名字哈

//辅助色
let CD_GreenColor:UIColor!            = "#37ca6b".UIColor//绿色
let CD_GreenLigthColor:UIColor!       = "#36d7d7".UIColor//浅绿色
let CD_OrangeColor:UIColor!           = "#f89e00".UIColor//橙色
let CD_RedLightColor:UIColor!         = "#f34d4d".UIColor//浅红色
let CD_RedDeepColor:UIColor!          = "#e40500".UIColor//深红色
let CD_BlueColor:UIColor!             = "#55b5ff".UIColor//亮蓝色
let CD_GrayColor:UIColor!             = "#eaeaea".UIColor//灰色
let CD_WhiteColor:UIColor!            = "#ffffff".UIColor//白色

let CD_OrangeRobColor:UIColor!        = "#ff6600".UIColor
let CD_YellowLightColor:UIColor       = "#fecf54".UIColor//浅黄色
let CD_RedPaperColor:UIColor          = "#e22c1e".UIColor//刮红包的背景色
//线条颜色
let CD_LineColor:UIColor!             = "#d7d7d7".UIColor//线条色
let CD_LoginLineColor:UIColor         = "f4ccb2".UIColor
//按钮颜色
let CD_Btn_MainColor:UIColor!         = "#ff6600".UIColor//主色调
let CD_Btn_MainColor_Clicked:UIColor! = "#e85700".UIColor//主色调点击色
let CD_Btn_GreenColor:UIColor!        = "#37ca6b".UIColor//绿色
let CD_Btn_GrayColor:UIColor!         = "#999999".UIColor//深灰色
let CD_Btn_WhiteColor:UIColor!        = "#ffffff".UIColor//白色
let CD_Btn_GrayColor_Clicked:UIColor! = "#878787".UIColor//灰色点击色

//文字颜色 灰度
let CD_Txt_Color_00:UIColor!          = "#000000".UIColor//黑色
let CD_Txt_Color_33:UIColor!          = "#333333".UIColor//灰色
let CD_Txt_Color_66:UIColor!          = "#666666".UIColor//深灰
let CD_Txt_Color_99:UIColor!          = "#999999".UIColor//浅灰
let CD_Txt_Color_ff:UIColor!          = "#ffffff".UIColor//白色
let CD_Txt_MainColor:UIColor!         = "#ff6600".UIColor//主色调
let CD_Txt_CancelBtn:UIColor!         = "#2d86ef".UIColor//系统弹窗按钮蓝色
let CD_txt_Red:UIColor!               = "#d33735".UIColor
// MARK: 字体大小
                //TF前缀 For TextFont

//通用
let TF_50:CGFloat            = 50.0
let TF_40:CGFloat            = 40.0
let TF_30:CGFloat!           = 30.0
let TF_22:CGFloat!           = 22.0
let TF_19:CGFloat!           = 19.0
let TF_18:CGFloat!           = 18.0
let TF_16:CGFloat!           = 16.0
let TF_15:CGFloat!           = 15.0
let TF_14:CGFloat!           = 14.0
let TF_13:CGFloat!           = 13.0
let TF_12:CGFloat!           = 12.0
let TF_11:CGFloat!           = 11.0

//kit列出的
let TF_Btn_Title_19:CGFloat! = 19.0 //按钮标题
let TF_Text_15:CGFloat!      = 15.0 //主文字
let TF_Small_12:CGFloat!     = 12.0 //小字
let TF_SSmall_11:CGFloat!    = 11.0 //超小字



// MARK: Placeholder

let placeHolderBigImage: String! = "pic_wait_big"     // 加载时的placeholder
let placeHolderSmallImage: String! = "pic_wait_small"     // 加载时的placeholder
let failedBigImage: String! = "pic_wait_big_no"          // 加载失败时的placeholder
let failedSmallImage: String! = "pic_wait_small_no"          // 加载失败时的placeholder
let headPlaceHolderImage: UIImage! = UIImage(named: "personal_1") // 头像加载的placeholder 或 默认头像
let headFailedImage: UIImage! = UIImage(named: "personal_1")      // 头像加载失败

// MARK: NSNotification

let kReverseGeocodeNotification: String = "reverseGeocodeNotification"
let kLocationSuccessNotification: String = "locationSuccessNotification"
let kLocationFailNotification: String = "locationFailNotification"

// NSUserDefault

let kLastLoginTel = "lastLoginTel"
let kLastLoginPicKey = "lastLoginPicKey"
let kLastLoginRole = "lastLoginRole"

let kRobCustomerNotification: String = "robCustomerNotification"
let kRefershHomePageNotification: String = "kRefershHomePageNotification"

let kRefershChatListNotification:String = "refershChatListNotification";

