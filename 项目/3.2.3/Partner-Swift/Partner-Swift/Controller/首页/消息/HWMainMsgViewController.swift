


//
//  HWMainMsgViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/8/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMainMsgViewController: HWBaseViewController ,HWMainMsgListViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = Utility.navTitleView("消息")
        var listView = HWMainMsgListView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        listView.delegate = self
        self.view.addSubview(listView)
    }
    
    func didSelectMessageList(message: HWMainMsgListModel)
    {
        var vc:HWMessageListViewController = HWMessageListViewController()
        if (message.type == "system")
        {
            //系统消息
            vc.urlStr = kSystemMsgList
            vc.titleStr = "系统消息"
        }
        else if (message.type == "admin")
        {
            //管理员消息
            vc.urlStr = kManagerMsgList
            vc.titleStr = "管理员消息"
        }
        else if (message.type == "hi")
        {
            //Hi消息
            vc.urlStr = kHiMsgList
            vc.titleStr = "HI一下"
        }
        else if (message.type == "rental")
        {
            //租售中心消息
            vc.urlStr = kRentalCenterMsgList
            vc.titleStr = "会话"
        }
        else if (message.type == "coupon")
        {
            //优惠券消息
            vc.urlStr = kCouponMsgList
            vc.titleStr = "优惠券"
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func backMethod()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(kRefershHomePageNotification, object: nil);
        self.navigationController?.popViewControllerAnimated(true)
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
