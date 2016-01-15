//
//  HWNewView.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/2/12.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
//import "Partner-Swift.Swift.h"

protocol HWNewViewDelegate
{
    func push(viewController : UIViewController)
}

class HWNewView: HWBaseRefreshView,HWNewCellDelegate,CustomSearchViewDelegate,UIAlertViewDelegate
{
    //FIXME: weak  byNiedi
    var delegate : HWNewViewDelegate?
    var houseVC : UIViewController!

    var zoneId : NSString?
    var plateId : NSString?
    var type : NSString?
    var totalStr: NSString! = ""
    var sort : NSString?
    var hourseModel:HWNewHouseListModel?
    var indexPath:NSIndexPath?
    var maxTime:Int!//最大时间
    var timer:NSTimer?
    var activityNum = 0//倒计时加
    var freezeTime:Int! //剩余时间
    var choiceSectionViews:CustomSearchView!
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refshqueryListData", name: kUpdateUserInfo, object: nil)
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryListData", name: "queryListData", object: nil)
        
        var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        var filePath = documentsDirectory.stringByAppendingPathComponent("city.plist")
        var cities : NSArray = NSArray(contentsOfFile: filePath)!
        
        var cityClass : HWCityClass = HWCityClass(dic: cities[0] as NSDictionary)
        
        
        for var i = 0; i < cities.count; i++
        {
            var cityCl = HWCityClass(dic: cities[i] as NSDictionary)
            if (cityCl.cityId! == HWUserLogin.currentUserLogin().cityId)
            {
                cityClass = cityCl
            }
        }
        //MYP add v3.2.1 新增收藏排序筛选
         choiceSectionViews = CustomSearchView(items: [cityClass.areas!,["不限","住宅", "商住", "别墅/豪宅","商业"],["默认排序","楼盘均价正序","楼盘均价倒序","开盘时间正序","开盘时间倒序","红包排序","收藏排序"]], andDefaultTitles: ["区域","类型","排序"], hasSubTitles: true);
        //主视图
        choiceSectionViews.delegate = self;
        self.addSubview(choiceSectionViews)
        
        self.baseListArr = HWCoreDataManager.loadNewList()
        totalStr = "\(self.baseListArr.count)"
        self.createHeader()
        
        self.baseTable.frame = CGRectMake(0, 35, kScreenWidth, frame.size.height - 35)
        baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.isNeedHeadRefresh = true
        self.baseTable.reloadData()
        //
        self.queryListData()
    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
//    MARK:UITableViewDelegate
    func refshqueryListData()
    {
        choiceSectionViews.removeFromSuperview()
        var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        var filePath = documentsDirectory.stringByAppendingPathComponent("city.plist")
        var cities : NSArray = NSArray(contentsOfFile: filePath)!
        var cityClass : HWCityClass = HWCityClass(dic: cities[0] as NSDictionary)
        for var i = 0; i < cities.count; i++
        {
            var cityCl = HWCityClass(dic: cities[i] as NSDictionary)
            if (cityCl.cityId! == HWUserLogin.currentUserLogin().cityId)
            {
                cityClass = cityCl
            }
        }
        //MYP add v3.2.1 新增收藏排序筛选
        var choiceSectionView: CustomSearchView = CustomSearchView(items: [cityClass.areas!,["不限","住宅", "商住", "别墅/豪宅","商业"],["默认排序","楼盘均价正序","楼盘均价倒序","开盘时间正序","开盘时间倒序","红包排序","收藏排序"]], andDefaultTitles: ["区域","类型","排序"], hasSubTitles: true);
        choiceSectionView.delegate = self;
        self.addSubview(choiceSectionView)
        currentPage = 1
        
        self.zoneId = ""
        self.plateId = ""
        self.type = ""
        self.sort = ""
        
        self.queryListData()
    }
    override func queryListData() {
        var manager : HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        var dict : NSMutableDictionary = ["key":HWUserLogin.currentUserLogin().key]
        dict.setObject("\(currentPage)", forKey: "pageNumber")
        dict.setObject("\(kPageCount)", forKey: "pageSize")
        if self.zoneId != nil
        {
            dict.setObject(self.zoneId!, forKey: "regionId")
        }
        if self.plateId != nil
        {
            dict.setObject(self.plateId!, forKey: "plateId")
        }
        if self.type != nil
        {
            dict.setObject(self.type!, forKey: "type")
        }
        if self.sort != nil
        {
            dict.setObject(self.sort!, forKey: "order")
        }
        Utility.hideMBProgress(self)
        manager.postHttpRequest(kNewHouseList, parameters: dict, queue: nil, success: { (responObject) -> Void in
            var content : NSArray = responObject.arrayObjectForKey("data")
            if content.count < kPageCount
            {
                self.isLastPage = true
            }else
            {
                self.isLastPage = false
            }
            
            if self.baseListArr == Optional.None
            {
                self.baseListArr = NSMutableArray()
            }
            if self.currentPage == 1
            {
                self.baseListArr = NSMutableArray()
            }
            
            for var i = 0; i < content.count; i++
            {
                var newModel : HWNewHouseListModel = HWNewHouseListModel()
                newModel.fill(content[i] as NSDictionary)
                self.baseListArr.addObject(newModel)
            }
            if self.currentPage == 1
            {
                HWCoreDataManager.saveNewList(self.baseListArr)
            }
            self.totalStr = responObject.stringObjectForKey("totalSize")
            self.createHeader()
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            
            if self.baseListArr.count == 0
            {
                self.showEmptyView("无数据")
            }
            else
            {
                self.hideEmptyView()
            }
            self.maxTime = 0
            self.activityNum = 0
            if self.timer != nil
            {
                self.timer!.invalidate()
                self.timer = nil

            }
            for var i = 0; i < self.baseListArr.count; i++
            {
                var newModel = self.baseListArr.pObjectAtIndex(i) as HWNewHouseListModel
                self.freezeTime = newModel.waitTime.integerValue / 1000
                self.maxTime = self.freezeTime > self.maxTime ? self.freezeTime:self.maxTime
            }
            if self.timer == nil
            {
                
                self.timer = NSTimer(timeInterval: 1, target: self, selector: "countDown", userInfo: nil, repeats: true)
                NSRunLoop .mainRunLoop() .addTimer(self.timer!, forMode: NSRunLoopCommonModes)
                
            }
        }) { (failure, error) -> Void in
            self.doneLoadingTableViewData()
            if(self.baseListArr.count == 0 && failure.integerValue == kStatusFailure)
            {
                self.showNetworkErrorView(kFailureDetail)
            }
            else
            {
                Utility.showToastWithMessage(error, _view: self)
            }
        }
    }
    func countDown()
    {
        if ((self.maxTime - activityNum) <= 0)
        {
            timer!.invalidate()
            //NSNotificationCenter.defaultCenter() .postNotificationName("queryListData", object: nil)
        }
         activityNum++ ;
       self.baseTable.reloadData()
    }
    func createHeader(){
        var headerLabel = UILabel(frame: CGRectMake(0, 0, kScreenWidth, 30))
        headerLabel.textColor = "666666".UIColor
        headerLabel.text = "      " + "\(HWUserLogin.currentUserLogin().cityName)" + "新房" + "（" + totalStr + "个" + "）"
        headerLabel.backgroundColor = UIColor.clearColor()
        headerLabel.font = Define.font(12)
        self.baseTable.tableHeaderView = headerLabel
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 150 * kRate
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier : String = "cell"
        var cell : HWNewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HWNewCell
        if cell == Optional.None
        {
            cell = HWNewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            cell?.delegate = self
        } 
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.fillData(self.baseListArr[indexPath.row] as HWNewHouseListModel, index: indexPath ,timer:activityNum)
        cell?.timer(activityNum,model: self.baseListArr[indexPath.row] as HWNewHouseListModel)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        MobClick.event("Newhousedetails_click")
        var newVC : HWNewDetailVC = HWNewDetailVC()
        var newModel : HWNewHouseListModel = self.baseListArr.pObjectAtIndex(NSInteger(indexPath.row)) as HWNewHouseListModel
        newVC.newHouseListModel = newModel
        newVC.houseId = newModel.houseId
        newVC.hasCollected = (newModel.isCollection == "1" ? true:false)
        self.delegate?.push(newVC)
    }
    
    func leftTap(index: NSIndexPath) {
        var baobeiVC : HWBaoBeiVC = HWBaoBeiVC()
        var newModel = self.baseListArr[index.row] as HWNewHouseListModel
        baobeiVC.houseId = newModel.houseId
        baobeiVC.houseName = newModel.houseName
        self.delegate?.push(baobeiVC)
    }
    
    func rightTap(index: NSIndexPath) {
        MobClick.event("Newhouseshare_click")
        var newModel : HWNewHouseListModel = self.baseListArr.pObjectAtIndex(index.row) as HWNewHouseListModel
        hourseModel = newModel;
        indexPath = index;
        
//        var vc  = HWWaltMoneyViewController()
//        vc.money = "10000"
//        self.delegate?.push(vc)
        
        if newModel.typeWalt?.toInt() == 1 || newModel.typeWalt?.toInt() == 2 && newModel.waitTime.integerValue == 0
            
        {
            self.shareBefore(index);
        }
            
       else if newModel.typeWalt?.toInt() == 1 || newModel.typeWalt?.toInt() == 2 && newModel.waitTime.integerValue > 0
        
        {
             self.shareBefore(index);
        }
        else

        {
              self.share();
        }
        
    }
    
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!) {
        MobClick.event("Newhouse-areafilter_click")
        self.zoneId = zoneId
        self.plateId = plateId
        currentPage = 1
        self.queryListData()
    }
    func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!){
        var theIndex = index.toInt()
        if theIndex == 1
        {
            
            self.type = value
            if value == "0"
            {
                self.type = ""
            }
            MobClick.event("Newhouse-typefilter_click")
        }else
        {
            if value == "5"
            {
                
                self.sort = "6"
            }
            else if value == "6"
            {
                
                self.sort = "7"
            }
            else if value == "0"
            {
                self.sort = ""
            }
            else
            {
                self.sort = value
            }
            MobClick.event("Newhouse-sortfilter_click")
        }
        if theIndex >= 5
        {
            theIndex = theIndex! + 1
        }
        currentPage = 1
        self.queryListData()
    }
    
    
    
    func share()
    {
        var image : UIImage  = UIImage(named: "shareIcon")!
        var cell : HWNewCell = self.baseTable.cellForRowAtIndexPath(indexPath!) as HWNewCell
        if cell.headImageV.image != nil
        {
            image = cell.headImageV.image!
        }
        var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + hourseModel!.houseName! + " " + hourseModel!.houseAddress!, image: image, shareUrl: hourseModel!.shareUrl)
        shareModel.projectId = hourseModel!.houseId
        shareModel.showInView(shareAppDelegate.window, presentController: self.houseVC)
        
        
    }
    
    //分享之前的回调
    func shareBefore(index:NSIndexPath)
    {
       
        var cell : HWNewCell = self.baseTable.cellForRowAtIndexPath(index) as HWNewCell
        Utility.showMBProgress(self, _message: "加载中...")
        var params = NSMutableDictionary();
        params.setPObject(Utility_OC.getUUID(), forKey: "mac");
        params.setPObject("8", forKey: "versionCode");
        params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        params.setPObject(hourseModel!.activityId, forKey: "activityId");
        var manager = HWHttpRequestOperationManager.baseManager();
        manager.postHttpRequest(kShareBefore, parameters: params, queue: nil, success: { (responObject) -> Void in
            Utility.hideMBProgress(self);
            
           let status = responObject.stringObjectForKey("data") as String;

            //随机金额
            if(status.toInt() == 1)
            {
                var image : UIImage  = UIImage(named: "shareIcon")!
                if cell.headImageV.image != nil
                {
                    image = cell.headImageV.image!
                }
                var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + self.hourseModel!.houseName! + " " + self.hourseModel!.houseAddress!, image: image, shareUrl: self.hourseModel!.shareUrl)
                shareModel.projectId = self.hourseModel!.houseId
                shareModel.showInView(shareAppDelegate.window, presentController: self.houseVC)
                shareModel.shareSuccess = { type in
                  //self.queryListData()
                self.shareSuccessWithType(type as String , model: self.hourseModel! , status:status as String);

                }
 
           }
           else if status.toInt() == 3
            {
                self.share()
            }

            else
            {
               
                var alert = UIAlertView(title:"", message: responObject.stringObjectForKey("detail"), delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "继续分享")
                alert.show()
                
                
                
            }
            
        }) { (code, error) -> Void in
            Utility.showToastWithMessage(error, _view: self);
            Utility.hideMBProgress(self);
        
        }
    
    }
    
    //分享成功后的回调
    func shareSuccessWithType(type : String! , model : HWNewHouseListModel! , status: String)
    {
        Utility.showMBProgress(self, _message: "加载中...");
        var params = NSMutableDictionary();
        params.setObject(Utility_OC.getUUID(), forKey: "mac");
        params.setPObject(type, forKey: "way");
        params.setPObject(model.activityId, forKey: "activityId");
        params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        params.setPObject(status, forKey: "shareStatus");
        var manager = HWHttpRequestOperationManager.baseManager();
        manager.postHttpRequest(kShareSuccess, parameters: params, queue: nil, success: { (responObject) -> Void in
            Utility.hideMBProgress(self);
            var statusDic = responObject.dictionaryObjectForKey("data") as NSDictionary
            var statuss = statusDic .stringObjectForKey("redType")
        
            //固定金额
            if (statuss == "0")
            {
                var vc  = HWWaltMoneyViewController()
                vc.money = model.moneyWalt
                self.delegate?.push(vc)

            }
            else
            {
                var redRocketCtrl = HWRedRocketViewController();
                redRocketCtrl.moneyStr = statusDic.stringObjectForKey("totalMoney");
                redRocketCtrl.redIdStr = statusDic.stringObjectForKey("redId");
                redRocketCtrl.sourceStr = "1"
                self.delegate?.push(redRocketCtrl);
            }
            
        }) { (code, error) -> Void in
            Utility.showToastWithMessage(error, _view: self);
            Utility.hideMBProgress(self);
            
        }
    }
    
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    
        if (buttonIndex == 1)
        {
            currentPage = 1;
           self.queryListData()

            self.share();
        }
        
        if (buttonIndex == 0)
        {
            currentPage = 1;
           self .queryListData()
        }

    }
    
    
}

