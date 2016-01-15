//
//  HWSetViewController.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/4.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit

class HWSetViewController: HWBaseViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate
{
     var notificationButton = UIButton()
     var listArry = ["意见反馈","关于我们","消息通知"]
     var userDefaults = NSUserDefaults .standardUserDefaults()
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }

     override func viewDidLoad() {
        super.viewDidLoad() 
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = CD_BackGroundColor
        self.navigationItem.titleView = Utility.navTitleView("设置");
      
        if userDefaults .objectForKey(kNotificationSwitch) as String == "1"
        {
            notificationButton.backgroundColor = UIColor .whiteColor()
            notificationButton .setImage(UIImage(named: "choose_2_2"),forState: .Normal)
            notificationButton.frame = CGRectMake(kScreenWidth - 15 - 19, (45 - 19) / 2, 19, 19);
         
            //notificationButton.userInteractionEnabled = false;
           
        }
        
        else
        {
             notificationButton .setImage(UIImage(named: "choose_2_1"),forState: .Normal)
            notificationButton.frame = CGRectMake(kScreenWidth - 15 - 19, (45 - 19) / 2, 19, 19);

           // notificationButton.userInteractionEnabled = false;

        }
        //创建表
        var tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CD_BackGroundColor
        tableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue:0)!
        self.view .addSubview(tableView)
        //创建表头
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10))
        view.backgroundColor = CD_BackGroundColor
        tableView.tableHeaderView = view
        
        let line = UIView(frame: CGRectMake(0, 10-0.5, self.view.frame.size.width, 0.5))
        line.backgroundColor = CD_LineColor
       // view.addSubview(line)
        tableView.tableHeaderView?.drawBottomLine()
        //创建表尾
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80))
        tableView.tableFooterView = footView
        //创建退出按钮
        let logoutBtn = UIButton(frame: CGRectMake(15, 20, self.view.frame.size.width-30, 45))
        logoutBtn .setTitle("退出登录", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_Btn_GrayColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn .addTarget(self, action: "doLogout", forControlEvents:UIControlEvents.TouchUpInside)
        footView .addSubview(logoutBtn)
        
    
        
    }
    
    func doLogout()
    {
        let alert  = UIAlertView(title: "提示", message: "是否退出登录", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "退出登录")
        alert.tag = 8888
        alert .show()
    }
    
    //MARK:代理
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex == 1
        {
            if alertView.tag == 8888
            {
                Utility.showMBProgress(view, _message: "退出中")
                var manager = HWHttpRequestOperationManager.baseManager()
                manager.postHttpRequest(kLoginOut, parameters: nil, queue: nil, success: { (responseObject) -> Void in
                    Utility.hideMBProgress(self.view)
                    HWUserLogin .currentUserLogin() .logout()
//                    var loginCtrl = HWLoginViewController()
                    shareAppDelegate.loginCtrl = HWLoginViewController()
                    shareAppDelegate.loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                    var loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                    Utility.transController(currentNav, newCtrl: loginNav)
                }, failure: { (code, error) -> Void in
                    Utility.hideMBProgress(self.view)
                    Utility.showToastWithMessage(error, _view: self.view)
                })
            }
        }
        else
        {
            if alertView.tag == 8889
            {
                
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = HWBaseTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
      
        let line  = UIView (frame: CGRectMake(0, 45-0.5,kScreenWidth, 0.5))
       // line.backgroundColor = CD_LineColor
        cell.contentView .addSubview(line)
        cell.textLabel?.text = listArry[indexPath.row]
        cell.textLabel?.font = Define.font(15)
        cell.textLabel?.textColor = CD_Txt_Color_99
       // cell.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
        let btn = UIButton(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
        btn.setImage(UIImage(named: "arrow_next"),forState: .Normal)
       // cell.accessoryView = btn
        
        if indexPath.row == 0
        {
           var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
            jmpImg.image = UIImage(named: "arrow_next")
            cell.contentView.addSubview(jmpImg)
        }
        
        if indexPath.row == 1
        {
            var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
            jmpImg.image = UIImage(named: "arrow_next")
            cell.contentView.addSubview(jmpImg)
        }
        

        if indexPath.row == 2
            
        {
            cell.contentView.addSubview(notificationButton)
        }
      
      
        cell.contentView.drawBottomLine()
        
          return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45.0 * kRate
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0
        {
            let vc = HWFeedBackViewController()
            vc.appkey =  UMENG_APP_KEY
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.row == 1
        {
            let vc  = HWAboutViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2
        {
            if userDefaults .objectForKey(kNotificationSwitch)  as String == "1"
            {
                  notificationButton .setImage(UIImage(named: "choose_2_1"),forState: .Normal)
                
                userDefaults .setObject("0", forKey: kNotificationSwitch)
                userDefaults .synchronize()
                APService.registerForRemoteNotificationTypes((UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue), categories: nil)
            }
            else
            {
                notificationButton .setImage(UIImage(named: "choose_2_2"),forState: .Normal)
                userDefaults .setObject("1", forKey: kNotificationSwitch)
                userDefaults .synchronize()
                UIApplication.sharedApplication().unregisterForRemoteNotifications()
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
