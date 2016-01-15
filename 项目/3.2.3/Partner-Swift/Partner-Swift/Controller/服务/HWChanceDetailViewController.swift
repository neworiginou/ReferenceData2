//
//  HWChanceDetailViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/10.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-机会详情
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-10           文件创建
//    陆晓波      2015-02-28           模拟数据

import UIKit

class HWChanceDetailViewController: HWBaseViewController {

    var _model:HWServiceCustomerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("机会详情")
        
        var chanceDetailView = HWChanceDetailView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        chanceDetailView._chanceDetailModel = _model
        self.view.addSubview(chanceDetailView)
        // Do any additional setup after loading the view.
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
