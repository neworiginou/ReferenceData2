//
//  FamilyInfoViewController.swift
//  家教
//
//  Created by goofygao on 15/11/18.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class FamilyInfoViewController: UIViewController {

    let defaultValue = NSUserDefaults.standardUserDefaults()
    let personalInfoLabelUserName = UILabel()
    let personalInfoLabelStuID = UILabel()
    var avaterImageView = UIImageView()
    let personalInfoLabelstuIntro = UILabel()
    let personalInfoLabelCollectTimes = UILabel()
     let personalInfoLabelMoney = UILabel()
    let personalInfoLabelCanTeach = UILabel()
    let personalInfoLabelAddress = UILabel()
    let personalInfoLabelStar = UILabel()
    let personalInfoLabelPhoneNumber = UILabel()
    let personalInfoLabelFreeTime = UILabel()
     let personalInfoLabelRealSign = UILabel()
    let personalInfoLabelFamilyTime = UILabel()
//    let personalInfoLabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let familyEducationData = defaultValue.valueForKey("stu_age")
        initView()
        
        
    }
    
    /**
     初始化界面
     
     - returns: 无返回值
     */
    func initView() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "详细信息"
        avaterImageView = UIImageView(frame: CGRectMake(DeviceData.width * 1/7, 30, 60, 60))
        avaterImageView.layer.cornerRadius = avaterImageView.bounds.width/2
        avaterImageView.layer.masksToBounds = true
        avaterImageView.image = UIImage(named: "touxiang.png")
        self.view.addSubview(avaterImageView)
        
        personalInfoLabelUserName.frame = CGRectMake(DeviceData.width * 1/7 + 80, 40, DeviceData.width * 4/7, 21)
//        personalInfoLabel.tintColor = UIColor.whiteColor()
        personalInfoLabelUserName.text = "用户名: " + "\(defaultValue.valueForKey("username")!)"
        personalInfoLabelUserName.textColor = UIColor.whiteColor()
        personalInfoLabelUserName.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(personalInfoLabelUserName)
        
        personalInfoLabelStuID.frame = CGRectMake(DeviceData.width * 1/7 + 80, 68, DeviceData.width * 4/7, 21)
        personalInfoLabelStuID.text = "用户ID: " + "\(defaultValue.valueForKey("stu_id")!)"
        personalInfoLabelStuID.textColor = UIColor.whiteColor()
        personalInfoLabelStuID.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(personalInfoLabelStuID)
        
        
//        personalInfoLabelstuIntro.translatesAutoresizingMaskIntoConstraints = false
        personalInfoLabelstuIntro.frame = CGRectMake(CGRectGetMinX(avaterImageView.frame), CGRectGetMaxY(avaterImageView.frame),DeviceData.width - CGRectGetMinX(avaterImageView.frame) - 20, 50)
 
        personalInfoLabelstuIntro.text = "介绍: " + "\(defaultValue.valueForKey("stu_intro")!)"
        personalInfoLabelstuIntro.textColor = UIColor.whiteColor()
        personalInfoLabelstuIntro.font = UIFont.systemFontOfSize(12)
        personalInfoLabelstuIntro.numberOfLines = 0
        self.view.addSubview(personalInfoLabelstuIntro)
        
        personalInfoLabelCollectTimes.frame = CGRectMake(CGRectGetMinX(avaterImageView.frame), CGRectGetMaxY(personalInfoLabelstuIntro.frame),DeviceData.width - CGRectGetMinX(avaterImageView.frame) - 20, 21)
        
        personalInfoLabelCollectTimes.text = "收藏次数: " + "\(defaultValue.valueForKey("stu_collect")!)"
        personalInfoLabelCollectTimes.textColor = UIColor.whiteColor()
        personalInfoLabelCollectTimes.font = UIFont.systemFontOfSize(12)
        personalInfoLabelCollectTimes.numberOfLines = 0
        self.view.addSubview(personalInfoLabelCollectTimes)
        
        personalInfoLabelMoney.frame = CGRectMake(CGRectGetMinX(personalInfoLabelCollectTimes.frame), CGRectGetMaxY(personalInfoLabelCollectTimes.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelCollectTimes.frame) - 20, 21)
        
        personalInfoLabelMoney.text = "要求薪水区间: " + "\(defaultValue.valueForKey("stu_bcost")!) ~ " +  "\(defaultValue.valueForKey("stu_lcost")!)元"
        personalInfoLabelMoney.textColor = UIColor.whiteColor()
        personalInfoLabelMoney.font = UIFont.systemFontOfSize(12)
        personalInfoLabelMoney.numberOfLines = 0
        self.view.addSubview(personalInfoLabelMoney)
        
        personalInfoLabelCanTeach.frame = CGRectMake(CGRectGetMinX(personalInfoLabelMoney.frame), CGRectGetMaxY(personalInfoLabelMoney.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelMoney.frame) - 20, 21)
        
        personalInfoLabelCanTeach.text = "可任教科目: " + "\(defaultValue.valueForKey("stu_course")!)"
        personalInfoLabelCanTeach.textColor = UIColor.whiteColor()
        personalInfoLabelCanTeach.font = UIFont.systemFontOfSize(12)
        personalInfoLabelCanTeach.numberOfLines = 0
        self.view.addSubview(personalInfoLabelCanTeach)
        
        personalInfoLabelAddress.frame = CGRectMake(CGRectGetMinX(personalInfoLabelCanTeach.frame), CGRectGetMaxY(personalInfoLabelCanTeach.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelCanTeach.frame) - 20, 21)
        
        personalInfoLabelAddress.text = "学生地址: " + "\(defaultValue.valueForKey("stu_addr")!)"
        personalInfoLabelAddress.textColor = UIColor.whiteColor()
        personalInfoLabelAddress.font = UIFont.systemFontOfSize(12)
        personalInfoLabelAddress.numberOfLines = 0
        self.view.addSubview(personalInfoLabelAddress)
        
        personalInfoLabelStar.frame = CGRectMake(CGRectGetMinX(personalInfoLabelAddress.frame), CGRectGetMaxY(personalInfoLabelAddress.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelAddress.frame) - 20, 21)
        
        personalInfoLabelStar.text = "星级: " + "\(defaultValue.valueForKey("stu_star")!)"
        personalInfoLabelStar.textColor = UIColor.whiteColor()
        personalInfoLabelStar.font = UIFont.systemFontOfSize(12)
        personalInfoLabelStar.numberOfLines = 0
        self.view.addSubview(personalInfoLabelStar)
        
        personalInfoLabelPhoneNumber.frame = CGRectMake(CGRectGetMinX(personalInfoLabelStar.frame), CGRectGetMaxY(personalInfoLabelStar.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelStar.frame) - 20, 21)
        
        personalInfoLabelPhoneNumber.text = "电话: " + "\(defaultValue.valueForKey("stu_num")!)"
        personalInfoLabelPhoneNumber.textColor = UIColor.whiteColor()
        personalInfoLabelPhoneNumber.font = UIFont.systemFontOfSize(12)
        personalInfoLabelPhoneNumber.numberOfLines = 0
        self.view.addSubview(personalInfoLabelPhoneNumber)
        
        personalInfoLabelFreeTime.frame = CGRectMake(CGRectGetMinX(personalInfoLabelPhoneNumber.frame), CGRectGetMaxY(personalInfoLabelPhoneNumber.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelPhoneNumber.frame) - 20, 21)
        
        personalInfoLabelFreeTime.text = "空闲时间: " + "\(defaultValue.valueForKey("free_time")!)"
        personalInfoLabelFreeTime.textColor = UIColor.whiteColor()
        personalInfoLabelFreeTime.font = UIFont.systemFontOfSize(12)
        personalInfoLabelFreeTime.numberOfLines = 0
        self.view.addSubview(personalInfoLabelFreeTime)
        
        personalInfoLabelRealSign.frame = CGRectMake(CGRectGetMinX(personalInfoLabelFreeTime.frame), CGRectGetMaxY(personalInfoLabelFreeTime.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelFreeTime.frame) - 20, 21)
        let temFreeTime = "\(defaultValue.valueForKey("real_sign")!)"
        if  temFreeTime  == "0" {
            personalInfoLabelRealSign.text = "实名注册: 未实名认证"
        } else {
            personalInfoLabelRealSign.text = "实名注册: 已实名认证"
        }
        
        personalInfoLabelRealSign.textColor = UIColor.whiteColor()
        personalInfoLabelRealSign.font = UIFont.systemFontOfSize(12)
        personalInfoLabelRealSign.numberOfLines = 0
        self.view.addSubview(personalInfoLabelRealSign)
        
        personalInfoLabelFamilyTime.frame = CGRectMake(CGRectGetMinX(personalInfoLabelRealSign.frame), CGRectGetMaxY(personalInfoLabelRealSign.frame),DeviceData.width - CGRectGetMinX(personalInfoLabelRealSign.frame) - 20, 21)
        personalInfoLabelFamilyTime.text = "家教次数: \(defaultValue.valueForKey("volTime")!)次"
        personalInfoLabelFamilyTime.textColor = UIColor.whiteColor()
        personalInfoLabelFamilyTime.font = UIFont.systemFontOfSize(12)
        personalInfoLabelFamilyTime.numberOfLines = 0
        self.view.addSubview(personalInfoLabelFamilyTime)
        
        

    }
    
    
    
    
}
