//
//  HWChartsRefreshView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum selectedType:Int
{
    case personal
    case organization 
}

class HWChartsRefreshView: HWBaseRefreshView ,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate
{
    var type:selectedType = selectedType.personal
    
    var topInfoView :HWChartsHeadView?
    var requestUrl = kBrokerCharts

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.isLastPage = true
        
        topInfoView = HWChartsHeadView(frame: CGRectMake(0, 0, kScreenWidth, (120 + 30) * kScreenRate))
        self.addSubview(topInfoView!)
        self.topInfoView?.hidden = true
        
        self.baseTable.frame = CGRectMake(0,(120 + 30) * kScreenRate, kScreenWidth, contentHeight - (120 + 30) * kScreenRate)
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.baseTable.delegate = self
        self.baseTable.dataSource = self
        self.baseTable.hidden = true
        requestUrl = kBrokerCharts
        
        self.queryListData()
    }
    
    override func queryListData()
    {
        self.topInfoView?.hidden = true
        self.baseTable.hidden = true
        self.hideEmptyView()
        self.baseListArr.removeAllObjects()
        self.baseTable.reloadData()
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        
        Utility.showMBProgress(self, _message: "请求数据")
        
        manager.postHttpRequest(requestUrl, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                println("responseObject ================== \(responseObject)")
                
                var responseDic = responseObject as NSDictionary
                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
                
                let month = dataDic.stringObjectForKey("month")
                
                Utility.hideMBProgress(self)
                
                self.topInfoView?.hidden = false
                self.topInfoView?.titleLabel?.text = "我的\(month)月业绩"
                self.topInfoView?.listTitleLabel?.text = "\(month)月个人排行 TOP20↑"
                self.topInfoView?.bottomL?.text = "\(HWUserLogin.currentUserLogin().cityName)经纪人"//??参数不明

                
                var achievement = dataDic.stringObjectForKey("myResult")
                self.topInfoView?.achievementLabel?.attributedText = self.setYuanAttibuteString("\(achievement)", font: TF_19)
//                self.topInfoView?.achievementLabel?.attributedText = Utility.setYuanAttibuteString("\(achievement)", font: TF_19)
                
                var percent = dataDic.stringObjectForKey("percent")
                if percent.isEqualToString("") || percent == Optional.None
                {
                    percent = "0%"
                }
                
                self.topInfoView?.percentageLabel?.text = percent
                
                var listArr = dataDic.arrayObjectForKey("content")
                
                if listArr.count == 0
                {
                    self.showEmptyViewFullOfView("排行榜无内容")
                }
                
                var maxCount = 20
                if listArr.count < 20
                {
                    maxCount = listArr.count
                }
                for var i = 0; i < maxCount; i++
                {
                    var model = HWChartsModel()
                    var dic: NSDictionary = listArr.pObjectAtIndex(i) as NSDictionary
                    model.fetchData(dic)
                    self.baseListArr.addObject(model)
                }
                self.baseTable.hidden = false
                
//                println("self.baseListArr.count =============== \(self.baseListArr.count)")
                
                self.doneLoadingTableViewData()
                
                self.baseTable.reloadData()
                
            }) { (failure, error) -> Void in
                println("请求失败")
                self.doneLoadingTableViewData()
                Utility.hideMBProgress(self)
                self.showNetworkErrorViewFullofView("请求失败，点击重新加载！")
        }
    }
    
    //MARK:UITableViewDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80 * kScreenRate
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UserInfoCellIdentifier";
        var cell: HWChartsCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HWChartsCell
        if cell == Optional.None
        {
            cell = HWChartsCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.None;
        
        let model: HWChartsModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWChartsModel
        
        cell?.numLabel?.text = "\(indexPath.row + 1)"
        
//        if (requestUrl.isEqualToString(kBrokerCharts))
//        {
//            cell?.companyNameLabel?.text = Optional.None
//            cell?.nameLabel?.text = model?.name
//            var imgUrl = model?.picKey
//            var url = NSURL(string: imgUrl!)
//            cell?.headImgView?.setImageWithURL(url, placeholderImage: UIImage(named:"personal_2"))
//        }
//        else
//        {
//            cell?.headImgView?.image = Optional.None
//            cell?.nameLabel?.text = Optional.None
//            cell?.companyNameLabel?.text = model?.name
//        }
        
        cell?.companyNameLabel?.text = Optional.None
        cell?.nameLabel?.text = model?.name
        var imgUrl = model?.picKey
        var url = NSURL(string: Utility.imageDownloadWithMongoDbKey(imgUrl!))
        cell?.headImgView?.setImageWithURL(url, placeholderImage: UIImage(named:"personal_2"))
        
//        println("result ================= \(model?.result)")
        
        var achStr = model?.result
        cell?.achievementLabel?.attributedText = setYuanAttibuteString(achStr!, font: TF_12)
        
        return cell!
    }
    
    
    func setYuanAttibuteString(str:NSString, font:CGFloat) -> NSMutableAttributedString
    {
        var achievement:NSString = ""
        if str.isEqualToString("")
        {
            achievement = "￥0.00"
        }
        else
        {
            var numberFormatter = NSNumberFormatter()
            numberFormatter.positiveFormat = "0.00"
            var str:NSString = numberFormatter.stringFromNumber(NSNumber(double:str.doubleValue))!
            achievement = "￥\(str)"
        }
        var attriStr = NSMutableAttributedString(string: achievement)
        attriStr.addAttribute(NSFontAttributeName, value: Define.font(font), range: NSMakeRange(0, 1))
        return attriStr
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
