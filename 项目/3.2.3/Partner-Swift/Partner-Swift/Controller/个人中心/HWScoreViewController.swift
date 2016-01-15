//
//  HWScoreViewController.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/9.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//
//  功能描述：我的业绩主页面
//
//  魏远林  2015-02-09  创建
//

import UIKit

class HWScoreViewController: HWBaseViewController, HMSegmentedControlDelegate
{
    var mainScrollV : UIScrollView?
    var segmentedCtr:HMSegmentedControl?
    var clientType:String!
    var headerLabelcount:Int!
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //通过我的业绩-房产View传值给controller
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getHeaderData:", name: "kHouseScoreNotification", object: nil)

        self.navigationItem.titleView = Utility.navTitleView("我的业绩")
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "排行榜", _selector: "pushGrade")
        
        clientType = HWUserLogin.currentUserLogin().brokerType//C为直客专员，直客专员才有下线
        
        //需要判断当前客户类型，有无我的下线
        segmentedCtr = HMSegmentedControl(frame: CGRectMake(0, 0, kScreenWidth, 80))
        segmentedCtr?.selectedSegmentIndex = 0
        segmentedCtr?.delegate = self
        segmentedCtr?.backgroundColor = UIColor.whiteColor()
        segmentedCtr?.textColor = CD_Txt_Color_33
        segmentedCtr?.font = Define.font(TF_16)
        segmentedCtr?.selectedTextColor = CD_MainColor
        segmentedCtr?.selectionIndicatorColor = CD_MainColor
        segmentedCtr?.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
        segmentedCtr?.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentedCtr?.titleOffsetY = 20
        segmentedCtr?.drawBottomLine()
        self.view.addSubview(segmentedCtr!)
        
        if clientType == "C"
        {
            segmentedCtr?.sectionTitles = ["房产", "权证", "金融", "下线"]
        }
        else
        {
            segmentedCtr?.sectionTitles = ["房产", "权证", "金融"]
        }
        
        headerLabelcount = (clientType == "C") ? 4 : 3
        for var i = 0;i < headerLabelcount;i++
        {
            var titleLabel = UILabel(frame: CGRectMake(CGFloat(i) * (kScreenWidth / CGFloat(headerLabelcount)), 15.0, (kScreenWidth / CGFloat(headerLabelcount)) , 30.0))
            titleLabel.backgroundColor = UIColor.clearColor()
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = Define.font(24)
            titleLabel.textColor = CD_MainColor
            titleLabel.tag = 1200 + i
            segmentedCtr?.addSubview(titleLabel)
            if i != 0
            {
                var line = UIView(frame: CGRectMake(CGFloat(i) * (kScreenWidth / CGFloat(headerLabelcount)), 0, 0.5, 80))
                line.backgroundColor = CD_LineColor
                segmentedCtr?.addSubview(line)
            }
        }
        
        var headTitleLab = UILabel(frame: CGRectMake(0, CGRectGetMaxY(segmentedCtr!.frame), kScreenWidth, 30))
        headTitleLab.backgroundColor = UIColor.clearColor()
        headTitleLab.font = Define.font(TF_13)
        headTitleLab.textColor = CD_Txt_Color_99
        headTitleLab.text = "   业绩记录"
        headTitleLab.drawBottomLine()
        self.view.addSubview(headTitleLab)
        
        mainScrollV = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(headTitleLab.frame), kScreenWidth, contentHeight - CGRectGetMaxY(headTitleLab.frame)))
        mainScrollV?.backgroundColor = UIColor.clearColor()
        mainScrollV?.contentSize = CGSizeMake(4 * kScreenWidth, mainScrollV!.frame.size.height)
        mainScrollV?.scrollEnabled = false
        mainScrollV?.pagingEnabled = true
        mainScrollV?.showsHorizontalScrollIndicator = false
        self.view.addSubview(mainScrollV!)
        
        for var i = 0;i < headerLabelcount;i++
        {

            var frame = CGRectMake(CGFloat(i) * kScreenWidth, 0, kScreenWidth, contentHeight - CGRectGetMaxY(headTitleLab.frame))
            if i == 0
            {
                var houseTableV = HWScoreHouseTableView(frame:frame)
                houseTableV.backgroundColor = CD_BackGroundColor
                mainScrollV?.addSubview(houseTableV)
            }
            else if i == 1
            {
                var certificateTableV = HWScoreCertificateTableView(frame:frame)
                certificateTableV.backgroundColor = CD_BackGroundColor
                mainScrollV?.addSubview(certificateTableV)
            }
            else if i == 2
            {
                var finaceTableV = HWScoreFinanceTableView(frame:frame)
                finaceTableV.backgroundColor = CD_BackGroundColor
                mainScrollV?.addSubview(finaceTableV)
            }
            else
            {
                var offLineTableV = HWScoreOfflineTableView(frame:frame)
                offLineTableV.backgroundColor = CD_BackGroundColor
                mainScrollV?.addSubview(offLineTableV)
            }
        }
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "kHouseScoreNotification", object: nil)
    }
    
    // MARK: 通知传值
    func getHeaderData(notification:NSNotification)
    {
        var dic : NSDictionary? = notification.userInfo
        for var i = 0; i < headerLabelcount;i++
        {
            var label:UILabel = segmentedCtr?.viewWithTag(1200 + i) as UILabel
            if i == 0
            {
                label.text = dic?.stringObjectForKey("houseNum")
            }
            else if i == 1
            {
                label.text = dic?.stringObjectForKey("warrantNum")
            }
            else if i == 2
            {
                label.text = dic?.stringObjectForKey("financeNum")
            }
            else if i == 3
            {
                label.text = dic?.stringObjectForKey("subNum")
            }
        }
    }
    // MARK: 点击segment的代理
    func selectedIndex(index: Int)
    {
        mainScrollV?.setContentOffset(CGPointMake(kScreenWidth * CGFloat(index), 0), animated: true)
    }
    
//    //MARK - UIScrollerView Delegate
//    func scrollViewDidScroll(scrollView: UIScrollView)
//    {
//        if scrollView == mainScrollV
    
//        {
//            var page:CGFloat = scrollView.contentOffset.x / scrollView.frame.size.width
//        println("contentOffset\(scrollView.contentOffset.x)")
//        println("width\(scrollView.frame.size.width)")
//            segmentedCtr?.selectedSegmentIndex = Int(page)
//        }
//    }
//    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
//        
//    }
//    
    
    // MARK: 点击跳转到我的排行榜
    func pushGrade()
    {
        var gradeVC = HWChartsViewController()
        self.navigationController?.pushViewController(gradeVC, animated: true)
    }

    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "kHouseScoreNotification", object: nil)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
