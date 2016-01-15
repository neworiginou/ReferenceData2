//
//  HWChartsRefreshView2.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/3/19.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWChartsRefreshView2: HWBaseRefreshView {

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
        self.baseTable.hidden = false
        requestUrl = kCpyCharts
        
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
        
//        println("requestUrl = \(requestUrl)")
        
        manager.postHttpRequest(requestUrl, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                println("responseObject ================== \(responseObject)")
                
                var responseDic = responseObject as NSDictionary
                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
                
                let month = dataDic.stringObjectForKey("month")
                
               // println("cityName ================== \(HWUserLogin.currentUserLogin().cityName)")
                
                self.topInfoView?.hidden = false
                let orgName = dataDic.stringObjectForKey("orgName")
                self.topInfoView?.titleLabel?.text = "\(orgName)\(month)月业绩"
//                self.topInfoView?.bottomL?.text = "\(HWUserLogin.currentUserLogin().cityName)经纪公司"//??参数不明
                self.topInfoView?.bottomL?.text = "\(HWUserLogin.currentUserLogin().orgCityName)经纪公司"
                //self.topInfoView?.bottomL?.text = "乌鲁木齐市经济公司"
                self.topInfoView?.listTitleLabel?.text = "\(month)月机构排行 TOP20↑"
                var achievement = dataDic.stringObjectForKey("myResult")
                //println("achievement ================= \(achievement)")
                self.topInfoView?.achievementLabel?.attributedText = self.setYuanAttibuteString("\(achievement)", font: TF_19)
                
                var percent = dataDic.stringObjectForKey("percent")
                if percent.isEqualToString("") || percent == Optional.None
                {
                    percent = "0%"
                }
                
                self.topInfoView?.percentageLabel?.text = percent

                var listArr = dataDic.arrayObjectForKey("content")
                
                if listArr.count == 0
                {
                    self.showEmptyView("排行榜无内容")
                    //self.showEmptyViewFullOfView("排行榜无内容")
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
//        println("result ================= \(model?.result)")
        
        //cell?.headImgView?.image = Optional.None
        cell?.headImgView?.hidden = true
        cell?.nameLabel?.text = Optional.None
        cell?.companyNameLabel?.text = model?.name
        
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
