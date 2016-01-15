//
//  HWRelateHouseViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWRelateHouseViewControllerDelegate: NSObjectProtocol
{
    func relateHouseViewControllerDidSelectHouse(house: HWRelateHouseModel?)
}

class HWRelateHouseViewController: HWBaseViewController, HWRelateHouseRefreshViewDelegate {

    var delegate: HWRelateHouseViewControllerDelegate?
    var clientId: NSString = ""
    var selectedHouse: HWRelateHouseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("关联楼盘")
        
        let relateHouseView = HWRelateHouseRefreshView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        relateHouseView.clientId = self.clientId;
        relateHouseView.delegate = self
        relateHouseView.selectedHouse = self.selectedHouse;
        self.view.addSubview(relateHouseView)
        // Do any additional setup after loading the view.
    }
    
    func didSelectRelateHouse(house: HWRelateHouseModel?)
    {
        if (delegate != nil && delegate?.respondsToSelector("relateHouseViewControllerDidSelectHouse:") == true)
        {
            delegate?.relateHouseViewControllerDidSelectHouse(house)
        }
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
