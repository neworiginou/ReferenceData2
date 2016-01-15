//
//  HWChartsViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWChartsViewController: HWBaseViewController ,CustomSegmentControlDelegate{
    var refreshView :HWChartsRefreshView?
    var refreshView2:HWChartsRefreshView2?
    var topView :HWChartsHeadView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var titles = NSArray()
        //拿全局的客户登录身份来判断是否分栏
        
//        println("brokerType =========== \(HWUserLogin.currentUserLogin().brokerType)")
        
        //HWUserLogin.currentUserLogin().brokerType == "C"
        if(HWUserLogin.currentUserLogin().brokerType == "B"||HWUserLogin.currentUserLogin().brokerType == "C")
        {
            self.navigationItem.titleView = Utility.navTitleView("个人")
            refreshView = HWChartsRefreshView(frame:CGRectMake(0, 0, kScreenWidth, contentHeight))
            self.view.addSubview(refreshView!)
        }
        else if(HWUserLogin.currentUserLogin().brokerType == "A")
        {
            let segementControl = CustomSegmentControl(titles:["个人","机构"])
            segementControl.delegate = self
            self.navigationItem.titleView = segementControl
            
            refreshView2 = HWChartsRefreshView2(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
            self.view.addSubview(refreshView2!)
            
            refreshView = HWChartsRefreshView(frame:CGRectMake(0, 0, kScreenWidth, contentHeight))
            self.view.addSubview(refreshView!)
        }
        
    }
    
    func segmentControl(sControl: CustomSegmentControl!, didSelectSegmentIndex index: Int32)
    {
//        println("selectedIndex = \(index)")
        
        if (index == 0)
        {
//            refreshView?.requestUrl = kBrokerCharts
//            refreshView?.type = selectedType.personal
//            refreshView?.queryListData()
            self.view.bringSubviewToFront(refreshView!)
        }
        else
        {
//            refreshView?.requestUrl = kCpyCharts
//            refreshView?.type = selectedType.organization
//            refreshView?.queryListData()
            self.view.bringSubviewToFront(refreshView2!)
        }
        //refreshView?.reloadChartsList(Int(index))
    }
    
    
    override func backMethod()
    {
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
