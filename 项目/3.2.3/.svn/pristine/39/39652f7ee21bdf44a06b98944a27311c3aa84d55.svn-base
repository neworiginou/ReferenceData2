//
//  HWGradeViewController.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/9.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：我的业绩排行榜页面
//
//  魏远林  2015-02-09    创建
//
//

import UIKit

class HWGradeViewController: HWBaseViewController, CustomSegmentControlDelegate
{
    var segmentControl:CustomSegmentControl?
    var gradeOfSingle:HWGradeOfSingleTableView?
    var gradeOfCompany:HWGradeOfCompanyTableView?
    var scrollView:UIScrollView?
    
    let isPersona:Bool = false
    
    override func viewDidLoad()
    {
        self.view.backgroundColor = CD_BackGroundColor
        segmentControl = CustomSegmentControl(titles: ["个人", "机构"])
        segmentControl!.delegate = self
        segmentControl!.selectedIndex = 0
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        scrollView?.contentSize = CGSizeMake(2 * kScreenWidth, contentHeight)
        scrollView?.scrollEnabled = false
        scrollView?.pagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView!)
        
        gradeOfSingle = HWGradeOfSingleTableView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        scrollView?.addSubview(gradeOfSingle!)
        
        gradeOfCompany = HWGradeOfCompanyTableView(frame: CGRectMake(kScreenWidth, 0, kScreenWidth, contentHeight))
        scrollView?.addSubview(gradeOfCompany!)
        
        self.segmentControl(segmentControl, didSelectSegmentIndex: 0)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod")
        self.navigationItem.titleView = segmentControl
//        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "我的积分", _selector: "pushToMyIntegral")
    }
    // MARK: CustomSegmentControl Delegate 
    func segmentControl(sControl: CustomSegmentControl!, didSelectSegmentIndex index: Int32)
    {
        scrollView?.contentOffset = CGPointMake(CGFloat(index) * kScreenWidth, 0)
    }
    
    //MARK: 跳转到积分页面
//    func pushToMyIntegral()
//    {
//        var myIntegralVc = HWMyIntegralScoreViewController()
//        self.navigationController!.pushViewController(myIntegralVc, animated: true)
//    }
}
