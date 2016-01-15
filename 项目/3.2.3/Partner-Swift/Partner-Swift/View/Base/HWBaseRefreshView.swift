//
//  HWBaseRefreshView.swift
//  SwiftTest
//
//  Created by caijingpeng.haowu on 15/2/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWBaseRefreshView: UIView, UITableViewDelegate, UITableViewDataSource, EGORefreshTableDelegate,SRRefreshDelegate {

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isHeadLoading: Bool = false
    var isTailLoading: Bool = false
    var isNeedHeadRefresh: Bool = true     // 是否需要下拉刷新
    
    var baseFrame: CGRect?
    var refreshHeadView: EGORefreshTableHeaderView!
    var refreshFooterView: EGORefreshTableFooterView!
    var endView: UIView?
    
    var baseTable: UITableView!
    var baseListArr: NSMutableArray = NSMutableArray()
    var currentPage: Int = 1
    var isLastPage: Bool = true
    var slimeView:SRRefreshView!
    var pulldownState:EGORefreshPos?
    // MARK:   Public Method
    
    func doneLoadingTableViewData() -> Void
    {
        self.finishedLoadData()
        self.setFooterView()
    }
    
    func queryListData() -> Void
    {
        
    }
    
    // 主动调用下拉刷新
    func refreshData() -> Void
    {
        if (isNeedHeadRefresh)
        {
            self.queryListData()
//            self.baseTable.setContentOffset(CGPointMake(0, -65), animated: true)
//            self.slimeView.slime.state = SRSlimeStateShortening
//            self.slimeView.pullApart(nil)
        }
    }
    
    func showEmptyView(message: NSString) -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1111)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
        
        weak var weakSelf: HWBaseRefreshView? = self;
        
        //        empty
        
        let emptyV: HWEmptyControl = HWEmptyControl(frame: self.baseTable.frame, titleStr: message, imageName: "nothing") { () -> Void in
            self.queryListData()
        }
        emptyV.tag = 1111
        self.addSubview(emptyV)
    }
    func showEmptyRedView(message: NSString) -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1111)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
        
        weak var weakSelf: HWBaseRefreshView? = self;
        
        //        empty
        
        let emptyV: HWEmptyControl = HWEmptyControl(frame: self.baseTable.frame, titleStr: message, imageName: "no_hb") { () -> Void in
            self.queryListData()
        }
        emptyV.tag = 1111
        self.addSubview(emptyV)
    }
    func showNetworkErrorView(message: NSString) -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1111)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
        
        weak var weakSelf: HWBaseRefreshView? = self;
        
        //        empty
        
        let emptyV: HWEmptyControl = HWEmptyControl(frame: self.baseTable.frame, titleStr: message, imageName: "no_wifi") { () -> Void in
            self.queryListData()
        }
        emptyV.tag = 1111
        self.addSubview(emptyV)
    }
    
    
    func showEmptyViewFullOfView(message:NSString) -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1111)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
        
        weak var weakSelf: HWBaseRefreshView? = self;
        
        //        empty
        
        let emptyV: HWEmptyControl = HWEmptyControl(frame: self.frame, titleStr: message, imageName: "nothing") { () -> Void in
            self.queryListData()
        }
        emptyV.tag = 1111
        self.addSubview(emptyV)
    }
    
    func showNetworkErrorViewFullofView(message:NSString) -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1111)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
        
        weak var weakSelf: HWBaseRefreshView? = self;
        
        //        empty
        
        let emptyV: HWEmptyControl = HWEmptyControl(frame: self.frame, titleStr: message, imageName: "no_wifi") { () -> Void in
            self.queryListData()
        }
        emptyV.tag = 1111
        self.addSubview(emptyV)
    }
    
    func showEmptyView(message: NSString, offset: Float)
    {
        
    }
    
    func hideEmptyView() -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1111)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
    }
    
    // MARK: Set Get
    
    func setIsNeedHeadRefresh(isNeed: Bool) -> Void
    {
        isNeedHeadRefresh = isNeed
        if (isNeed)
        {
            slimeView.hidden = false
        }
        else
        {
            slimeView.hidden = true
        }
    }
    
    // MARK: Private Method
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = CD_BackGroundColor
        initBaseView()
    }
    
    func initBaseView() -> Void
    {
        self.baseTable = UITableView(frame: self.bounds, style: UITableViewStyle.Plain)
        self.baseTable.delegate = self
        self.baseTable.dataSource = self
        self.baseTable.backgroundColor = UIColor.clearColor()
        self.baseTable.backgroundView = nil
        self.baseTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.addSubview(self.baseTable)
        
        
        
        self.baseTable.showsVerticalScrollIndicator = false
        slimeView = SRRefreshView()
        slimeView.slimeMissWhenGoingBack = true
        slimeView.slime.bodyColor = CD_Btn_MainColor
        slimeView.slime.skinColor = UIColor.whiteColor()
        slimeView.slime.lineWith = 1
        slimeView.backgroundColor = UIColor.clearColor()
        slimeView.delegate = self
        self.baseTable.addSubview(slimeView)
        
        
    }
    
    // MARK: Data Source Loading / Reloading Methods
    
    func reloadTableViewDataSource() -> Void
    {
        isHeadLoading = true
        self.queryListData()
    }
    
    func finishedLoadData() -> Void
    {
        isHeadLoading = false
        if (slimeView != nil)
        {
            slimeView.endRefresh()
            
        }
        
        if (refreshFooterView != nil)
        {
            refreshFooterView.egoRefreshScrollViewDataSourceDidFinishedLoading(self.baseTable)
            self.setFooterView()
        }
    }
    
    func egoRefreshTableDataSourceLastUpdated(view: UIView!) -> NSDate!
    {
        return NSDate(timeIntervalSinceNow: 0)
    }
    
    func setFooterView() -> Void
    {
        let height: CGFloat = max(baseTable.contentSize.height, baseTable.frame.size.height)
        
        let footerFrame: CGRect = CGRectMake(0, height, self.baseTable.frame.size.width, self.bounds.size.height)
        
        if (refreshFooterView != nil)
        {
            refreshFooterView.frame = footerFrame
        }
        else
        {
            refreshFooterView = EGORefreshTableFooterView(frame: footerFrame)
            refreshFooterView.backgroundColor = UIColor.clearColor()
            refreshFooterView.delegate = self
            self.baseTable.addSubview(refreshFooterView)
        }
        
        if (isLastPage)
        {
            refreshFooterView.hidden = true
        }
        else
        {
            refreshFooterView.hidden = false
        }
        
        if ((refreshFooterView) != nil)
        {
            refreshFooterView.refreshLastUpdatedDate()
        }
    }
    
    // MARK: UIScrollViewDelegate Methods
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if (isNeedHeadRefresh)
        {
            slimeView.scrollViewDidScroll()

            
        }
        
        if (refreshFooterView != nil)
        {
            refreshFooterView.egoRefreshScrollViewDidScroll(scrollView)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if (isNeedHeadRefresh)
        {
            slimeView.scrollViewDidEndDraging()
        }
        
        if (refreshFooterView != nil && !isHeadLoading && !isLastPage)
        {
            refreshFooterView .egoRefreshScrollViewDidEndDragging(scrollView)
        }
    }
    
    // MARK: EGORefreshTableHeaderDelegate Methods
    
    func egoRefreshTableDataSourceIsLoading(view: UIView!) -> Bool
    {
        return isHeadLoading;
    }
    func slimeRefreshStartRefresh(refreshView: SRRefreshView!) {

        self.beginToReloadData(EGORefreshHeader)
        
    }
    
    func egoRefreshTableDidTriggerRefresh(aRefreshPos: EGORefreshPos) -> Void
    {
        self.beginToReloadData(aRefreshPos)
    }
    
    func beginToReloadData(aRefreshPos : EGORefreshPos) -> Void
    {
        isHeadLoading = true;
        
        if (aRefreshPos.value == EGORefreshHeader.value)
        {
            // pull down to refresh data
            currentPage = 1
            
        }
        else if(aRefreshPos.value == EGORefreshFooter.value && !isLastPage)
        {
            // pull up to load more data
            currentPage++
        }
        self.reloadTableViewDataSource()
    }
    
    // MARK: Tableview Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
//        cell.textLabel.text = String(format: "%i", indexPath.row)
        return cell
    }


}
