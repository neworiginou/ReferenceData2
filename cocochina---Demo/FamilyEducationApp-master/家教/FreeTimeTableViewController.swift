//
//  FreeTimeTableViewController.swift
//  家教
//
//  Created by goofygao on 15/10/21.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class FreeTimeTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        
    }

  //MARK: -初始化当前视图
    func initView() {
//        self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "kechengbiaoBg.png")!)
        /**
        *   画线
        */
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.lineWidth = 0.5
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPointMake(0, 95))
        bezier.addLineToPoint(CGPointMake(DeviceData.width, 95))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        bezier.moveToPoint(CGPointMake(30, 0))
        bezier.addLineToPoint(CGPointMake(30, DeviceData.height))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
        let monthLabel = UILabel()
        monthLabel.frame = CGRectMake(3, 65, 40, 30)
        monthLabel.textColor = UIColor.whiteColor()
        monthLabel.text = "11月"
        monthLabel.font = UIFont.systemFontOfSize(10)
        self.view.addSubview(monthLabel)
        
        for i in 1...6 {
            bezier.moveToPoint(CGPointMake(30 + ((DeviceData.width - 30)/7) * CGFloat(i), 0))
            print(((DeviceData.width )))
            bezier.addLineToPoint(CGPointMake(30 + ((DeviceData.width - 30)/7) * CGFloat(i), 95))
            shapeLayer.path = bezier.CGPath
            self.view.layer.addSublayer(shapeLayer)

        }
        
        for i in 1...4 {
           
            bezier.moveToPoint(CGPointMake(0, 95 + ((DeviceData.height - 95)/5) * CGFloat(i)))
            print(((DeviceData.width )))
            bezier.addLineToPoint(CGPointMake(30,95 + ((DeviceData.height - 95)/5) * CGFloat(i)))
            shapeLayer.path = bezier.CGPath
            self.view.layer.addSublayer(shapeLayer)
        }
        
        for i in 1...5 {
            //一天第几节课标记
            let courseLabel = UILabel()
            courseLabel.text = "\(i)"
            courseLabel.textColor = UIColor.whiteColor()
            courseLabel.frame = CGRectMake(10, 95 + ((DeviceData.height - 95)/5) * CGFloat(Double(i) - 0.55), 15, 15)
            self.view.addSubview(courseLabel)

        }
        
        for i in 1...7 {
            //一天第几节课标记
            let weekLabel = UILabel()
            let weekArray = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日"]
            weekLabel.font = UIFont.systemFontOfSize(10)
            weekLabel.text = "1              \(weekArray[i - 1])"
            weekLabel.numberOfLines = 0
            weekLabel.textColor = UIColor.whiteColor()
            weekLabel.frame = CGRectMake(30 + ((DeviceData.width - 30)/7) * CGFloat(Double(i) - 0.95), 55, 40, 40)
            self.view.addSubview(weekLabel)
            
        }
        
        
        self.createClass(4, whichClass: 1, courseName: "信号与系统@北主楼203")
        self.createClass(3, whichClass: 2, courseName: "计算机网络@北主楼301")
        self.createClass(1, whichClass: 1, courseName: "高等数学@北主楼303")
        self.createClass(5, whichClass: 4, courseName: "大学英语@黄浩川301")
        self.createClass(4, whichClass: 3, courseName: "linux系统@北主楼604")
        self.createClass(7, whichClass: 2, courseName: "信号与系统@北主楼203")
        self.createClass(2, whichClass: 1, courseName:  "密码学@北主楼203")
        self.createClass(2, whichClass: 3, courseName:  "信号与系统@北主楼203")
    }
    
    /**
     创建课程view
     
     - parameter whichWeekDay: 一周的第几天
     - parameter whichClass:   哪一节课 1、2、3、4、5
     - parameter courseName:   课程名字
     */
    func createClass(whichWeekDay:Int,whichClass:Int,courseName:String) {
        let bgView = UIView()
        bgView.frame.size = CGSizeMake(((DeviceData.width - 30)/7), (DeviceData.height - 95)/5)
        bgView.frame.origin = CGPointMake(30 + ((DeviceData.width - 30)/7) * CGFloat(whichWeekDay - 1) , 95 + ((DeviceData.height - 95)/5) * CGFloat(whichClass - 1))
        bgView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(bgView)
        
        let bgImageView = UIImageView(frame: bgView.bounds)
        let randNum = arc4random_uniform(15)
        bgImageView.image = UIImage(named: NSString(format: "ic_week_course_half_bg_%d", randNum) as String)
        bgView.addSubview(bgImageView)
        
        let courseNameTittle = UILabel(frame: bgView.bounds)
        courseNameTittle.text = courseName
        courseNameTittle.font = UIFont.systemFontOfSize(12)
        courseNameTittle.textColor = UIColor.whiteColor()
        courseNameTittle.numberOfLines = 3
        bgImageView.addSubview(courseNameTittle)
    }

}









