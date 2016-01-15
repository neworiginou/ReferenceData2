//
//  HWDynamicDetailViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum pendingState:Int
{
    case pending    //未处理
    case pended     //已处理
}


protocol HWDynamicDetailViewControllerDelegate:NSObjectProtocol
{
    func refreshDynamicList()
}

class HWDynamicDetailViewController: HWBaseViewController,HWDynamicDetailViewDelegate
{
    weak var dynamicDetailViewControllerDelegate:HWDynamicDetailViewControllerDelegate?
    var _dynamicDetailView:HWDynamicDetailView!
    var _id:NSString?
    var _status:pendingState!
    
    var status:pendingState!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 30, 20);
        leftButton.addTarget(self, action: "toPopVC", forControlEvents: .TouchUpInside)
        leftButton.setImage(UIImage(named: "arrow_return"), forState: .Normal)
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        let releaseButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = releaseButtonItem;

        self.navigationItem.titleView = Utility.navTitleView("详情")
        
        _dynamicDetailView = HWDynamicDetailView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), id: self._id!, status: self._status)
        _dynamicDetailView.dynamicDetailViewDelegate = self
        self.view.addSubview(_dynamicDetailView)
        
        // Do any additional setup after loading the view.
    }

    func toPopVC()
    {
        dynamicDetailViewControllerDelegate?.refreshDynamicList()
        self.navigationController?.popViewControllerAnimated(true)
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
