//
//  HWSubordinateRefreshView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWSubordinateDelegate
{
    func didSelectedCell(id:NSString)
}



class HWSubordinateRefreshView: HWBaseRefreshView ,UIActionSheetDelegate,MTCustomActionSheetDelegate{
    
var brokerListArr = NSMutableArray()
var delegate:HWSubordinateDelegate?
 
    var pageSize:NSInteger = 10
    var monthParma:NSString?
    
    var selectedDate:NSDate = NSDate()
    var topView:HWSubordinateTopView?
    var midView:UIView?
    
    var bottomLine:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topView = HWSubordinateTopView(frame: CGRectMake(0, 0, kScreenWidth, 230 * kScreenRate))
        self.addSubview(topView!)
        //回调
        topView?.selectMonth = {()->Void in
              println("大家好")
            self.showMonthSelect()
        }
        
        //跳转页面默认显示当月业绩
        var dateNow = NSDate()
        var dateFor = NSDateFormatter()
//        dateFor.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        Utility.getTimestampWithTime(dateFor.stringFromDate(dateNow))
//        monthParma = Utility.getTimestampWithTime(dateFor.stringFromDate(dateNow))
        dateFor.dateFormat = "yyyy-MM-dd"
        monthParma = dateFor.stringFromDate(dateNow)
        dateFor.dateFormat = "yyyy-MM"
        topView?.monthLabel?.text = dateFor.stringFromDate(dateNow)
        
        
        midView = UIView(frame: CGRectMake(0, 230 * kScreenRate, kScreenWidth, 10 * kScreenRate))
        midView?.backgroundColor = CD_BackGroundColor
        self.addSubview(midView!)
                
        midView?.drawBottomLine()
        midView?.hidden = true

        self.baseTable.frame = CGRectMake(0, 240 * kScreenRate, kScreenWidth, self.bounds.size.height -  240 * kScreenRate)
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.baseTable.delegate = self
        self.baseTable.dataSource = self
        
        self.loadTopViewData()
        self.queryListData()
        
        
    }
    
    //家在顶部业绩相关数据
    func loadTopViewData()
    {
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        //var dateNow = NSDate()
        //var dateFor = NSDateFormatter()
//        dateFor.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        Utility.getTimestampWithTime(dateFor.stringFromDate(dateNow))
        //parma.setPObject(Utility.getTimestampWithTime(dateFor.stringFromDate(dateNow)), forKey: "date")
        parma.setPObject(monthParma, forKey: "date")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kSubordinateAchievementForOneMonth, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
//                println("下线业绩 ================= \(responseObject)")
                var responseDic = responseObject as NSDictionary
                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
                
                let str = responseDic.stringObjectForKey("detail")
                println(str)
                
                self.topView?.setYuanLabel(dataDic.stringObjectForKey("result"))
                
                let fillingRes:NSString = self.isStringNil(dataDic.stringObjectForKey("fillingRes"))
                let visitRes:NSString = self.isStringNil(dataDic.stringObjectForKey("visitRes"))
                let buyRes:NSString = self.isStringNil(dataDic.stringObjectForKey("buyRes"))
                let dealRes:NSString = self.isStringNil(dataDic.stringObjectForKey("dealRes"))
                
                var fourDataArr = [fillingRes,visitRes,buyRes,dealRes]
                //println("fourDataArr ============== \(fourDataArr)")
                self.topView?.fetchFourData(fourDataArr)
                
            }) { (failure, error) -> Void in
                println("请求失败")
        }
    }
    
    //请求列表数据
    override func queryListData() -> Void
    {
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(currentPage, forKey: "pageNumber")
        parma.setPObject(pageSize, forKey: "pageSize")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kSubordinateList, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
//                println("下线列表 ================= \(responseObject)")
                var responseDic = responseObject as NSDictionary
                var dataArr = responseDic.arrayObjectForKey("data") as NSArray
                //var listArr = dataDic.arrayObjectForKey("content")
                
                //列表是否有数据的操作
                if dataArr.count == 0
                {
                    self.midView?.hidden = true
                    self.showEmptyView("无下线数据")
                }
                else
                {
                    self.midView?.hidden = false
                }
                
                var subArr = NSMutableArray()
                for var i = 0; i<dataArr.count; i++
                {
                    var model = HWSubordinateModel()
                    var dic: AnyObject? = dataArr.pObjectAtIndex(i)
                    model.fetchData(dic as NSDictionary)
                    subArr.addObject(model)
                }

                if (dataArr.count < self.pageSize)
                {
                    self.isLastPage = true
                }
                else
                {
                    self.isLastPage = false
                }
                
                if (self.currentPage == 1)
                {
                    //self.baseListArr.removeAllObjects()
                    self.baseListArr = NSMutableArray(array: subArr)
                }
                else
                {
                    self.baseListArr.addObjectsFromArray(subArr)
                }
//                println("ArrayCount ================== \(self.baseListArr.count)")
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if(self.baseListArr.count == 0)
                {
                    self.showEmptyView("列表数据为空")
                }
                else
                {
                    self.hideEmptyView()
                }

                
            }) { (failure, error) -> Void in
                //println("请求失败")
                self.doneLoadingTableViewData()
                self.showNetworkErrorView("请求失败")
        }
    }
    
    //顶部视图点击回调 显示出年月选择器
    func showMonthSelect()
    {
        let datePicker = MTCustomActionSheet(SRMonthPicker: selectedDate)
        datePicker.delegate = self
        datePicker.showInView(shareAppDelegate.window)
    }
    
    //时间选择器选择年月后的回调
    func actionSheet(actionSheet: MTCustomActionSheet!, didClickButtonByIndex index: Int32, selectMonthDate date: NSDate!) {
        
        println(date)
        var dateFor = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd"
        var dateStr = dateFor.stringFromDate(date)
        monthParma = dateStr
        dateFor.dateFormat = "yyyy-MM"
        self.topView?.monthLabel?.text = dateFor.stringFromDate(date)
        self.loadTopViewData()
    }
    
    
    func isStringNil(str:NSString) -> NSString
    {
        var rStr:NSMutableString
        if str == ""
        {
            rStr = "0组"
            return rStr
        }
        return "\(str)组"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.baseListArr.count
        //return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70 * kScreenRate
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UserInfoCellIdentifier";
        var cell: HWSubordinateCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HWSubordinateCell
        if cell == Optional.None
        {
            cell = HWSubordinateCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        var model: HWSubordinateModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWSubordinateModel
        
                var key = model?.mongKey as String
        var url = NSURL(string:Utility.imageDownloadWithMongoDbKey(key))
        cell?.headImgView?.setImageWithURL(url, placeholderImage: UIImage(named: "personal_2"))
        cell?.nameLabel?.text = model?.brokerName
        cell?.phoneNumLabel?.text = model?.brokerPhone
        var achievementStr = model?.singleResult
        var subStr = self.stringisEqualtoEmpty(achievementStr!)
        cell?.achievementLabel?.attributedText = self.setAttributeString("累计业绩:\(subStr)", range: 5)
        
        var customerNumStr = model?.clientNum
        var subStr2 = self.stringisEqualtoEmpty2(customerNumStr!)
        cell?.customerNumLabel?.attributedText = self.setAttributeString("客户:\(subStr2)组", range: 3)
        
        cell?.customerNumLabel?.attributedText
        cell?.callBtn?.tag = indexPath.row + 100
        cell?.callBtn?.addTarget(self, action: "callAction:", forControlEvents:UIControlEvents.TouchUpInside)

        return cell!
    }

    func callAction(sender:UIButton)
    {
        println("打电话")
        
        var model:HWSubordinateModel = self.baseListArr.pObjectAtIndex(sender.tag - 100) as HWSubordinateModel
        
        var callWebView = UIWebView()
        self.addSubview(callWebView)
        var telUrl = NSURL(string: "tel:\(model.brokerPhone!)")
        callWebView.loadRequest(NSURLRequest(URL: telUrl!))

    }
    
    func setAttributeString(str:NSString,range:Int) ->NSMutableAttributedString
    {
        var attriStr = NSMutableAttributedString(string: str)
        attriStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_Color_66, range: NSMakeRange(0, range))
        return attriStr
    }
    
    func stringisEqualtoEmpty(str:NSString) ->NSString
    {
        var toStr = NSString()
        if str.isEqualToString("")
        {
            toStr = "￥0.00"
        }
        else
        {
            println("a ======================= \(str)")
            var numberFormatter = NSNumberFormatter()
            numberFormatter.positiveFormat = "0.00"
            var subStr = numberFormatter.stringFromNumber(NSNumber(double: str.doubleValue))
            toStr = "￥\(subStr!)"
        }
        return toStr
    }
    
    func stringisEqualtoEmpty2(str:NSString) ->NSString
    {
        var toStr = NSString()
        if str.isEqualToString("")
        {
            toStr = "0"
        }
        else
        {
            toStr = "\(str)"
        }
        return toStr
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
     {
        println("index = \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        var model:HWSubordinateModel = baseListArr.pObjectAtIndex(indexPath.row) as HWSubordinateModel
        
        delegate?.didSelectedCell(model.brokerId!)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
