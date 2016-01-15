//
//  HWNewChanceViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/5.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-新建机会
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-15           文件创建
//    陆晓波      2015-03-07           添加选择客户VC
//

import UIKit

protocol HWNewChanceViewControllerDelegate:NSObjectProtocol
{
    func refreshServiceCustomerList()
}

class HWNewChanceViewController: HWBaseViewController,HWNewChanceViewDelegate,HWSubmitSucceededViewControllerDelegate,HWNewChanceChooseCustomerViewControllerDelegate
{

    weak var newChanceViewDelegate:HWNewChanceViewControllerDelegate?
    var customerName:NSString? = "选择客户"
    var _newChanceView : HWNewChanceView!
    var _chooseCustomerVC : HWNewChanceChooseCustomerViewController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("新建机会")
        
        _newChanceView = HWNewChanceView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        _newChanceView.newChanceViewDelegate = self
        _newChanceView.customerLabelStr = customerName
        self.view.addSubview(_newChanceView)
        // Do any additional setup after loading the view.
    }

    //MARK:--点击提交按钮代理
    func didSelectedSubmitBtn(productName: NSString!, customerName: NSString!, loan: NSString?)
    {
        var submitSuccessed = HWSubmitSucceededViewController()
        submitSuccessed.submitSucceededDelegate = self
        submitSuccessed.submitProductName = productName
        submitSuccessed.submitCustomerName = customerName
        submitSuccessed.submitLoan = loan
        self.navigationController?.pushViewController(submitSuccessed, animated: true)
    }
    
    //MARK:--刷新列表代理，指向服务列表
    func refreshServiceVC()
    {
        newChanceViewDelegate?.refreshServiceCustomerList()
    }
    
    //MARK:--提交成功 返回上级页面 清空数据
    func refreshList()
    {
        _newChanceView.textLabelStr = "选择服务产品"
        _newChanceView.customerLabelStr = "选择客户"
        _newChanceView.loan = "输入金额"
        _newChanceView.baseTable.reloadData()
    }
    
    //MARK:--跳转页面，选择客户
    func toChooseCustomerList()
    {
        println("跳转页面，选择客户")
        _chooseCustomerVC = HWNewChanceChooseCustomerViewController()
        _chooseCustomerVC.newChanceChooseCustomerDelegate = self
        self.navigationController?.pushViewController(_chooseCustomerVC, animated: true)
    }
    
    //MARK:--新建机会-选择客户代理
    func didSelectedCustomerList(selectedArray: NSArray?)
    {
//        println(selectedArray?.pObjectAtIndex(0))
        _newChanceView.setCustomerModel(selectedArray?.pObjectAtIndex(0) as HWClientModel)
        //_newChanceView._customerModel = selectedArray!.pObjectAtIndex(0) as? HWClientModel
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
