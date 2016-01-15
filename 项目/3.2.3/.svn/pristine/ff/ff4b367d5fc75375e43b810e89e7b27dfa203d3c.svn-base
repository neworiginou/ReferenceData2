//
//  HWRelateClientViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：关联客户
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import UIKit

protocol HWRelateClientViewControllerDelegate: NSObjectProtocol
{
    func relateClientViewControllerDidSelectClient(client: HWClientModel?)
}

class HWRelateClientViewController: HWBaseViewController, HWCustomerSearchDelegate, HWCustomerInfoViewDelegate {

    var customerTableV: HWCustomerInfoView!
    var searchBar: HWCustomerSearchView!
    var searchView: UIView!
    var delegate: HWRelateClientViewControllerDelegate?
    var selectedClient: HWClientModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.titleView = Utility.navTitleView("客户")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "添加", _selector: "toAddClient")
        self.view.backgroundColor = CD_BackGroundColor;
        
        //创建Table
        customerTableV = HWCustomerInfoView(frame: CGRectMake(0, 55, kScreenWidth, contentHeight - 55));
        customerTableV.delegate = self
        customerTableV.sourceMode = ClientSource.Schedule
        customerTableV.selectMode = ClientSelectMode.Single
        if (selectedClient != nil)
        {
            customerTableV.selectedArray = NSMutableArray(object: selectedClient!)
        }
        self.view.addSubview(customerTableV);
        
        var searchView: HWCustomerSearchView = HWCustomerSearchView(frame: CGRectMake(0, 0, kScreenWidth, 55),type:"0");
        searchView.delegate = self;
        self.view.addSubview(searchView);
        self.view.backgroundColor = UIColor.whiteColor();
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        customerTableV.queryListData()
        
    }
    
    func toAddClient()
    {
        let inputClientVC = HWLoggingCustomerVC()
        inputClientVC.titileType = "0"
        self.navigationController?.pushViewController(inputClientVC, animated: true)
    }
    
    func didSelectedCustomer(customerArr: NSArray?)
    {
        if (delegate != nil && delegate?.respondsToSelector("relateClientViewControllerDidSelectClient:") == true)
        {
            var client: HWClientModel? = customerArr?.pObjectAtIndex(0) as? HWClientModel
            delegate?.relateClientViewControllerDidSelectClient(client)
        }
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
    

    override func didReceiveMemoryWarning()
    {
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
