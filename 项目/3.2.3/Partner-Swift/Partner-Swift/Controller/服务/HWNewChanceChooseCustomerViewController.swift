//
//  HWNewChanceChooseCustomerViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：服务-新建机会-选择客户
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-07           文件创建
//

import UIKit

protocol HWNewChanceChooseCustomerViewControllerDelegate:NSObjectProtocol
{
    func didSelectedCustomerList(selectedArray:NSArray?)
}

class HWNewChanceChooseCustomerViewController: HWBaseViewController,HWCustomerSearchDelegate,HWCustomerInfoViewDelegate
{
    weak var newChanceChooseCustomerDelegate: HWNewChanceChooseCustomerViewControllerDelegate?
    var customerTableV: HWCustomerInfoView!
    var searchBar: HWCustomerSearchView!
    var searchView: UIView!
    var _selectedArray:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("选择客户")
        self.view.backgroundColor = CD_BackGroundColor;
        
        //创建Table
        customerTableV = HWCustomerInfoView(frame: CGRectMake(0, 55, kScreenWidth, contentHeight - 55));
        customerTableV.delegate = self
        customerTableV.sourceMode = ClientSource.SecondHouseRelate
        customerTableV.selectMode = ClientSelectMode.Single
        self.view.addSubview(customerTableV);
        
        var searchView: HWCustomerSearchView = HWCustomerSearchView(frame: CGRectMake(0, 0, kScreenWidth, 55),type:"0");
        searchView.delegate = self;
        self.view.addSubview(searchView);
        
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "addItem", _image: UIImage(named: "add_icon1")!)
        // Do any additional setup after loading the view.
    }
    
    //MARK:--点击rightBarButtonItem 录入客户
    func addItem()
    {
        var logginCustomerV:HWLoggingCustomerVC = HWLoggingCustomerVC();
        logginCustomerV.titileType = "0"
        self.navigationController?.pushViewController(logginCustomerV, animated: true);
    }
    
    func didSelectedCustomer(customerArr: NSArray?)
    {
//        println("customerArr==\(customerArr)")
        newChanceChooseCustomerDelegate?.didSelectedCustomerList(customerArr)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MAKE:-实时搜索
    func didSearchTitle(title: NSString)
    {
        print(title);
        customerTableV.setSearchKey(title)
    }
    
    //MAKE:-选择分类筛选
    func didSelectMenuByIndex(index: NSInteger)
    {
        print(title);
        customerTableV.setSearchFilterIndex(index)
    }
    func didSelectMenufirstIdAndSecondId(first: NSString, second: NSString) {
        
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
