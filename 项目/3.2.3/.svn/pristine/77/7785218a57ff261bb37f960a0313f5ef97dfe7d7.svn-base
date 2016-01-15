//
//  HWTabbarViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：tabbarController 二层封装
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation

class HWTabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var homeVC: HWHomeViewController? = nil
    //var homeVC: HWChangePersonViewController? = nil
    var newHouseVC: HWNewHouseViewController? = nil
    var secondHouseVC: HWSecondHouseViewController? = nil
    var serviceVC: HWServiceViewController? = nil
    var inputClientVC: HWInputClientViewController? = nil
    
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.BlackOpaque
//    }
    
    override func viewDidLoad()
    {
        
//        self.setNeedsStatusBarAppearanceUpdate()
        
        self.homeVC = HWHomeViewController()
        // self.homeVC = HWChangePersonViewController()
        self.homeVC?.title = "首页"
        self.homeVC?.tabBarItem.image = UIImage(named: "tab1")
        self.homeVC?.tabBarItem.selectedImage = UIImage(named: "tab1_hl")
        //self.homeVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: <#UIControlState#>)
//        self.homeVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: UIControlState.Highlighted)
        
        self.newHouseVC = HWNewHouseViewController()
        self.newHouseVC?.title = "新房"
        self.newHouseVC?.navigationItem.titleView = Utility.navTitleView("新房")
        self.newHouseVC?.tabBarItem.image = UIImage(named: "tab2")
        self.newHouseVC?.tabBarItem.selectedImage = UIImage(named: "tab2_hl")
        //        self.newHouseVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: <#UIControlState#>)
        //        self.newHouseVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: UIControlState.Highlighted)
        
        self.inputClientVC = HWInputClientViewController()
//        self.inputClientVC?.title = "录入客户"
//        self.inputClientVC?.tabBarItem.image = UIImage(named: "")
//        self.inputClientVC?.tabBarItem.selectedImage = UIImage(named: "")
        //        self.inputClientVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: <#UIControlState#>)
        //        self.inputClientVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: UIControlState.Highlighted)
        
        self.secondHouseVC = HWSecondHouseViewController()
        self.secondHouseVC?.title = "二手房"
        self.secondHouseVC?.tabBarItem.image = UIImage(named: "tab3")
        self.secondHouseVC?.tabBarItem.selectedImage = UIImage(named: "tab3_hl")
        //        self.secondHouseVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: <#UIControlState#>)
        //        self.secondHouseVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: UIControlState.Highlighted)
        
        self.serviceVC = HWServiceViewController()
        self.serviceVC?.title = "服务"
        self.serviceVC?.tabBarItem.image = UIImage(named: "tab4")
        self.serviceVC?.tabBarItem.selectedImage = UIImage(named: "tab4_hl")
        //        self.serviceVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: <#UIControlState#>)
        //        self.serviceVC?.tabBarItem.setTitleTextAttributes(<#attributes: [NSObject : AnyObject]!#>, forState: UIControlState.Highlighted)
        
        let string = NSString(string: UIDevice.currentDevice().systemVersion).floatValue

        if (iOS7)
        {
            self.tabBar.tintColor = CD_MainColor
        }
        else
        {
            self.tabBar.tintColor = UIColor.whiteColor()
        }
        self.tabBar.barTintColor = UIColor.whiteColor()
        
        let vcArr: NSArray = [self.homeVC!, self.newHouseVC!, self.inputClientVC!, self.secondHouseVC!, self.serviceVC!]
        
        self.viewControllers = vcArr
        self.delegate = self
        
        self.addCenterButton()
    }
    
    func addCenterButton() -> Void
    {
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.backgroundColor = UIColor.clearColor()
        button.frame = CGRectMake(0, 0, kScreenWidth / 5, self.tabBar.frame.size.height)
        button.setImage(UIImage(named: "tab_release"), forState: UIControlState.Normal)
        button.center = CGPointMake(self.tabBar.frame.size.width / 2.0, self.tabBar.frame.size.height / 2.0)
        button.addTarget(self, action: "toShowInputClient:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabBar.addSubview(button)
    }
    
    func toShowInputClient(sender: UIButton) -> Void
    {
        let vc = HWLoggingCustomerVC()
        let nav = HWBaseNavigationController(rootViewController: vc)
        vc.titileType = "0"
        shareAppDelegate.window?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if (self.selectedIndex == 0)
        {
            self.navigationController?.navigationBarHidden = true
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.BlackOpaque
        }
        else
        {
            self.navigationController?.navigationBarHidden = false
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
    {
        self.navigationController?.navigationBarHidden = false;
        if (viewController.isEqual(self.homeVC))
        {
            MobClick.event("Home_click")//maidian_3.0_niedi
            self.navigationController?.navigationBarHidden = true;
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.BlackOpaque
        }
        else if (viewController.isEqual(self.newHouseVC))
        {
            MobClick.event("Newhouse_click")//maidian_3.0_niedi
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        }
        else if (viewController.isEqual(self.secondHouseVC))
        {
            MobClick.event("Scdhouse_click")//maidian_3.0_niedi
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        }
        else if (viewController.isEqual(self.serviceVC))
        {
            MobClick.event("Service_click")//maidian_3.0_niedi
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        }
        
    }
    

}

