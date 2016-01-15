//
//  HWMyIntegrationViewController.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的积分页面
//
//  魏远林  2015-02-27    创建
//
//

import UIKit

class HWMyIntegrationViewController: HWBaseViewController, HWIntegrationFitViewDelegate,HWMyIntegrationTableViewDelegate
{
    var fitIntegrationLabel:UILabel!
//    var fitterView:CustomSearchView!
    var integraLabel:UILabel!
    var signButton:UIButton!
    var fitView:UIView!
    var titlesArr:[String]!
    var button:UIButton!
    var fitListView:HWIntegrationFitView!
    var fitIntegrationTV:HWMyIntegrationTableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("我的积分")
        self.view.backgroundColor = CD_BackGroundColor
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeIntegral", name: kGetIntegral, object: nil)
        self.creatHeaderView()
        self.creatFitterView()
    }
    
    func changeIntegral()
    {
        fitIntegrationTV.queryListData()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kGetIntegral, object: nil)
    }

    //MARK: 创建头视图
    func creatHeaderView()
    {
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 123 ))
        headerView.backgroundColor = UIColor.whiteColor()
        headerView.drawTopLine()
        headerView.drawBottomLine()
        self.view.addSubview(headerView)
        
        var titleLabel = UILabel()
        titleLabel.text = "积分"
        titleLabel.textColor = CD_Txt_Color_00
        titleLabel.font = Define.font(15)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(15 , 20 , titleLabel.frame.size.width, titleLabel.frame.size.height)
        headerView.addSubview(titleLabel)
        
        signButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signButton.frame = CGRectMake(kScreenWidth - 28  - 65 , 0, 65 , 65 )
        signButton.backgroundColor = UIColor.clearColor()
        signButton.addTarget(self, action: "toSignIn", forControlEvents: UIControlEvents.TouchUpInside)
      //  headerView.addSubview(signButton)
        
        var signImgV = UIImageView(image: UIImage(named: "registration2"))
        signImgV.frame = CGRectMake(15 , 10, 35 , 35 )
        signImgV.backgroundColor = UIColor.clearColor()
        signImgV.contentMode = UIViewContentMode.ScaleAspectFit
       // signButton.addSubview(signImgV)
        
        var signLabel = UILabel()
        signLabel.text = "签到赚积分"
        signLabel.textColor = CD_Txt_Color_99
        signLabel.font = Define.font(TF_12)
        signLabel.sizeToFit()
        signLabel.frame = CGRectMake(0, CGRectGetMaxY(signImgV.frame) + 5 , signLabel.frame.size.width, signLabel.frame.size.height)
        signLabel.textAlignment = NSTextAlignment.Center
       // signButton.addSubview(signLabel)
        
        integraLabel = UILabel()
        integraLabel.textColor = CD_MainColor
        integraLabel.font = Define.font(TF_40)
        integraLabel.textAlignment = NSTextAlignment.Left
        headerView.addSubview(integraLabel)
    }
    
    //MARK: 创建筛选视图
    func creatFitterView()
    {
        fitView = UIView(frame: CGRectMake(0, 123 , kScreenWidth, 45 ))
        fitView.drawBottomLine()
        fitView.backgroundColor = CD_GrayColor
        self.view.addSubview(fitView)
        
        button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        
        button.frame = CGRectMake(5, 0, 65, 45)
        button.titleLabel?.frame = CGRectMake(0, 15, 45, 15)
        button.titleLabel?.text = "所有"
        button.titleLabel?.font = Define.font(TF_16)
        button.titleLabel?.sizeToFit()
        button.titleLabel?.textAlignment = NSTextAlignment.Left
        button.setTitle("所有", forState: UIControlState.Normal)
        button.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        button.setImage(UIImage(named: "filter_down1"), forState: UIControlState.Normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(20, 50 + 5, 20, 5)
        button.addTarget(self, action: "fitIntegration", forControlEvents: UIControlEvents.TouchUpInside)
        fitView.addSubview(button)
        
//        fitterView = CustomSearchView(items: [["所有", "收入", "支出"]], andDefaultTitles: ["所有"])
//        fitterView.frame = CGRectMake(15 , 123 , 55 , 45 )
//        fitterView.backgroundColor = UIColor.redColor()
//        fitterView.delegate = self
//        self.view.addSubview(fitterView)
//        
        fitIntegrationLabel = UILabel()
        fitIntegrationLabel.textColor = CD_MainColor
        fitIntegrationLabel.font = Define.font(TF_16)
        self.fitView.addSubview(fitIntegrationLabel)
        
        //手动设置默认值
        self.fitIntegration()
    }
    
////    MARK: 创建表视图
//    func creatTableView()
//    {
//        var tableView = HWMyIntegrationTableView(frame: CGRectMake(0, CGRectGetMaxY(self.fitView.frame), kScreenWidth, contentHeight - CGRectGetMaxY(self.fitView.frame)))
//        self.view.addSubview(tableView)
//    }
    
    //MARK: 签到
    func toSignIn()
    {
        var calendarVC = HWCalendarViewController()
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    
    //MARK: 筛选按钮
    func fitIntegration()
    {
        titlesArr = ["所有", "收入", "支出"]
        if fitListView == nil
        {
            fitListView = HWIntegrationFitView(frame: CGRectMake(0, CGRectGetMaxY(fitView.frame), kScreenWidth, 45 * CGFloat(titlesArr.count)), titles: titlesArr)
            fitListView.deletage = self
            fitListView.backgroundColor = CD_GrayColor
            self.view.addSubview(fitListView)
            fitListView.hidden = true
            
            self.buttonIsClick(0)
        }

        else
        {
            if fitListView.hidden == false
            {
                fitListView.hidden = true
            }
            else
            {
                fitListView.hidden = false
            }
        }
    }
    
    //MARK: 筛选弹出框 点击的代理HWMyIntegrationTableView Delegate
    func buttonIsClick(index: NSInteger)
    {
        button.setTitle(titlesArr[index], forState: UIControlState.Normal)
        if fitIntegrationTV == nil
        {
            fitIntegrationTV = HWMyIntegrationTableView(frame: CGRectMake(0, CGRectGetMaxY(fitView.frame), kScreenWidth, contentHeight - CGRectGetMaxY(self.fitView.frame)))
            fitIntegrationTV.directIntegration = 0
            fitIntegrationTV.delegate = self
        }
        fitIntegrationTV.backgroundColor = CD_WhiteColor
        //0全部,1收入,2支出
        fitIntegrationTV.directIntegration = index
        fitIntegrationTV.queryListData()
        self.view.addSubview(fitIntegrationTV)
        self.view.bringSubviewToFront(fitListView)
        Utility.hideMBProgress(fitIntegrationTV)
    }
    
    //MARK: HWMyIntegrationTableViewDelagate
    func passIntegrationValue(arr: NSArray)
    {
//        println(arr)
        integraLabel.text = arr.pObjectAtIndex(0) as? String
//        integraLabel.text = "12345678901234"
        integraLabel.sizeToFit()
//        integraLabel.frame = CGRectMake((CGRectGetMaxX(signButton.frame) - integraLabel.frame.size.width ) / 2, CGRectGetMaxY(signButton.frame), integraLabel.frame.size.width, integraLabel.frame.size.height)
        integraLabel.frame = CGRectMake(30, CGRectGetMaxY(signButton.frame), kScreenWidth - 30, integraLabel.frame.size.height)
        integraLabel.adjustsFontSizeToFitWidth = true
        
        fitIntegrationLabel.text = arr.pObjectAtIndex(1) as? String
//        fitIntegrationLabel.text = "12345678901234"
        fitIntegrationLabel.sizeToFit()
        fitIntegrationLabel.frame = CGRectMake(kScreenWidth - 15  - fitIntegrationLabel.frame.size.width, (self.fitView.frame.size.height - fitIntegrationLabel.frame.size.height) / 2, fitIntegrationLabel.frame.size.width, fitIntegrationLabel.frame.size.height)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
