//
//  HWInputClientViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation

class HWInputClientViewController: HWBaseViewController,HWCustomerSearchDelegate, HWCustomerInfoDelegate,HWCustomerInfoViewDelegate
{
    
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    var customerTableV:HWCustomerInfoView! = nil;
    var searchView: HWCustomerSearchView! = nil;
     override func backMethod()
     {
        if (self.myFunc != nil)
        {
            self.myFunc!()
        }
        self.navigationController?.popViewControllerAnimated(true);

        
     }
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
         
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.titleView = Utility.navTitleView("客户");
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "群发", _selector: "sendMessage");
        self.view.backgroundColor = CD_BackGroundColor;
        //创建Table
        customerTableV = HWCustomerInfoView(frame: CGRectMake(0, 55, kScreenWidth, contentHeight - 100));
        customerTableV.delegate = self; 
        customerTableV.sourceMode = ClientSource.Normal
        customerTableV.selectMode = ClientSelectMode.None
        self.view.addSubview(customerTableV);
        
        searchView = HWCustomerSearchView(frame: CGRectMake(0, 0, kScreenWidth, 55) , type: "0");
        
        searchView.delegate = self; 

        self.view.addSubview(searchView);
        self.view.backgroundColor = UIColor.whiteColor();
        
        //创建录入客户按钮
        var loggFrame = CGRectMake(0, contentHeight - 45, kScreenWidth, 45);
        var logginCustomerBtn:UIButton = createCustomeBtn(self, "logginCustomer:", loggFrame, nil, "", "");
        logginCustomerBtn.backgroundColor = CD_MainColor;
        logginCustomerBtn.setTitle("录入客户", forState: UIControlState.Normal);
        logginCustomerBtn .setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        self.view.addSubview(logginCustomerBtn);
      
    }
    
    //进入客户详情
    func didSelectedCustomer(customerArr: NSArray?)
    {
        if(customerArr?.count == 0)
        {
            return;
        }
        var infoModel = customerArr?.objectAtIndex(0) as HWClientModel
        if(infoModel.clientSourceWay  == "合作")
        {
            var agentDetailV:HWAgentCutomerVC = HWAgentCutomerVC();
            agentDetailV.clientInfoId = infoModel.clientInfoId
            agentDetailV.myFunc = { ()->Void in
                self.customerTableV.baseListArr .removeAllObjects()
                self.customerTableV.currentPage = 1
                self.customerTableV .normalQueryListData()
                self.customerTableV.baseTable .reloadData()
            }

            self.navigationController?.pushViewController(agentDetailV, animated: true);
        }
        else
        {
            var customerDetailV:HWCustomerDetailViewController = HWCustomerDetailViewController();
            customerDetailV.clientInfoId = infoModel.clientInfoId
            customerDetailV.myFunc = { ()->Void in
                self.customerTableV.baseListArr .removeAllObjects()
                self.customerTableV.currentPage = 1
                self.customerTableV .normalQueryListData()
                Utility.hideMBProgress(self.view)
                self.customerTableV.baseTable .reloadData()
            }
            self.navigationController?.pushViewController(customerDetailV, animated: true);
        }
    }
    
    func didClickNewScheduleByClient(client: HWClientModel)
    {
        MobClick .event("Scheduleformclient_click")
        var newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
        newScheduleVC.relatedClient = client
        self.navigationController?.pushViewController(newScheduleVC, animated: true)
    }
    
//    override func backMethod() -> Void
//    {
//        self.navigationController?.popViewControllerAnimated(true);
//    }
    
    //群发短信
    func sendMessage()->Void
    {
        MobClick .event("Groupmessage_click")
        var groupMessageV: HWGroupMessageViewController = HWGroupMessageViewController();
        self.navigationController?.pushViewController(groupMessageV, animated: true);
    }
    func comeInCustomerDetail(row: String)
    {
        MobClick .event("Clientdetails_click")
        var customerDetailV:HWCustomerDetailViewController = HWCustomerDetailViewController();
        self.navigationController?.pushViewController(customerDetailV, animated: true);
    }
    func logginCustomer(sender:UIButton)->Void
    {
        MobClick .event("Addclient_click")
        var logginCustomerV:HWLoggingCustomerVC = HWLoggingCustomerVC();
        logginCustomerV.titileType = "0"
        logginCustomerV.agentClientModel == Optional.None
        logginCustomerV.myFunc = { ()->Void in
            self.customerTableV.baseListArr .removeAllObjects()
            self.customerTableV.currentPage = 1
            self.customerTableV .normalQueryListData()
            self.customerTableV.baseTable .reloadData()
        }
        self.navigationController?.pushViewController(logginCustomerV, animated: true);
    }
    //MAKE:-实时搜索
    func didSearchTitle(title: NSString)
    {
        print(title);
         MobClick .event("Searchclient_click")
        customerTableV.setSearchKey(title)
    }
    //MAKE:-选择分类筛选
    func didSelectMenuByIndex(index: NSInteger)
    {
        MobClick .event("Clientfilter_click")
        customerTableV.setSearchFilterIndex(index)
    }
    func didSelectMenufirstIdAndSecondId(first: NSString, second: NSString)
    {
        customerTableV.setSearchFilterFirstAndSecond(first, secondId: second);
        self.searchView.doTap(UITapGestureRecognizer());//隐藏背景

    }
    //MAKE:-过滤结束
    func didMenuEnd()->Void
    {
//        customerTableV.hidden = false;
    }
    //MAKE:-过滤开始
    func didMenuStart()->Void
    {
//        customerTableV.hidden = true;
    }
    //MARK:-打电话
    func phoneClick(phoneNum: NSString)->Void
    {
        Utility.callPhone(phoneNum)
    }
    
}
