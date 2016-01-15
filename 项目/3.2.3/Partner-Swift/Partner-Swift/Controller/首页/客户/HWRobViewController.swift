//
//  HWRobViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/4/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRobViewController: HWBaseViewController ,CustomSegmentControlDelegate,HWRobCustomerViewDelegate,HWRobHouseViewDelegate{

    var robHouseView:HWRobHouseView!
    var robCustomerView:HWRobCustomerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let segementControl = CustomSegmentControl(titles:["抢客","抢房"])
        segementControl.delegate = self
        self.navigationItem.titleView = segementControl
        
        robHouseView = HWRobHouseView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        robHouseView.delegate = self
        self.view.addSubview(robHouseView)
        
        robCustomerView = HWRobCustomerView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        robCustomerView.delegate = self
        self.view.addSubview(robCustomerView)
    }

    //MARK:CustomSegmentControlDelegate
    func segmentControl(sControl: CustomSegmentControl!, didSelectSegmentIndex index: Int32) {
        if index == 0
        {
            self.view.bringSubviewToFront(robCustomerView)
        }
        else
        {
            self.view.bringSubviewToFront(robHouseView)
        }
    }
    
    func pushRobSuccessVC(dic:NSMutableDictionary) {
        
        let type = dic.stringObjectForKey("type")
        
        if type.isEqualToString("0")
        {
            let clientId = dic.stringObjectForKey("clientInfoId");
            let protectDayS = dic.stringObjectForKey("protectDays");
            let robSucessV:HWRobSucessViewController = HWRobSucessViewController();
            robSucessV.robClientId = clientId;
            robSucessV.protectDays = protectDayS;
            robSucessV.sourceStr = "1"
            self.navigationController?.pushViewController(robSucessV, animated: true)
        }
        else
        {
            var webVC = HWWebViewController()
            //MYP add 如果URL为空 不跳转聊天页面
            if dic.stringObjectForKey("phpImUrl").length == 0
            {
                return
            }
            webVC.urlStr = dic.stringObjectForKey("phpImUrl")
            webVC.messageModel.messageId = dic.stringObjectForKey("messageId")
            webVC.messageModel.source = dic.stringObjectForKey("messageSource")
            self.navigationController?.pushViewController(webVC, animated: false)
        }
    }
    
    func pushSuccessView2(dic:NSDictionary)
    {
        let type = dic.stringObjectForKey("type")
        if type.isEqualToString("0")
        {
            let robSucessV:HWRobSucessViewController = HWRobSucessViewController();
            robSucessV.sourceStr = "2"
            robSucessV.scdHouseId = dic.stringObjectForKey("scdhandHousesId");
            self.navigationController?.pushViewController(robSucessV, animated: true)
        }
        else
        {
            var webVC = HWWebViewController()
            //MYP add 如果URL为空 不跳转聊天页面
            if dic.stringObjectForKey("phpImUrl").length == 0
            {
                return
            }
            webVC.urlStr = dic.stringObjectForKey("phpImUrl")
            webVC.messageModel.messageId = dic.stringObjectForKey("messageId")
            webVC.messageModel.source = dic.stringObjectForKey("messageSource")
            self.navigationController?.pushViewController(webVC, animated: false)
        }
        
    }
    
    //MARK:返回操作
    override func backMethod() {
        NSNotificationCenter.defaultCenter().postNotificationName(kRefershHomePageNotification, object: nil);
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
       // self.view.backgroundColor = "#fff7e0".UIColor;
        self.navigationController?.navigationBarHidden = false
        
    }
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBarHidden = true;
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
