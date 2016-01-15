//
//  HWRelateHouseRefreshView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWRelateHouseRefreshViewDelegate: NSObjectProtocol
{
    func didSelectRelateHouse(house: HWRelateHouseModel?)
}

class HWRelateHouseRefreshView: HWBaseRefreshView {

    var delegate: HWRelateHouseRefreshViewDelegate?
    var clientId: NSString = ""
    var selectedHouse: HWRelateHouseModel?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.baseTable.registerClass(HWRelateNewHouseCell.self, forCellReuseIdentifier: HWRelateNewHouseCell.getIdentify())
        self.baseTable.registerClass(HWScdHouseCell.self, forCellReuseIdentifier: HWScdHouseCell.getIdentify())
        self.setIsNeedHeadRefresh(false)
        self.initialHeaderView()
        
    }
    
    override func drawRect(rect: CGRect) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(1, queue) { () -> Void in
            self.queryListData()
        }
    }
    
    override func queryListData() {
        
        Utility.showMBProgress(self, _message: "加载中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(clientId, forKey: "clientInfoId")
        
        manager.postHttpRequest(kRelateHouse, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            
            let resultNewArray: NSArray = (responseObject.dictionaryObjectForKey("data") as NSDictionary).arrayObjectForKey("newHouseDtos")
            let resultSecondArray: NSArray = (responseObject.dictionaryObjectForKey("data") as NSDictionary).arrayObjectForKey("scdHandHousesConditionsDtos")
            if (resultNewArray.count + resultSecondArray.count == 0)
            {
                self.baseListArr.removeAllObjects()
                self.showEmptyView("无房源")
            }
            else
            {
                self.hideEmptyView()
            }
            
            let modelArray: NSMutableArray = NSMutableArray()
            for (var i = 0; i < resultNewArray.count; i++)
            {
                let dic: NSDictionary! = resultNewArray.pObjectAtIndex(i) as NSDictionary
                let model: HWRelateHouseModel = HWRelateHouseModel(relateHouse: dic)
                
                modelArray.addObject(model)
            }
            for (var i = 0; i < resultSecondArray.count; i++)
            {
                let dic: NSDictionary! = resultSecondArray.pObjectAtIndex(i) as NSDictionary
                let model: HWRelateHouseModel = HWRelateHouseModel(relateHouse: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr = modelArray
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                
                if (code.integerValue == kStatusFailure && self.baseListArr.count == 0)
                {
                    self.showNetworkErrorView("无网络")
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self)
                }
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialHeaderView() -> Void
    {
        let view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        view.backgroundColor = UIColor.clearColor()
        view.drawBottomLine()
        self.baseTable.tableHeaderView = view
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var house: HWRelateHouseModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWRelateHouseModel
        if (house?.houseType.isEqualToString("newHouse") == true)
        {
            return HWRelateNewHouseCell.getCellHeight()
        }
        else
        {
            return HWScdHouseCell.getCellHeight(nil)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var house: HWRelateHouseModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWRelateHouseModel
        if (house?.houseType.isEqualToString("new") == true)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(HWRelateNewHouseCell.getIdentify(), forIndexPath: indexPath) as HWRelateNewHouseCell
            cell.setRelateHouse(house)
           
            var str:String = "\(kBaseImageUrl)";
            var str1:String = house?.housePic as String;
            var str2 = str + str1;
            var urlStr:NSString = str2 .stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
            let url = NSURL(string:urlStr)
            weak var weakImgV: UIImageView? = cell.iconImgV
            
            cell.iconImgV.setImageWithURL(url, placeholderImage:Utility.getPlaceHolderImage(cell.iconImgV.frame.size, imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
                if (error != nil)
                {
                    let size: CGSize! = cell.iconImgV.frame.size
                    weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: " pic_wait_small")
                }
                else
                {
                    weakImgV?.image = image
                    
                }
            }

            cell.contentView.drawBottomLine()
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(HWScdHouseCell.getIdentify(), forIndexPath: indexPath) as HWScdHouseCell
            cell.setRelateHouse(house!)
            
            let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(house?.picKey as String))
            weak var weakImgV: UIImageView? = cell.headImg
            
            cell.headImg.setImageWithURL(url, placeholderImage:Utility.getPlaceHolderImage(cell.headImg.frame.size, imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
                if (error != nil)
                {
                    let size: CGSize! = cell.headImg.frame.size
                    weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: " pic_wait_small")
                }
                else
                {
                    weakImgV?.image = image
                    
                }
            }

            cell.contentView.drawBottomLine()
            return cell
        }
        // selectedHouse  对勾
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var house: HWRelateHouseModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWRelateHouseModel
        if (delegate != nil && delegate?.respondsToSelector("didSelectRelateHouse:") == true)
        {
            delegate?.didSelectRelateHouse(house)
        }
    }
    

}
