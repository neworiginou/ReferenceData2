//
//  HWBaseNavigationController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：navigationController 基类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-26           创建文件
//

import UIKit

class HWBaseNavigationController: UINavigationController
{
      override func viewDidLoad() {
        super.viewDidLoad()

        if (iOS7)
        {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        
        self.navigationBar.setBackgroundImage(Utility.imageWithColor(UIColor.whiteColor(), _size: CGSizeMake(kScreenWidth, iOS7 ? 64 : 44)), forBarMetrics: UIBarMetrics.Default)
//        self.navigationBar.translucent  = true;
        
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
