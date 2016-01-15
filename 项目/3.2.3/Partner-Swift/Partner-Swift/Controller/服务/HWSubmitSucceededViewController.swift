//
//  HWSubmitSucceededViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/10.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-新建机会-提交成功
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-10           文件创建
//

import UIKit

protocol HWSubmitSucceededViewControllerDelegate:NSObjectProtocol
{
    func refreshServiceVC()
    
    func refreshList()
}

class HWSubmitSucceededViewController: HWBaseViewController,HWSubmitSuccessViewDelegate {

    weak var submitSucceededDelegate:HWSubmitSucceededViewControllerDelegate?
    
    var submitProductName:NSString?
    var submitCustomerName:NSString?
    var submitLoan:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("提交成功")
        
        //leftBarButtonItem
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 10, 20);
        leftButton .addTarget(self, action: "customBackMethod", forControlEvents: .TouchUpInside)
        leftButton .setImage(UIImage(named: "arrow_return"), forState: .Normal)
        let releaseButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = releaseButtonItem;
        
        var submitSuccessView = HWSubmitSuccessView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        submitSuccessView.submitSuccessDelegate = self
        submitSuccessView.productName = submitProductName
        submitSuccessView.customerName = submitCustomerName
        submitSuccessView.loan = submitLoan
        self.view.addSubview(submitSuccessView)
        // Do any additional setup after loading the view.
    }

    func customBackMethod() -> Void
    {
        println("清除")
        submitSucceededDelegate?.refreshList()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: -- 点击返回列表按钮代理
    func didSelectedBackToServiceList()
    {
        submitSucceededDelegate?.refreshServiceVC()
        self.navigationController?.popToRootViewControllerAnimated(true)
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
