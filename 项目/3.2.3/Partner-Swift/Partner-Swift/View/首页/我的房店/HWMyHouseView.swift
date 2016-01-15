//
//  HWMyHouseView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-我的房源列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建
//    陆晓波      2015-03-06           增加代理,录入房源按钮
//    陆晓波      2015-03-18           新增埋点

import UIKit

protocol HWMyHouseViewDelegate:NSObjectProtocol
{
    func didSelectedHouseList(model:HWMyHouseModel)
    func didClickWriteInBtn()
}

class HWMyHouseView: HWBaseRefreshView,HWMyHouseCellDelegate,UIAlertViewDelegate
{
    weak var houseViewDelegate:HWMyHouseViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        self.baseTable.frame = CGRectMake(self.baseTable.frame.origin.x, self.baseTable.frame.origin.y, self.baseTable.frame.size.width, self.baseTable.frame.size.height - 45)
        self.baseTable.registerClass(HWMyHouseCell.self, forCellReuseIdentifier: "cell")
        self.queryListData()
    }
    
    func createWriteInBtn()
    {
        //录入按钮
        var writeInBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        writeInBtn.frame = CGRectMake(0, contentHeight - 45, kScreenWidth, 45)
        writeInBtn.titleLabel?.font = Define.font(TF_19)
        writeInBtn.setTitle("录入房源", forState: UIControlState.Normal)
        
        writeInBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(kScreenWidth, 45)), forState: UIControlState.Normal)
        writeInBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor_Clicked, _size: CGSizeMake(kScreenWidth, 45)), forState: UIControlState.Highlighted)
        writeInBtn.addTarget(self, action: "toWriteInHouse", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(writeInBtn)
        self.bringSubviewToFront(writeInBtn)
    }
    
    override func queryListData()
    {
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        //加载房源列表
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        manager.postHttpRequest(kMyHouseList, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                var dataArray : NSArray = responseObject.arrayObjectForKey("data")
                if (dataArray.count < kPageCount)
                {
                    self.isLastPage = true
                }
                else
                {
                    self.isLastPage = false
                }
                if (self.currentPage == 1)
                {
                    self.baseListArr.removeAllObjects()
                }
                for dica in dataArray
                {
                    let model = HWMyHouseModel(dict: dica as NSDictionary)
                    self.baseListArr.addObject(model)
                }
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0)
                {
                    self.showEmptyView("暂无房源")
                }
                else
                {
                    self.hideEmptyView()
                }
//                println("count==\(self.baseListArr.count)")
            })
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0 && code.integerValue == kStatusFailure)
                {
                    self.showNetworkErrorView(kFailureDetail)
                }
                else
                {
                    self.showEmptyView(error)
                }
        }
    }
    
    //MARK:--录入按钮点击事件
    func toWriteInHouse()
    {
        //埋点：我的房店-我的房源 点击发布房源
        MobClick.event("SubmitSCDhouse_click")
        
        houseViewDelegate?.didClickWriteInBtn()
    }
    
    //MARK:--tableView delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWMyHouseCell
        cell.myHouseCellDelegate = self
        if (self.baseListArr.count > 0)
        {
            cell.fillWithData(self.baseListArr.pObjectAtIndex(indexPath.row) as HWMyHouseModel)
        }
        cell.contentView.drawBottomLine()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var model:HWMyHouseModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMyHouseModel;
        var strSign:NSString = model.sign!
        
        var arrSign:NSMutableArray? = NSMutableArray()
        if (model.sign == "<null>" || model.sign?.length == 0 || model.sign == "")
        {
            arrSign = Optional.None
        }
        else
        {
            arrSign = NSMutableArray(array: strSign.componentsSeparatedByString(","))
        }
        var _signLableView:HWStreamLabelView = HWStreamLabelView(item: arrSign, constrainedFrame: CGRectMake(15, 60 ,kScreenWidth-30, 1000), constrainedItemSize: CGSizeMake(1000, 18));
       if(_signLableView.rows == 0)
       {
         return 90 * kRate
        }
        else
       {
        var j:CGFloat = CGFloat(_signLableView.rows)+1.0;
        return 90 * kRate + j*18;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        houseViewDelegate?.didSelectedHouseList(self.baseListArr.pObjectAtIndex(indexPath.row) as HWMyHouseModel)
    }
    
    //MARK:--cell 点击刷新按钮代理
    func didClickRefreshBtn(model: HWMyHouseModel)
    {
        //埋点：我的房店-我的房源 点击刷新
        MobClick.event("SCDhouse-refresh_click")
        
        Utility.showMBProgress(self, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(model.scdhandHousesId, forKey: "id")
        
        manager.postHttpRequest(kRefresh, parameters: param, queue: nil, success:
        { (responseObject) -> Void in
            Utility.hideMBProgress(self)
            
            let status:NSString = responseObject.stringObjectForKey("status")
            if (status == "1")
            {
                let isSuccess:NSString = responseObject.dictionaryObjectForKey("data").stringObjectForKey("puttopCount")
                let infoStr:NSString = responseObject.dictionaryObjectForKey("data").stringObjectForKey("info")
                //置顶失败
                if (isSuccess == "-1")
                {
                    let alert = UIAlertView(title: "刷新失败", message: infoStr, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "确定")
                    alert.show()
                }
                else
                {
                    let alert = UIAlertView(title: "刷新成功", message: infoStr, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "确定")
                    alert.show()
                    self.currentPage = 1
                    self.baseListArr.removeAllObjects()
                    self.queryListData()
                }
            }
            else
            {
                Utility.showToastWithMessage(responseObject.stringObjectForKey("detail"), _view: self)
            }
        })
        { (code, error) -> Void in
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
        }

    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
