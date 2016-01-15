//
//  HWCalendarViewController.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的积分签到页面
//
//  魏远林  2015-02-28    创建文件
//
//

import UIKit

class HWCalendarViewController: HWBaseViewController,VRGCalendarViewDelegate
{
    var calendarView:VRGCalendarView!
    var scrollView:UIScrollView!
    var confirmBtn:UIButton!
    var headInfoLabel:UILabel!
    var continousStr:String!
    var totalStr:String!
    var headInfoAtt:NSMutableAttributedString!
    var mounthStr:String!
    var detailArr:[NSNumber]!//存放需要标记的签到日期
    var dateDic:Dictionary<String, String>?
    var integraDic:NSDictionary!
    var targetHeightF:Float!
    var btnTitle:String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("签到")
        self.view.backgroundColor = CD_BackGroundColor
        
        self.detailArr = Array()

        scrollView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        scrollView.contentSize = CGSizeMake(kScreenWidth, contentHeight)
        scrollView.backgroundColor = UIColor.clearColor()
//        scrollView.drawTopLine()
        self.view.addSubview(scrollView)
        
        self.creatHeadInfoView()
        self.creatCalendarView()
        
    }
    
    //MARK: 创建头视图
    func creatHeadInfoView()
    {
        var headerView = UIView(frame: CGRectMake(0, 10 , kScreenWidth, 60 ))
        headerView.backgroundColor = CD_Txt_Color_ff
        headerView.drawTopLine()
        headerView.drawBottomLine()
        scrollView.addSubview(headerView)
        
        var iconImgV = UIImageView(frame: CGRectMake(15 , 7.5 , 45 , 45 ))
        iconImgV.image = UIImage(named: "registration1")
        iconImgV.contentMode = UIViewContentMode.ScaleAspectFit
        headerView.addSubview(iconImgV)
        
        headInfoLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(iconImgV.frame) + 10 , 18 , kScreenWidth - 45  - 10, 15 ))
        headInfoLabel.font = Define.font(15)
        headInfoLabel.textColor = CD_Txt_Color_00
        headInfoLabel.backgroundColor = UIColor.clearColor()
        headerView.addSubview(headInfoLabel)
    }
    
    //MARK: 创建日历视图
    func creatCalendarView()
    {
        var backgroundView = UIView(frame: CGRectMake(0, 80 , kScreenWidth, (262  + 5) ))
        backgroundView.backgroundColor = UIColor.whiteColor()
        backgroundView.drawTopLine()
        backgroundView.drawBottomLine()
        scrollView.addSubview(backgroundView)
        
//        var calendarBackView = UIView(frame: CGRectMake(15 , 10 , kScreenWidth - 15 * 2 , backgroundView.frame.size.height - 10 * 2 ))
//        calendarBackView.backgroundColor = UIColor.redColor()
//        backgroundView.addSubview(calendarBackView)
        
        calendarView = VRGCalendarView()
        calendarView.frame = CGRectMake(15 , 10 , kScreenWidth - 15 * 2 , backgroundView.frame.size.height - 10 * 2 )
        calendarView.delegate = self
        calendarView.backgroundColor = UIColor.clearColor()
        backgroundView.addSubview(calendarView)
        
        confirmBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        confirmBtn.backgroundColor = UIColor.clearColor()
        confirmBtn.frame = CGRectMake(15 ,CGRectGetMaxY(backgroundView.frame) + 20 , kScreenWidth - 15 * 2 , 45 )
        confirmBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
       
        confirmBtn.addTarget(self, action: "todaySignIn", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(confirmBtn)
        scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(confirmBtn.frame) + 20)
        scrollView.bounces = true
        
    }
    
    
    //MARK: 今日签到
    func todaySignIn()
    {
        //埋点：点击签到
        MobClick.event("Sign in_click")
        
        var param = ["key":HWUserLogin.currentUserLogin().key]
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kBrokerIntegral, parameters: param, queue: nil, success: { (responseObject) -> Void in
        var dataStr = responseObject.stringObjectForKey("data") as String
        if dataStr == "签到成功"
        {
            NSNotificationCenter.defaultCenter().postNotificationName(kGetIntegral, object: nil)
            var dateForamet = NSDateFormatter()
            dateForamet.dateFormat = "yyyy-MM-dd"
            var todayDate = NSDate()
//            println(todayDate)
            var todayDateStr = dateForamet.stringFromDate(todayDate) as NSString
            var todayYear = todayDateStr.substringWithRange(NSMakeRange(0, 4)) as NSString
            var todayMonth = todayDateStr.substringWithRange(NSMakeRange(5, 2)) as NSString
            self.calendarView(self.calendarView, switchedToYear: todayYear.intValue, switchedToMonth: todayMonth.intValue, targetHeight: self.targetHeightF, animated: true)

            //创建一个动画，球形加速放大并下落
            var integraLab = UILabel()
            integraLab.text = "+\(self.btnTitle)"
            integraLab.backgroundColor = CD_MainColor
            integraLab.textColor = CD_Txt_Color_ff
            integraLab.font = Define.font(12) 
            integraLab.frame = CGRectMake((kScreenWidth - 50) / 2, 20, 50, 50)
            integraLab.textAlignment = NSTextAlignment.Center
            integraLab.layer.cornerRadius = 25
            integraLab.layer.masksToBounds = true
            integraLab.clipsToBounds = true
            integraLab.center = CGPoint(x: kScreenWidth/2, y: contentHeight/2)
            self.view.addSubview(integraLab)
            self.view.bringSubviewToFront(integraLab)

            var center:CGPoint = integraLab.center
            UIView.animateWithDuration(1, animations: { () -> Void in
                integraLab.transform = CGAffineTransformMakeScale(2, 2)
                UIView.setAnimationCurve(UIViewAnimationCurve.Linear)
            }, completion: { (finished) -> Void in
                if finished
                {
                    var labelTxt = "+\(self.btnTitle!)"
                    var attStr:NSMutableAttributedString = NSMutableAttributedString(string: labelTxt)
                    attStr.addAttribute(NSFontAttributeName, value: Define.font(20), range: NSMakeRange(1, countElements(labelTxt) - 1))
                    integraLab.font = Define.font(10)
                    integraLab.attributedText = attStr
                    Utility.delay(seconds: 2.0, completion: { () -> () in
                        integraLab.removeFromSuperview()
                    })
                }
            })
        }
        else
        {
            Utility.showToastWithMessage("签到失败", _view: self.view)
        }
        }) { (failure, error) -> Void in
            Utility.showToastWithMessage(error, _view: self.view)
        }
        
    }
    
    //MARK: VRGCalendar Delegate
    func calendarView(calendarView: VRGCalendarView!, switchedToYear year: Int32, switchedToMonth month: Int32, targetHeight: Float, animated: Bool)
    {
//        println(targetHeight)
        targetHeightF = targetHeight
        Utility.showMBProgress(self.view, _message: "数据加载中")
        var param = ["key":HWUserLogin.currentUserLogin().key]
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kIntegrationInfo, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view)
//
//        var responseObject = ["data":["continueNum":"9", "currMonthNum":"20", "signInDays":"2014-01-09,2014-12-11,2014-12-12,2014-12-10,2014-12-09,2014-12-06,2014-12-02,2015-02-04,2015-02-22,2015-02-28,2015-03-01,2015-03-05,2015-03-11,2015-03-25", "integrate":"8", "todayIsReguest":"true"]] as NSDictionary
//            println(responseObject)
        self.integraDic = responseObject.dictionaryObjectForKey("data") as NSDictionary
        //取得标记已签到的日期，返回的是一个字符串
        var dateArr = self.integraDic.arrayObjectForKey("signInDays") as NSArray
        var date:NSNumber! = NSNumber()
        if self.detailArr.count > 0
        {
            self.detailArr.removeAll(keepCapacity: true)
        }
//            println(dateArr)
        for date in dateArr
        {
//            println(date)
            var dateTime: NSString = Utility.getTimeWithTimestamp("\(date)" as NSString, dateFormatStr: "yyyy-MM-dd")
            
//            println(dateTime)
            var yearStr = dateTime.substringWithRange(NSMakeRange(0, 4)) as String
            var monthStr = dateTime.substringWithRange(NSMakeRange(5, 2)) as String
            var dayStr = dateTime.substringWithRange(NSMakeRange(8, 2)) as NSString
            var monStr:String!
            if month < 10
            {
                monStr = "0\(month)"
            }
            else
            {
                monStr = "\(month)"
            }
//            println("year\(year)","month\(monStr)")
//            println("yearStr\(yearStr)","monthStr\(monthStr)")
            if yearStr == "\(year)" && monthStr == monStr
            {
                var dayNumber = NSNumber(int: dayStr.intValue)
                self.detailArr.append(dayNumber)
            }
        }
//        println(self.detailArr)
            self.calendarView.markDates(self.detailArr)
            //表头数据更新->连续签到、总签到
            self.continousStr = self.integraDic.stringObjectForKey("continueNum") as String
            self.totalStr = self.integraDic.stringObjectForKey("currMonthNum") as String
            self.headInfoLabel.text = "连续签到\(self.continousStr)天， 本月累计签到\(self.totalStr)天"
            self.headInfoAtt = NSMutableAttributedString(string: self.headInfoLabel.text!)
            self.headInfoAtt.addAttribute(NSForegroundColorAttributeName, value: CD_OrangeColor, range: NSMakeRange(4, countElements(self.continousStr)))
            self.headInfoAtt.addAttribute(NSForegroundColorAttributeName, value: CD_OrangeColor, range: NSMakeRange(13 + countElements(self.continousStr), countElements(self.totalStr)))
            self.headInfoLabel.attributedText = self.headInfoAtt
            
        var todayIsRequest = self.integraDic.stringObjectForKey("todayIsReguest") as String
            //更改给未签到，调试动画
        if todayIsRequest == "false"
        {
            //获取签到按钮可获得积分数
            self.btnTitle = self.integraDic.stringObjectForKey("integrate") as String
            self.confirmBtn.setTitle("签到+\(self.btnTitle)积分", forState: UIControlState.Normal)
            //按钮设置为可点击
            self.confirmBtn.userInteractionEnabled = true
            self.confirmBtn.setButtonRedAndOrangeBorderStyle()
        }
        else
        {
            self.confirmBtn.userInteractionEnabled = false
            self.confirmBtn.setTitle("已签到", forState: UIControlState.Normal)
            self.confirmBtn.setButtonGrayStyle()
        }
            
        }) { (failure, error) -> Void in
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage(error, _view: self.view)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
