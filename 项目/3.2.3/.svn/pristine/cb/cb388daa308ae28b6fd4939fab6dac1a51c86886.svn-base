//
//  HWPersonalCenterViewController.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/15.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

import UIKit


class HWPersonalCenterViewController: HWBaseViewController,HWPersonalCenterTableViewDelegate
{
    var personalCenterTV:HWPersonalCenterTableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("个人中心")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "pushToSetting", _image: UIImage(named: "personal_center_10")!)
        personalCenterTV = HWPersonalCenterTableView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        personalCenterTV.backgroundColor = UIColor.clearColor()
        personalCenterTV.delegate = self
        self.view.addSubview(personalCenterTV)
        
//        var vc = allViewControllers[0] as UIViewController!
        //MYP add v3.2已抢到优惠券增加时个人中心刷新数据
        NSNotificationCenter .defaultCenter().addObserver(self, selector: "reloadViewData", name:"reloadPersonalCenterData", object: nil)
    }
    
    //MYP add v3.2
    func reloadViewData()
    {
        personalCenterTV.queryListData()
    }
    
    //add by gusheng
    //remark:解决导航bar隐藏，以及返回主页闪动的BUG
    override func backMethod() -> Void
    {
        NSNotificationCenter .defaultCenter() .postNotificationName(kRefershHomePageNotification, object: nil)
        self.navigationController?.popViewControllerAnimated(true);
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadPersonalCenterData", object: nil)
    }
    //end
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        self.view.backgroundColor = CD_BackGroundColor
        self.navigationController?.navigationBarHidden = false
    }
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBarHidden = false;
    }
    
    // MARK: 点击表头的代理
    func headerDidSelected()
    {
        var changePersonVC = HWChangePersonViewController()
        changePersonVC.changeVC = self
        self.navigationController?.pushViewController(changePersonVC, animated: true)
    }
     func headerDidSigned()
     {
        var calendarVC = HWCalendarViewController()
        self.navigationController?.pushViewController(calendarVC, animated: true)

    }
    
    // MARK: 点击cell
    func cellDidSelected(index: NSIndexPath, customerType: String, DiscountCoupon: Bool)
    {
        if index.section == 0
        {
            if index.row == 0
            {
                //埋点：点击我的业绩
                MobClick.event("Performance_click")
                //业绩
                var scoreVC = HWScoreViewController()
                self.navigationController?.pushViewController(scoreVC, animated: true)
            }
            if index.row == 1
            {
                //埋点：点击我的积分
                MobClick.event("Integral_click")
                //积分
                var myIntegrationVC = HWMyIntegrationViewController()
                self.navigationController?.pushViewController(myIntegrationVC, animated: true)
            }
            if index.row == 2
            {
                //埋点：点击我的钱包
                MobClick.event("wallet_click")
                //钱包
//                let packVC = HWMoneyViewController()
//                self.navigationController?.pushViewController(packVC, animated: true)
                var packVC = HWMoneyViewController()
                shareAppDelegate.myPurseVC = packVC
                self.navigationController?.pushViewController(packVC, animated: true)
            }
        }
        else if index.section == 1
        {
            //优惠券3.0版本不做、客户经纪人是直客专员才有下线
            if DiscountCoupon == false && customerType == "C"
            {
                if index.row == 0
                {
                    //MYP add 埋点：个人中心－跳转我的下线
                    MobClick.event("Referral_click")
                    
                    //我的下线
                    let vc = HWSubordinateViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if index.row == 1
                {
                    //MYP add 埋点：个人中心－跳转排行榜
                    MobClick.event("Rankinglist_click")

                    //排行榜
                    let vc = HWChartsViewController()
                    self.navigationController?.pushViewController(vc, animated: true)

                }
                
            }
            else if DiscountCoupon == false && customerType != "C"
            {
                //MYP add 埋点：个人中心－跳转排行榜
                MobClick.event("Rankinglist_click")
                
                //排行榜
                let vc = HWChartsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if DiscountCoupon == true && customerType == "C"
            {
                if index.row == 0
                {
                    //优惠券
                    //MYP add v3.2跳转我的优惠劵
                    let vc = HWMyDisCountViewController()
                    vc.fromVC = "个人中心"
                    self.navigationController?.pushViewController(vc, animated: true)

                }
                if index.row == 1
                {
                    //MYP add 埋点：个人中心－跳转我的下线
                    MobClick.event("Referral_click")
                    
                    //我的下线
                    let vc = HWSubordinateViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if index.row == 2
                {
                    //MYP add 埋点：个人中心－跳转排行榜
                    MobClick.event("Rankinglist_click")
                    
                    //排行榜
                    let vc = HWChartsViewController()
                    self.navigationController?.pushViewController(vc, animated: true)

                }
                
            }
            else if DiscountCoupon == true && customerType != "C"
            {
                if index.row == 0
                {
                    //优惠券 
                    //MYP add v3.2跳转我的优惠劵
                    let vc = HWMyDisCountViewController()
                    vc.fromVC = "个人中心"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if index.row == 1
                {
                    //MYP add 埋点：个人中心－跳转排行榜
                    MobClick.event("Rankinglist_click")
                    
                    //排行榜
                    let vc = HWChartsViewController()
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            }

        }
        else
        {
            if index.row == 0
            {
                var callWebView = UIWebView()
                self.view .addSubview(callWebView)
                var telUrl = NSURL(string: "tel://"+"4000962882")
                callWebView .loadRequest(NSURLRequest(URL:telUrl!))

            }
        }
    }
    
    // MARK: 点击表尾的按钮
    func footerBtnDidSelected(tag: NSInteger)
    {
        //扫描经纪人
        if tag == 1001
        {
            //MYP add 埋点：个人中心－跳转扫描经纪人
            MobClick.event("Scanbroker_click")
            
            let vc = HWScanBorderViewController()
            self.navigationController?.pushViewController(vc, animated: true)

        }
        //房贷计算器
        else if tag == 1002
        {
            let vc = HWFangDaiViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //税费计算器
        else
        {
            let vc = HWHouseTaxCalculatorViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    // MARK: 点击跳转到设置页面
    func pushToSetting()
    {
        var setVC = HWSetViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
