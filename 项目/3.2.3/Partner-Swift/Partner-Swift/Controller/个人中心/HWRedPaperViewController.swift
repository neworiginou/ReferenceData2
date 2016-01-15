//
//  HWRedPaperViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
class HWRedPaperViewController: HWBaseViewController,HWRedPaperRefreshViewDelegate {
    var    redPaperFV = HWRedPaperRefreshView(frame:CGRectMake(0, 0, kScreenWidth, contentHeight))
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = Utility.navTitleView("我的红包")
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod");
        
  
        redPaperFV.clikedDelegate = self
        self.view.addSubview(redPaperFV)
        
        
    }
    override func viewWillAppear(animated: Bool)
    {
        redPaperFV.currentPage = 1;
        redPaperFV.queryListData();
    }
    func cellIsSelected(model: HWRedPaperModel)
    {
        var openRedVC = HWRedRocketViewController();
        openRedVC.moneyStr = model.money;
        openRedVC.redIdStr = model.redId;
        self.navigationController?.pushViewController(openRedVC, animated: true)
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
