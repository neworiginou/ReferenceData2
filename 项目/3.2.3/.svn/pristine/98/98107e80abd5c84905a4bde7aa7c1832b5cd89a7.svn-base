//
//  HWGradeOfCompanyTableView.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/11.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：我的业绩排行榜机构页面
//
//  魏远林  2015-02-11    创建
//
//

import UIKit

class HWGradeOfCompanyTableView: HWBaseRefreshView
{
    var companyScoreLab:UILabel!
    var moneyLab:UILabel!
    var percentLab:UILabel!
    var rankTagLab:UILabel!
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initContentView()
        self.queryListData()
    }
    
    //MARK : 重写视图
    func initContentView()
    {
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.baseTable.backgroundColor = UIColor.clearColor()
        self.addSubview(self.baseTable)
        self.isNeedHeadRefresh = true
        self.currentPage = 1
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 140))
        headerView.backgroundColor = UIColor.clearColor()
        self.baseTable.tableHeaderView = headerView
        companyScoreLab = UILabel()
        companyScoreLab.font = Define.font(12)
        companyScoreLab.textColor = CD_Txt_Color_99
        companyScoreLab.textAlignment = NSTextAlignment.Center
        companyScoreLab.backgroundColor = UIColor.clearColor()
        companyScoreLab.sizeToFit()
        companyScoreLab.frame = CGRectMake(12, 25, companyScoreLab.frame.size.width, companyScoreLab.frame.size.height)
        headerView.addSubview(companyScoreLab)
        
        moneyLab = UILabel()
        moneyLab.textColor = CD_MainColor
        moneyLab.font = Define.font(28)
        moneyLab.backgroundColor = UIColor.clearColor()
        moneyLab.textAlignment = NSTextAlignment.Center
        headerView.addSubview(moneyLab)
        
        percentLab = UILabel(frame: CGRectMake(kScreenWidth - 110 , 5, 100, 100))
        percentLab.layer.cornerRadius = 50
        percentLab.clipsToBounds = true
        percentLab.numberOfLines = 0
        percentLab.backgroundColor = UIColor.whiteColor()
 
        percentLab.textAlignment = NSTextAlignment.Center
        percentLab.textColor = CD_Txt_Color_99
        percentLab.font = Define.font(20)
        headerView.addSubview(percentLab)
        
        var rankTagView = UIView(frame:  CGRectMake(0, 120, kScreenWidth, 30))
        rankTagView.backgroundColor = CD_WhiteColor
        headerView.addSubview(rankTagView)
        
        rankTagLab = UILabel(frame: CGRectMake(15, 0, kScreenWidth, 30))
        rankTagLab.font = Define.font(13)
        rankTagLab.textColor = CD_Txt_Color_99
        rankTagLab.backgroundColor = UIColor.whiteColor()
        rankTagView.addSubview(rankTagLab)
        rankTagView.drawTopLine()
        rankTagView.drawBottomLine()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWGradeOfCompanyTableViewCell.setCellHeight()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentify = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as? HWGradeOfCompanyTableViewCell
        if cell == Optional.None
        {
            cell = HWGradeOfCompanyTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentify)
        }
        cell?.setValueOfContentView(self.baseListArr.pObjectAtIndex(indexPath.row) as HWGradeOfCompanyModel)
        var rankNumber = indexPath.row + 1
        cell?.rankNumberLab?.text = "\(rankNumber)"
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
    //MARK: 请求数据
    override func queryListData()
    {
        let kGradeOfSingle = "/personalCenter/brokerRankingList.do"
        
        Utility.showMBProgress(self, _message: "数据请求中")
//        var param = ["key":"3223"]
        var param = NSMutableDictionary()
        param.setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGradeOfSingle, parameters: param, queue: nil, success: { (responseObject) -> Void in
        Utility.hideMBProgress(self)
        var responseObject = ["data":["month":"2", "orgName":"上海房地产机构", "myResult":"145555555", "percent":"88%", "pageInfo":["content":[["name":"大王叫我去巡山呐", "result":"7291"], ["name":"我想这个世界很复杂", "result":"4831"], ["name":"天涯海角若比零", "result":"3621"]]]]] as NSDictionary
        var dataDic = responseObject.dictionaryObjectForKey("data") as NSDictionary
//        println(responseObject)
        var currentMounth = dataDic.stringObjectForKey("month") as String
        var company = dataDic.stringObjectForKey("orgName") as String
        self.companyScoreLab.text = "\(company)\(currentMounth)月业绩"
        self.companyScoreLab.sizeToFit()
        self.companyScoreLab.frame = CGRectMake(12, 25, self.companyScoreLab.frame.size.width, self.companyScoreLab.frame.size.height)
        
        var moneyStr = dataDic.stringObjectForKey("myResult") as String
        var moneyAtt = NSMutableAttributedString(string: "￥\(moneyStr)")
        moneyAtt.addAttribute(NSFontAttributeName, value: Define.font(12), range: NSMakeRange(0, 1))
        self.moneyLab.attributedText = moneyAtt
        self.moneyLab.sizeToFit()
        self.moneyLab.frame = CGRectMake(15, CGRectGetMaxY(self.companyScoreLab.frame) + 16, self.moneyLab.frame.size.width, self.moneyLab.frame.size.height)
        
        var percent = dataDic.stringObjectForKey("percent") as String
        var customerTypeStr = "上海市经纪公司"
        //备注 \n为一个字符
        var percentStr = "超越\n\(percent)\n\(customerTypeStr)"
        self.percentLab.textAlignment = NSTextAlignment.Center
        self.percentLab.textColor = CD_Txt_Color_99
        self.percentLab.font = Define.font(20)
        var percentAtt = NSMutableAttributedString(string: percentStr)
        percentAtt.addAttribute(NSFontAttributeName, value: Define.font(12), range: NSMakeRange(0, 2))
        percentAtt.addAttribute(NSFontAttributeName, value: Define.font(20), range: NSMakeRange(2 + 1, countElements(percent)))
        percentAtt.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: NSMakeRange(2 + 1, countElements(percent)))
        percentAtt.addAttribute(NSFontAttributeName, value: Define.font(12), range: NSMakeRange(3 + countElements(percent) + 1, countElements(customerTypeStr)))
        self.percentLab.attributedText = percentAtt
        
        self.rankTagLab.text = "\(currentMounth)月个人排行  TOP 20"
        
        var pageInfo = dataDic.dictionaryObjectForKey("pageInfo") as NSDictionary
        var contentArr = pageInfo.arrayObjectForKey("content") as NSArray
//        println(contentArr)
        var detailDic:NSDictionary?
        for detailDic in contentArr
        {
            var companyModel = HWGradeOfCompanyModel(dic: detailDic as NSDictionary)
            self.baseListArr.addObject(companyModel)
        }
//        println(self.baseListArr)
        self.baseTable.reloadData()
                }) { (failure, error) -> Void in
                    Utility.hideMBProgress(self)
                    Utility.showToastWithMessage(error, _view: self)
                }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        
    }
    
}
