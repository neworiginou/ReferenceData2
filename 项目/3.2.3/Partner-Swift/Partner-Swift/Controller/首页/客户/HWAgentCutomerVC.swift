//
//  HWAgentCutomerVC.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.

import UIKit
import MessageUI
class HWAgentCutomerVC: HWBaseViewController,MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HWCustomSiftViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,HWCustomAlertViewDelegate
{
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    var houseData1:HWClientModel! = HWClientModel();
    var _customerTable:UITableView = UITableView();
    var headerView:UIView = UIView();
    var buyHouseView:UIView = UIView();
    var houseInfoArry:NSMutableArray = NSMutableArray();
    var houseDateArry:NSMutableArray = NSMutableArray();
    var clientInfoId = NSString()
    var clientIntention:NSString = NSString()
    var agentModel = HWAgentCustomerDetailModel()
    var selectIndex = Int()
    var selectLook = Int()
    var moneyText = NSString()
     var imgArr:NSArray = NSArray()
     var lineImageV:UIImageView = UIImageView()
    //testData
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
     override func backMethod() {
        if (self.myFunc != nil)
        {
            self.myFunc!()
        }
        
        
        self.navigationController?.popViewControllerAnimated(true);
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("客户详情")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "toShowMore:", _image: UIImage(named: "more_icon")!);
        self.view.backgroundColor = UIColor.whiteColor()
        self.customerDetailrequest()
        _customerTable = UITableView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), style: UITableViewStyle.Grouped);
        _customerTable.delegate = self;
        _customerTable.dataSource = self;
        _customerTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        _customerTable.backgroundView = nil;
        _customerTable.backgroundColor = UIColor.clearColor();
        self.view.addSubview(_customerTable);
    }
    func customerDetailrequest()
    {
        Utility .showMBProgress(shareAppDelegate.window!, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(clientInfoId, forKey: "clientInfoId")
        manager .postHttpRequest(kClientDetailList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(shareAppDelegate.window!)
            Utility .showToastWithMessage("请求成功", _view: self.view)
            let resultDic: NSDictionary = (responseObject.dictionaryObjectForKey("data") as NSDictionary)
//           println(resultDic)
            
            self.agentModel = HWAgentCustomerDetailModel(dic: resultDic)
            var dic1 = NSDictionary()
            for var i = 0; i < self.agentModel.houseList?.count;i++
            {
                dic1 = self.agentModel.houseList?.objectAtIndex(i) as NSDictionary
                let infoModel = HWHouseInfoModel(dic: dic1 as NSDictionary)
                self.agentModel.houseTypeList.addObject(infoModel)
            }
            self.clientIntention = self.agentModel.hasIntention!
            self._customerTable.tableHeaderView = self.createHeaderView();
            self._customerTable .reloadData();
            }) { (code, error) -> Void in
                Utility .hideMBProgress(shareAppDelegate.window!)
                Utility .showToastWithMessage(error, _view: self.view)
                self._customerTable.tableHeaderView = self.createHeaderView();
                
        }
        
    }

    func toShowMore(sender: UIButton) -> Void
    {
        var titleArr = NSArray()
        if self.clientIntention == "0"
        {
            titleArr = ["新建日程","转有意向","成交确认"]
        }
        if self.clientIntention == "1"
        {
            titleArr = ["新建日程","转无意向","成交确认"]
            
        }
        else
        {
            titleArr = ["新建日程","转无意向","成交确认"]
        }

        let imageArr = NSArray(objects: "editor_icon3","editor_icon4","editor_icon7")
        let selectView = HWCustomSiftView(title: titleArr, image:imageArr, andDependView: self.navigationItem.rightBarButtonItem?.customView)
        selectView.delegate = self
        selectView.showInView(shareAppDelegate.window)
    }
    //MARK:-HWCustomSiftViewDelegate代理方法
    func siftView(siftView: HWCustomSiftView!, didSelectedIndex index: Int)
    {
        if(index == 0)
        {
            MobClick .event("Clientschedule_click")
            let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
            newScheduleVC.sourceType = NewScheduleSourceType.New
            var relatedClient: HWClientModel = HWClientModel()
            relatedClient.clientInfoId = self.agentModel.clientInfoId!
            relatedClient.clientName = self.agentModel.clientName!
            relatedClient.clientPhone = self.agentModel.clientPhone!
            newScheduleVC.relatedClient = relatedClient

            self.navigationController?.pushViewController(newScheduleVC, animated: true)
        }
        else if(index == 1)
        {
            Utility .showMBProgress(self.view, _message: "修改中")
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary! = NSMutableDictionary()
            param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param .setObject(self.agentModel.clientInfoId!, forKey: "clientInfoId")
            if self.clientIntention == "0"
            {
                param .setObject( "1", forKey: "hasIntention")
                
                
            }
            
            if  self.clientIntention == "1"
            {
                param .setObject( "0", forKey: "hasIntention")
                
                
            }
            
            self._customerTable .reloadData()
            manager .postHttpRequest(kClientSetIntention, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage("修改成功", _view:self.view)
                
                if self.clientIntention == "0"
                {
                    
                    self.clientIntention = "1"
                    
                    
                }
                    
                else  if  self.clientIntention == "1"
                {
                    
                    self.clientIntention = "0"
                    
                    
                }

                
                }) { (code, error) -> Void in
                    Utility .hideMBProgress(self.view)
                    Utility .showToastWithMessage(error, _view: self.view)
            }
            
            
        }
        
        else if(index == 2)
        {
            self.getmoneyContent()
        }

    }
       
    //MARK:获取成交确认金额
    func getmoneyContent()
    {
        Utility .showMBProgress(self.view, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param .setObject(self.agentModel.clientInfoId!, forKey: "clientInfoId")
        manager .postHttpRequest(kqueryClientDealAmount, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("请求成功", _view: self.view)
            self.moneyText = responseObject.stringObjectForKey("data")
            
            
            var alert:HWCustomAlertView = HWCustomAlertView(type: AlertViewType.DealConfirm,str:self.moneyText);
            
            shareAppDelegate.window?.addSubview(alert)
            alert.delegate = self;
            alert.showAnimate();
            
            }) { ( code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
                
                var alert:HWCustomAlertView = HWCustomAlertView(type: AlertViewType.DealConfirm);
                alert.moneyText = self.moneyText
                shareAppDelegate.window?.addSubview(alert)
                alert.delegate = self;
                alert.showAnimate();
        }
        
    }
    //MARK:alert代理
    func ConfirmInPut(content:NSString) -> Void
    {
        Utility .showMBProgress(self.view, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param .setObject(self.agentModel.clientInfoId!, forKey: "clientInfoId")
        param .setObject(content, forKey: "clientDealAmount")
        
        manager .postHttpRequest(kClientDealAmount, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("请求成功", _view: self.view)
            
            
            }) { ( code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
        }
        
        
        
    }

    //MARK:-UITableViewDelegate方法
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
    
        let houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(section)as HWHouseInfoModel;
        if houseModel.houseType == "newHouse" || houseModel.houseType == "new"
        {
            if  houseModel.seletedStr == "0"
            {
                if houseModel.currNode?.integerValue > 2
                {
                    return 190-45;
                }
                    
                else
                {
                    return 190;
                }
                
            }
                
            else if houseModel.currNode?.integerValue > 2 || houseModel.showLook == "0"

            {
                return 235-45;
                
            }
                
            else
                
            {
                return 235;
            }
            
        }
        else if(houseModel.houseType == "secondHouse" || houseModel.houseType == "secondhand")
        {
            if(houseModel.appointStatus != "2" || houseModel.appointStatus != "1")
            {
                if(houseModel.seletedStr == "0")
                {
                    return 190-45;
                }
                else
                {
                    return 235-60;
                }
                
            }
            else
            {
                if(houseModel.seletedStr == "0")
                {
                    return 190-45;
                }
                else
                {
                    return 235-60;
                }
                
            }
            
        }
        return 0.0;

    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 32.0;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(indexPath.section)as HWHouseInfoModel;
        let listModel = houseModel.followRecordArry .objectAtIndex(indexPath.row) as HWHouseListModel
        var size = Utility.calculateStringSize(listModel.content!, textFont:Define.font(13), constrainedSize: CGSizeMake(kScreenWidth-30, 1000))
        return size.height + 30;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(section)as HWHouseInfoModel;
        if(houseModel.seletedStr == "0")
        {
            return 0;
        }
        else
        {
            return houseModel.followRecordArry.count
        }
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(section)as HWHouseInfoModel;
        var footView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 32));
        footView.backgroundColor = CD_WhiteColor;
        var line = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 0.5))
        line.backgroundColor = CD_LineColor
        footView .addSubview(line)
        var line1 = UIImageView(frame: CGRectMake(0, 31.5, kScreenWidth, 0.5))
        line1.backgroundColor = CD_LineColor
       
        if section == self.agentModel.houseTypeList.count - 1
        {
             footView .addSubview(line1)
        }

        var recordBtnFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 32);
        var recordBtn:UIButton = createCustomeBtn(self ,"scheduleClick:", recordBtnFrame,CD_Txt_Color_33, "", "");
        recordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        recordBtn.setTitle("日程计划", forState: UIControlState.Normal);
        recordBtn.setTitleColor(CD_Txt_Color_66, forState: UIControlState.Normal);
        recordBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_13);
        recordBtn.tag = Int(section);
        
        var arrowImageVFrame:CGRect = CGRectMake(kScreenWidth/2+25, 10, 15, 8);
        var arrowImageV:UIImageView = createCustomerImageView(arrowImageVFrame, "arrow_up");
        footView.addSubview(recordBtn);
        footView.addSubview(arrowImageV);
        
        if(houseModel.seletedStr == "0")
        {
            arrowImageV.image = UIImage(named: "arrow_down");
        }
        else
        {
            arrowImageV.image = UIImage(named: "arrow_up");
        }
        
        return footView;
    }
    //MARK:-点击展开日程
    func scheduleClick(sender:UIButton)->Void
    {
        
        var houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(sender.tag)as HWHouseInfoModel;
        houseModel.followRecordArry.removeAllObjects()
        if(houseModel.seletedStr == "0")
        {
            Utility.showMBProgress(self.view, _message: "加载中");
            var param:NSMutableDictionary = NSMutableDictionary();
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
            param.setPObject(self.agentModel.clientInfoId, forKey: "clientInfoId")
            param.setPObject(houseModel.houseId, forKey: "houseId")
            if houseModel.houseType == "new" || houseModel.houseType == "newHouse"
            {
                param.setPObject("new", forKey: "houseType")
            }
            if houseModel.houseType == "secondhand" || houseModel.houseType == "secondHouse"
            {
                param.setPObject("secondhand", forKey: "houseType")
            }
            
            let manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kScheduleManger, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self.view);
                var resultDic = responseObject .dictionaryObjectForKey("data") as NSDictionary
                var arry = resultDic .arrayObjectForKey("psList")
                var dic = NSDictionary()
                for var i = 0;i < arry.count;i++
                {
                    dic = arry.objectAtIndex(i) as NSDictionary
                    var model = HWHouseListModel(dic: dic)
                    houseModel.followRecordArry .addObject(model)
                    self._customerTable .reloadData();
                }
                
                }) { (code, error) -> Void in
                    Utility.hideMBProgress(self.view)
            }
            
            houseModel.seletedStr = "1";
        }
        else
        {
            
            
            houseModel.seletedStr = "0";
        }
        _customerTable .reloadData();
        
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
       // lineImageV.hidden = true
        var houseViewTableHeader:UIView = createView(CGRectMake(0, 0, kScreenWidth, 215));
        houseViewTableHeader.backgroundColor = UIColor.whiteColor();
        var houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(section)as HWHouseInfoModel;
        if(houseModel.houseType == "newHouse" || houseModel.houseType == "new")
        {
            if(houseModel.seletedStr == "0")
            {
                houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 190);
            }
            else
            {
                houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 235);
            }
            var houseBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom)as UIButton;
            houseBtn.tag = section;
            houseBtn.addTarget(self, action: "gotoNewHouseDetail:", forControlEvents: UIControlEvents.TouchUpInside);
            houseBtn.backgroundColor = CD_GrayColor;
            houseBtn.frame = CGRectMake(0, 10, kScreenWidth, 40);
            houseViewTableHeader.addSubview(houseBtn);
            
            
            var arrowImageV:UIImageView = createCustomerImageView(CGRectMake(kScreenWidth-15-8,(40-14)/2+10, 8, 14), "arrow_next");
            houseViewTableHeader.addSubview(arrowImageV);
            
            
            var grayView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 10));
            grayView.backgroundColor = CD_BackGroundColor;
            houseViewTableHeader.addSubview(grayView);
            
            var lineOneImageV:UIImageView = Utility.drawLine(CGPointMake(0, 0), width: kScreenWidth);
            //houseViewTableHeader.addSubview(lineOneImageV);
            
            var lineTwoImageV:UIImageView = Utility.drawLine(CGPointMake(0, 9.5), width: kScreenWidth);
            houseViewTableHeader.addSubview(lineTwoImageV);
            
            //楼盘名称
            var houseTitleFrame:CGRect = CGRectMake(15, 12+10, 70, 15);
            var houseTitleLabel:UILabel = createCustomeLabel(houseTitleFrame, CD_Txt_Color_33, houseModel.houseName, TF_13);
            houseTitleLabel.sizeToFit();
            houseViewTableHeader.addSubview(houseTitleLabel);
            
            //区域
            var areaFrame:CGRect = CGRectMake(CGRectGetMaxX(houseTitleLabel.frame)+5, 12+10, 70, 15);
            var areaLabel:UILabel = createCustomeLabel(areaFrame, CD_Txt_Color_33, houseModel.houseAddress, TF_13);
            areaLabel.sizeToFit();
            houseViewTableHeader.addSubview(areaLabel);
            
            //新房标示按钮
            var secondHouseFrame:CGRect = CGRectMake(CGRectGetMaxX(areaLabel.frame), 10+13, 30, 15);
            var secondHouseBtn:UIButton = createCustomeBtn(self, nil, secondHouseFrame, UIColor.whiteColor(), "二手", "");
            secondHouseBtn.titleEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
            secondHouseBtn.layer.cornerRadius = 2.0;
            secondHouseBtn.layer.masksToBounds = true;
            secondHouseBtn.backgroundColor = CD_OrangeColor;
            secondHouseBtn.setTitle("", forState: UIControlState.Normal);
            secondHouseBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
            secondHouseBtn.titleLabel?.font = UIFont.systemFontOfSize(TF_11);
            // houseViewTableHeader.addSubview(secondHouseBtn);
            
            //创建进度View
            var statusStr : NSString = NSString()
            if houseModel.currNode == "0"
            {
                statusStr = "1"
            }
            if houseModel.currNode == "1"
            {
                statusStr = "2"
            }
            
            if houseModel.currNode == "2"
            {
                statusStr = "3"
            }
            
            if houseModel.currNode == "3"
            {
                statusStr = "4"
            }
            
            if houseModel.currNode == "4"
            {
                statusStr = "5"
            }
            
            self.createScheduleView(houseViewTableHeader, secondHouseBtn: secondHouseBtn, status:statusStr, customeModel:houseData1);
            var dateConfirmFrame:CGRect = CGRectMake(15, CGRectGetMaxY(secondHouseBtn.frame)+80, 150, 15);
            var str = Utility .getTimeWithTimestamp(houseModel.lastStateChangeTime!, dateFormatStr: "YYYY-MM-dd HH:mm:ss")
            var dateConfirmLabel:UILabel = createCustomeLabel(dateConfirmFrame, CD_Txt_Color_99,str, TF_13);
            var factualRect = returnLabelFactualSize(dateConfirmLabel, TF_13);
            dateConfirmLabel.frame = factualRect;
            houseViewTableHeader.addSubview(dateConfirmLabel);
            
            var statusFrame:CGRect = CGRectMake(CGRectGetMaxX(dateConfirmLabel.frame)+5, CGRectGetMaxY(secondHouseBtn.frame)+80, 90, 15);
            var statusLabel:UILabel = createCustomeLabel(statusFrame, CD_Txt_Color_66, houseModel.houseState, TF_13);
            
            houseViewTableHeader.addSubview(statusLabel);
            
            var statusFactualRect:CGRect = returnLabelFactualSize(statusLabel, TF_13);
            statusLabel.frame = statusFactualRect;
            
            var protectLabelFrame:CGRect = CGRectMake(kScreenWidth-100-15, CGRectGetMaxY(secondHouseBtn.frame)+80, 100, 15);
            var protectLabel:UILabel = createCustomeLabel(protectLabelFrame, CD_RedDeepColor, "", TF_13);
            if houseModel.visitedProtectDays == "-1"
            {
                protectLabel.hidden = true
            }
            if houseModel.visitedProtectDays == "0"
            {
                protectLabel.text = "已过到访保护期"
            }
            if houseModel.visitedProtectDays.integerValue > 0
            {
                protectLabel.text = "到访保护期剩余\(houseModel.visitedProtectDays)天"
            }
            if houseModel.houseState == "fail"
            {
                protectLabel.text = "到访保护期已过"
                statusLabel.hidden == true
                
            }

            protectLabel.textAlignment = NSTextAlignment (rawValue: 2)!
            houseViewTableHeader.addSubview(protectLabel);
            
            var lookBtn:UIButton! = nil;
            var lookBtnFrame:CGRect = CGRectMake(15, CGRectGetMaxY(statusLabel.frame)+15, kScreenWidth-2*15,35);
            lookBtn = createCustomeBtn(self, "lookBtn:", lookBtnFrame, CD_MainColor, "跟进", "");
            lookBtn.setTitle("带看", forState: UIControlState.Normal);
            lookBtn.tag = section + 100
            lookBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
            lookBtn.layer.cornerRadius = 3.0;
            lookBtn.layer.masksToBounds = true;
            lookBtn.layer.borderWidth = 1.0;
            lookBtn.layer.borderColor = CD_MainColor.CGColor;
            lookBtn.setTitleColor(CD_MainColor, forState: UIControlState.Normal);
            houseViewTableHeader.addSubview(lookBtn);
            if statusStr.integerValue > 2 ||  houseModel.showLook == "0" 
            {
                lookBtn.hidden = true
                
            }

//            if statusStr.integerValue > 3
//            {
//                lookBtn.hidden = true
//            }
//                
//            else
//            {
//                lookBtn.hidden = false
//                
//            }
//
//            if houseModel.showLook == "1"
//            {
//                lookBtn.hidden = false
//            }
//            else
//            {
//                lookBtn.hidden = true
//            }
//            if protectLabel.text == "到访保护期已过"
//            {
//                lookBtn.hidden = true
//            }
//            else
//            {
//                lookBtn.hidden = false
//                
//            }

            // var houseModelTemp:HWClientModel = houseDateArry.objectAtIndex(section)as HWClientModel;
            if(houseModel.seletedStr == "0")
            {
                
            }
            else
            {
                var newScheduleBtn:UIButton! = nil;
                var newScheduleBtnFrame:CGRect = CGRectMake(15, houseViewTableHeader.frame.size.height-37, kScreenWidth-2*15,35);
                newScheduleBtn = createCustomeBtn(self, "createSchedule:", newScheduleBtnFrame, CD_GreenColor, "跟进", "");
                newScheduleBtn.tag = section+200
                newScheduleBtn.setTitle("新建日程", forState: UIControlState.Normal);
                newScheduleBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
                newScheduleBtn.layer.cornerRadius = 3.0;
                newScheduleBtn.layer.masksToBounds = true;
                newScheduleBtn.layer.borderWidth = 1.0;
                newScheduleBtn.layer.borderColor = CD_GreenColor.CGColor;
                newScheduleBtn.setTitleColor(CD_GreenColor, forState: UIControlState.Normal);
                houseViewTableHeader.addSubview(newScheduleBtn);
            }
        }
        else if(houseModel.houseType == "secondHouse" || houseModel.houseType == "secondhand")
        {
            if(houseModel.seletedStr == "0")
            {
                houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 190-45);
            }
            else
            {
                houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 235-60);
            }
            var houseBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom)as UIButton;
            houseBtn.tag = section;
            houseBtn.addTarget(self, action: "gotoSecHouseDetail:", forControlEvents: UIControlEvents.TouchUpInside);
            houseBtn.backgroundColor = CD_GrayColor;
            houseBtn.frame = CGRectMake(0, 10, kScreenWidth, 63);
            houseViewTableHeader.addSubview(houseBtn);
            
            
            var arrowImageV:UIImageView = createCustomerImageView(CGRectMake(kScreenWidth-15-8,(63-14)/2+10, 8, 14), "arrow_next");
            houseViewTableHeader.addSubview(arrowImageV);
            
            
            var grayView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 10));
            grayView.backgroundColor = CD_BackGroundColor;
            houseViewTableHeader.addSubview(grayView);
            
            var lineOneImageV:UIImageView = Utility.drawLine(CGPointMake(0, 0), width: kScreenWidth);
            houseViewTableHeader.addSubview(lineOneImageV);
            
            var lineTwoImageV:UIImageView = Utility.drawLine(CGPointMake(0, 9.5), width: kScreenWidth);
            houseViewTableHeader.addSubview(lineTwoImageV);
            
            //楼盘名称
            var houseTitleFrame:CGRect = CGRectMake(15, 12+10, 70, 15);
            var houseTitleLabel:UILabel = createCustomeLabel(houseTitleFrame, CD_Txt_Color_33, houseModel.houseName, TF_13);
            houseTitleLabel.sizeToFit();
            houseViewTableHeader.addSubview(houseTitleLabel);
            
            //区域
            var areaFrame:CGRect = CGRectMake(CGRectGetMaxX(houseTitleLabel.frame)+5, 12+10, 70, 15);
            var areaLabel:UILabel = createCustomeLabel(areaFrame, CD_Txt_Color_33, houseModel.houseAddress, TF_13);
            areaLabel.sizeToFit();
            houseViewTableHeader.addSubview(areaLabel);
            
            //二手房标示按钮
            var secondHouseFrame:CGRect = CGRectMake(CGRectGetMaxX(areaLabel.frame), 10+13, 30, 15);
            var secondHouseBtn:UIButton = createCustomeBtn(self, nil, secondHouseFrame, UIColor.whiteColor(), "二手", "");
            secondHouseBtn.titleEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
            secondHouseBtn.layer.cornerRadius = 2.0;
            secondHouseBtn.layer.masksToBounds = true;
            secondHouseBtn.backgroundColor = CD_OrangeColor;
            secondHouseBtn.setTitle("", forState: UIControlState.Normal);
            secondHouseBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
            secondHouseBtn.titleLabel?.font = UIFont.systemFontOfSize(TF_11);
            // houseViewTableHeader.addSubview(secondHouseBtn);
            
            var purposeLabelFrame:CGRect = CGRectMake(15, CGRectGetMaxY(houseTitleLabel.frame)+10, kScreenWidth-2*15, 15);
            var purposeLabel:UILabel = createCustomeLabel(purposeLabelFrame, CD_Txt_Color_99, "", TF_13);
            houseViewTableHeader.addSubview(purposeLabel);
            var purposeStr:NSString = NSMutableString();
            let priceStr = Utility .stringFrom(houseModel.houseTotalPrice)
            purposeStr = houseModel.houseFamilyType!+" \(houseModel.houseArea.integerValue)"+"㎡"+" \(priceStr)";
            purposeLabel.text = purposeStr;
            
            //未预约后的视图
            if(houseModel.appointStatus == "2" || houseModel.appointStatus == "1")
            {
                //未预约的视图
                if(houseModel.appointStatus == "2")
                {
                    var nameLabelFrame:CGRect = CGRectMake(15, CGRectGetMaxY(houseBtn.frame)+24, 200, 20);
                    var nameLabel:UILabel = createCustomeLabel(nameLabelFrame, CD_Txt_Color_66, houseModel.brokerName, TF_13);
                    nameLabel.textAlignment = NSTextAlignment.Left;
                    var nameFactualRect:CGRect = returnLabelFactualSize(nameLabel, TF_13);
                    nameLabel.frame = nameFactualRect;
                    houseViewTableHeader.addSubview(nameLabel);
                    
                    var phoneNumLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(nameLabel.frame)+10,nameLabel.frame.origin.y,100, 20);
                    var phoneNumLabel:UILabel = createCustomeLabel(phoneNumLabelFrame, CD_Txt_Color_66, houseModel.brokerPhone, TF_13);
                    phoneNumLabel.textAlignment = NSTextAlignment.Left;
                    var phoneFactualRect:CGRect = returnLabelFactualSize(phoneNumLabel, TF_13);
                    phoneNumLabel.frame = phoneFactualRect;
                    houseViewTableHeader.addSubview(phoneNumLabel);
                    
                    var partnerBtnFrame:CGRect = CGRectMake(kScreenWidth-15-30,nameLabel.frame.origin.y-5, 30, 30);
                    var partnerBtn:UIButton = UIButton(frame: partnerBtnFrame)
                    partnerBtn.tag = section+300
                    partnerBtn .addTarget(self, action: "callPhones:", forControlEvents:UIControlEvents.TouchUpInside)
                    partnerBtn.setImage(UIImage(named:"phone2"), forState:UIControlState.Normal);
                    houseViewTableHeader.addSubview(partnerBtn);
                    
                    
                    
//                    var lookBtn:UIButton! = nil;
//                    var lookBtnFrame:CGRect = CGRectMake(15, CGRectGetMaxY(nameLabel.frame)+10, kScreenWidth-2*15,35);
//                    lookBtn = createCustomeBtn(self, "confirmBtnClick:", lookBtnFrame, CD_RedLightColor, "跟进", "");
//                    lookBtn.setTitle("成交确认", forState: UIControlState.Normal);
//                    lookBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
//                    lookBtn.layer.cornerRadius = 2.0;
//                    lookBtn.layer.masksToBounds = true;
//                    lookBtn.tag = section
//                    lookBtn.layer.borderWidth = 1.0;
//                    lookBtn.layer.borderColor = CD_GreenColor.CGColor;
//                    lookBtn.setTitleColor(CD_GreenColor, forState: UIControlState.Normal);
//                   // houseViewTableHeader.addSubview(lookBtn);
//                    var lab:UILabel! = nil
//                    lab =  createCustomeLabel(lookBtnFrame, CD_MainColor, "已成交 2000万元", TF_13)
//                    houseViewTableHeader.addSubview(lab);
//

                }
                
            }
            else
            {
                var lookBtn:UIButton! = nil;
                var lookBtnFrame:CGRect = CGRectMake(15, CGRectGetMaxY(houseBtn.frame)+17, kScreenWidth-2*15,35);
                lookBtn = createCustomeBtn(self, "gotoSecHouseDetail:", lookBtnFrame, CD_RedLightColor, "跟进", "");
                lookBtn.setTitle("房源预约", forState: UIControlState.Normal);
                lookBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
                lookBtn.layer.cornerRadius = 2.0;
                lookBtn.layer.masksToBounds = true;
                lookBtn.tag = section
                lookBtn.layer.borderWidth = 1.0;
                lookBtn.layer.borderColor = CD_MainColor.CGColor;
                lookBtn.setTitleColor(CD_MainColor, forState: UIControlState.Normal);
                houseViewTableHeader.addSubview(lookBtn);
//                //成交确认按钮
//                var confirmBtn:UIButton! = nil;
//                var confirmBtnFrame:CGRect = CGRectMake(15, CGRectGetMaxY(lookBtn.frame)+17, kScreenWidth-2*15,35);
//                confirmBtn = createCustomeBtn(self, "confirmBtnClick:", confirmBtnFrame, CD_RedLightColor, "跟进", "");
//                confirmBtn.setTitle("成交确认", forState: UIControlState.Normal);
//                confirmBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
//                confirmBtn.layer.cornerRadius = 2.0;
//                confirmBtn.layer.masksToBounds = true;
//                confirmBtn.tag = section
//                confirmBtn.layer.borderWidth = 1.0;
//                confirmBtn.layer.borderColor = CD_GreenColor.CGColor;
//                confirmBtn.setTitleColor(CD_GreenColor, forState: UIControlState.Normal);
//               houseViewTableHeader.addSubview(confirmBtn);
//                
                if HWUserLogin .currentUserLogin().brokerId == houseModel.brokerId
                {
                    lookBtn.hidden = true
                }
                else
                {
                    lookBtn.hidden = false
                }

              
            }
            // var houseModelTemp:HWClientModel = houseDateArry.objectAtIndex(section)as HWClientModel;
            if(houseModel.seletedStr == "0")
            {
                
            }
            else
            {
                var newScheduleBtn:UIButton! = nil;
                var newScheduleBtnFrame:CGRect = CGRectMake(15, CGRectGetMaxY(houseBtn.frame)+65, kScreenWidth-2*15,35);
                newScheduleBtn = createCustomeBtn(self, "createSchedule:", newScheduleBtnFrame, CD_GreenColor, "跟进", "");
                newScheduleBtn.tag = section+200
                newScheduleBtn.setTitle("新建日程", forState: UIControlState.Normal);
                newScheduleBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
                newScheduleBtn.layer.cornerRadius = 2.0;
                newScheduleBtn.layer.masksToBounds = true;
                newScheduleBtn.layer.borderWidth = 1.0;
                newScheduleBtn.layer.borderColor = CD_GreenColor.CGColor;
                newScheduleBtn.setTitleColor(CD_GreenColor, forState: UIControlState.Normal);
                houseViewTableHeader.addSubview(newScheduleBtn);
            }
            
            
        }
        return houseViewTableHeader;
    }
     //成交确认
    func confirmBtnClick(sender:UIButton!)
    {
        
    }
    //查看二手房详情
    func gotoSecHouseDetail(sender:UIButton!)
    {
        var infoModle = self.agentModel.houseTypeList.objectAtIndex(sender.tag) as HWHouseInfoModel
        var detailVC = HWScdHouseDetailVC()
        detailVC._houseId = infoModle.houseId
        self.navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    func gotoNewHouseDetail(sender:UIButton)
    {
        var infoModle = self.agentModel.houseTypeList.objectAtIndex(sender.tag) as HWHouseInfoModel
        var detailVC = HWNewDetailVC()
        detailVC.houseId = infoModle.houseId
        self.navigationController?.pushViewController(detailVC, animated: true)

    }

    //MARK:打电话
    func callPhones(sender:UIButton!)
    {
        var action = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拨打")
        selectIndex = sender.tag - 300
        action.tag = 2003
        action .showInView(self.view)
    }

    func createScheduleView(houseTempView:UIView,secondHouseBtn:UIButton,status:String,customeModel:HWClientModel)
    {
        for(var j:CGFloat = 0;j<5;j++)
        {
            var scheduleFrame:CGRect = CGRectMake(15+j*(20+(kScreenWidth-130)/4.0), CGRectGetMaxY(secondHouseBtn.frame)+30, 20, 20);
            var scheduleLabel:UILabel = createCustomeLabel(scheduleFrame,CD_GreenColor, "内容", TF_13);
            scheduleLabel.tag = Int(800+j);
            scheduleLabel.layer.cornerRadius = 10.0;
            scheduleLabel.textAlignment = NSTextAlignment.Center;
            scheduleLabel.layer.borderWidth = 1.0;
            scheduleLabel.layer.masksToBounds = true;
            scheduleLabel.layer.borderColor = CD_BackGroundColor.CGColor;
            
            
            var scheduleContentFrame:CGRect = CGRectMake(15+j*(20+(kScreenWidth-130)/4.0), CGRectGetMaxY(scheduleLabel.frame)+5, 40, 20);
            var scheduleContentLabel:UILabel = createCustomeLabel(scheduleContentFrame, CD_Txt_Color_33, "", TF_13);
            scheduleContentLabel.textAlignment = NSTextAlignment.Center;
            scheduleContentLabel.center = CGPointMake(scheduleLabel.center.x, scheduleLabel.center.y+20);
            scheduleContentLabel.tag = Int(900+j);
            if(j<=3)
            {
                var lineOneFrame:CGRect = CGRectMake(CGRectGetMaxX(scheduleLabel.frame), scheduleLabel.center.y-1, (kScreenWidth-130)/4, 2);
                var lineOnV:UIImageView = createCustomerImageView(lineOneFrame, "");
                lineOnV.backgroundColor = CD_LineColor;
                houseTempView.addSubview(lineOnV);
            }
            houseTempView.addSubview(scheduleLabel);
            houseTempView.addSubview(scheduleContentLabel);
            switch(j)
            {
            case 0:
                scheduleLabel.text = "1";
                scheduleContentLabel.text = "报备";
                if(scheduleLabel.text == status)
                {
                    scheduleLabel.backgroundColor = CD_MainColor;
                    scheduleLabel.textColor = UIColor.whiteColor();
                    scheduleContentLabel.textColor = CD_MainColor;
                    scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
                }
                else
                {
                    scheduleLabel.backgroundColor = UIColor.whiteColor();
                    scheduleLabel.textColor = UIColor .blackColor();
                }
                break;
            case 1:
                scheduleLabel.text = "2";
                scheduleContentLabel.text = "到访";
                if(scheduleLabel.text == status)
                {
                    scheduleLabel.backgroundColor = CD_MainColor;
                    scheduleLabel.textColor = UIColor.whiteColor();
                    scheduleContentLabel.textColor = CD_MainColor;
                    scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
                }
                else
                {
                    scheduleLabel.backgroundColor = UIColor.whiteColor();
                    scheduleLabel.textColor = UIColor.blackColor();
                }
                
                break;
            case 2:
                scheduleLabel.text = "3";
                scheduleContentLabel.text = "下定";
                if(scheduleLabel.text == status)
                {
                    scheduleLabel.backgroundColor = CD_MainColor;
                    scheduleLabel.textColor = UIColor.whiteColor();
                    scheduleContentLabel.textColor = CD_MainColor;
                    scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
                }
                else
                {
                    scheduleLabel.backgroundColor = UIColor.whiteColor();
                    scheduleLabel.textColor = UIColor .blackColor();
                }
                
                break;
            case 3:
                scheduleLabel.text = "4";
                scheduleContentLabel.text = "成交";
                if(scheduleLabel.text == status)
                {
                    scheduleLabel.backgroundColor = CD_MainColor;
                    scheduleLabel.textColor = UIColor.whiteColor()
                    scheduleContentLabel.textColor = CD_MainColor;
                    scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
                }
                else
                {
                    scheduleLabel.backgroundColor = UIColor.whiteColor();
                    scheduleLabel.textColor = UIColor.blackColor();
                }
                
                break;
            case 4:
                scheduleLabel.text = "5";
                scheduleContentLabel.text = "结佣";
                if(scheduleLabel.text == status)
                {
                    scheduleLabel.backgroundColor = CD_MainColor;
                    scheduleLabel.textColor = UIColor.whiteColor();
                    scheduleContentLabel.textColor = CD_MainColor;
                    scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
                }
                else
                {
                    scheduleLabel.backgroundColor = UIColor.whiteColor();
                    scheduleLabel.textColor = UIColor.blackColor();
                }
                
                break;
            default:break;
            }
            
        }
        if(status == "2")
        {
            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
            flightLabel.backgroundColor = CD_MainColor;
            flightLabel.textColor = UIColor.whiteColor();
            flightLabel.layer.borderColor = CD_MainColor.CGColor;
        }
        else if(status == "3")
        {
            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
            flightLabel.backgroundColor = CD_MainColor;
            flightLabel.textColor = UIColor.whiteColor();
            flightLabel.layer.borderColor = CD_MainColor.CGColor;
            
            var lookLabel:UILabel = houseTempView.viewWithTag(Int(801))as UILabel;
            lookLabel.backgroundColor = CD_MainColor;
            lookLabel.textColor = UIColor.whiteColor();
            lookLabel.layer.borderColor = CD_MainColor.CGColor;
        }
        else if(status == "4")
        {
            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
            flightLabel.backgroundColor = CD_MainColor;
            flightLabel.textColor = UIColor.whiteColor();
            flightLabel.layer.borderColor = CD_MainColor.CGColor;
            
            var lookLabel:UILabel = houseTempView.viewWithTag(Int(801))as UILabel;
            lookLabel.backgroundColor = CD_MainColor;
            lookLabel.textColor = UIColor.whiteColor();
            lookLabel.layer.borderColor = CD_MainColor.CGColor;
            
            var orderLabel:UILabel = houseTempView.viewWithTag(Int(802))as UILabel;
            orderLabel.backgroundColor = CD_MainColor;
            orderLabel.textColor = UIColor.whiteColor();
            orderLabel.layer.borderColor = CD_MainColor.CGColor;
        }
        else if(status == "5")
        {
            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
            flightLabel.backgroundColor = CD_MainColor;
            flightLabel.textColor = UIColor.whiteColor();
            flightLabel.layer.borderColor = CD_MainColor.CGColor;
            
            var lookLabel:UILabel = houseTempView.viewWithTag(Int(801))as UILabel;
            lookLabel.backgroundColor = CD_MainColor;
            lookLabel.textColor = UIColor.whiteColor();
            lookLabel.layer.borderColor = CD_MainColor.CGColor;
            
            var orderLabel:UILabel = houseTempView.viewWithTag(Int(802))as UILabel;
            orderLabel.backgroundColor = CD_MainColor;
            orderLabel.textColor = UIColor.whiteColor();
            orderLabel.layer.borderColor = CD_MainColor.CGColor;
            
            var tradeLabel:UILabel = houseTempView.viewWithTag(Int(803))as UILabel;
            tradeLabel.backgroundColor = CD_MainColor;
            tradeLabel.textColor = UIColor.whiteColor();
            tradeLabel.layer.borderColor = CD_MainColor.CGColor;
        }

    }
    
    
    
    
    func createHeaderView()->UIView
    {
        headerView.removeFromSuperview();
        var headerFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 65);
        headerView = createView(headerFrame);
        
        
        var nameSize:CGSize = CGSize()
        if self.agentModel.clientName == nil
        {
            nameSize = Utility.calculateStringSize("", textFont:Define.font(TF_13), constrainedSize: CGSizeMake(1000, 20));
        }
        else
        {
            nameSize = Utility.calculateStringSize(self.agentModel.clientName!, textFont:Define.font(TF_13), constrainedSize: CGSizeMake(1000, 20));
        }

        
        var peopelLabelFrame:CGRect = CGRectMake(15, 12, nameSize.width, 20);
        var peopleLabel:UILabel = createCustomeLabel(peopelLabelFrame,CD_Txt_Color_33, self.agentModel.clientName, TF_13);
        headerView.addSubview(peopleLabel);
        
        var phoneLabelFrame:CGRect = CGRectMake(15, CGRectGetMaxY(peopleLabel.frame)+5, 150, 15);
        var phoneLabel:UILabel = createCustomeLabel(phoneLabelFrame, CD_Txt_Color_33, self.agentModel.clientPhone, TF_13);
        headerView.addSubview(phoneLabel);
        
                lineImageV = Utility.drawLine(CGPointMake(0, 65-lineHeight), width:kScreenWidth);
                headerView.addSubview(lineImageV);
        
        var size = CGSize()
        if self.agentModel.clientSourceWay == nil
        {
            size = Utility.calculateStringSize("", textFont: Define.font(TF_13), constrainedSize: CGSizeMake(1000, 15));
        }
        else
        {
            size = Utility.calculateStringSize(self.agentModel.clientSourceWay!, textFont: Define.font(TF_13), constrainedSize: CGSizeMake(1000, 15));
        }

        
        var relationLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(peopleLabel.frame)+5, 15, size.width+6, 15);
        var relationLabel:UILabel = createCustomeLabel(relationLabelFrame, CD_Txt_Color_33, self.agentModel.clientSourceWay,TF_13);
        relationLabel.backgroundColor = CD_GrayColor;
        relationLabel.layer.cornerRadius = 2.0;
        relationLabel.layer.masksToBounds = true;
        relationLabel.textColor = UIColor.whiteColor();
        relationLabel.textAlignment = NSTextAlignment.Center;
        if(countElements("合作") == 0)
        {
            relationLabel.hidden = true;
        }
        else
        {
            relationLabel.hidden = false;
        }
        headerView.addSubview(relationLabel);
        if self.agentModel.isRental == "1"
        {
            imgArr = ["icon0430","client_mail","client_phone"];
        }
        else
        {
            imgArr = ["client_mail","client_phone"];
        }

       
        for(var i = 0;i < imgArr.count;i++)
        {
            var btn:UIButton = UIButton();
            var btnFrame:CGRect = CGRectMake(kScreenWidth-50*(CGFloat(i)+1),7,37, 37);
            btn.frame = btnFrame;
            var imageString:String = imgArr.objectAtIndex(Int(i))as String;
            btn.setImage(UIImage(named: imageString), forState: UIControlState.Normal);
            headerView.addSubview(btn);
            btn.tag = 900+Int(i);
            btn.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside);
        }
        return headerView;
    }
    
    func clickBtn(sender:UIButton)->Void
    {
        var selectBtn:UIButton = sender;
        
        if self.agentModel.isRental == "1"
        {
            switch(selectBtn.tag)
            {
            case 900:
                var webVC = HWWebViewController()
                webVC.clientId = clientInfoId;
                webVC.type = "客户详情"
                webVC.urlStr =  self.agentModel.phpImUrl
                webVC.messageModel.messageId = self.agentModel.messageId;
                webVC.messageModel.source = self.agentModel.messageSource
                if self.agentModel.phpImUrl.length == 0
                {
                    Utility .showToastWithMessage("不可跳转", _view: self.view)
                    return
                }
                else
                {
                    self.navigationController?.pushViewController(webVC, animated: false);
                    
                }

               // self.navigationController?.pushViewController(webVC, animated: false);
                //                    var callWebView = UIWebView()
                //                    var telUrl = NSURL(string: self.agentModel.phpImUrl)
                //                    callWebView.loadRequest(NSURLRequest(URL:telUrl!))
                break;
                
            case 901:
                
                var strSms:String = "";
                var arry = NSArray(objects:self.agentModel.clientPhone!) as NSArray
                self .sendSms(strSms, recipientList:arry)
                
                break;
            case 902:
                self.callPhone()
                print("打电话");
                break;
            default:break;
            }
            
        }
            
        else
            
        {
            switch(selectBtn.tag)
            {
            case 900:
                
                var strSms:String = "";
                var arry = NSArray(objects:self.agentModel.clientPhone!) as NSArray
                self .sendSms(strSms, recipientList:arry)
                
                break;
                
            case 901:
                self.callPhone()
                print("打电话");
                break;
                
                
            default:break;
            }
            
        }

//        switch(selectBtn.tag)
//        {
//        case 900:
//            var strSms:String = "";
//            var arry = NSArray(objects:self.agentModel.clientPhone!) as NSArray
//            self .sendSms(strSms, recipientList:arry)
//            break;
//            
//        case 901:
//            self.callPhone()
//            print("打电话");
//            break;
//        default:break;
//        }
    }
    func callPhone()
    {
        var action = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拨打")
        action.tag = 2001
        action .showInView(self.view)
    }
    //MARK:UIActionSheet的代理
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        if actionSheet.tag == 2001
        {
            if buttonIndex == 1
            {
                self .addCallStateNotification()
                var callWebView = UIWebView()
                self.view .addSubview(callWebView)
                if self.agentModel.clientPhone?.length > 0
                {
                    var telUrl = NSURL(string: "tel://"+self.agentModel.clientPhone!)
                    callWebView .loadRequest(NSURLRequest(URL:telUrl!))
                    
                }
            }
        }
                else if actionSheet.tag == 2002
        {
            if buttonIndex == 1
            {
                let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
                newScheduleVC.sourceType = NewScheduleSourceType.Appoint
                var relatedClient: HWClientModel = HWClientModel()
                relatedClient.clientInfoId = self.agentModel.clientInfoId!
                relatedClient.clientName = self.agentModel.clientName!
                relatedClient.clientPhone = self.agentModel.clientPhone!
                newScheduleVC.relatedClient = relatedClient
                
                self.navigationController?.pushViewController(newScheduleVC, animated: true)

            }
        }
        
        
        else if actionSheet.tag == 2003
        {
            
            if buttonIndex == 1
            {
                self .addCallStateNotifications()
                var callWebView = UIWebView()
                self.view .addSubview(callWebView)
                var infoModel  = self.agentModel.houseTypeList.objectAtIndex(selectIndex) as HWHouseInfoModel
                if infoModel.brokerPhone?.length > 0
                    
                {
                    var telUrl = NSURL(string: "tel://"+infoModel.brokerPhone!)
                    callWebView.loadRequest(NSURLRequest(URL:telUrl!))
                    
                }
                
            }
            
        }
            
        else if actionSheet.tag == 2004
        {
            if buttonIndex == 1
            {
                var infoModel  = self.agentModel.houseTypeList.objectAtIndex(self.selectIndex) as HWHouseInfoModel
                let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
                newScheduleVC.sourceType = NewScheduleSourceType.Appoint
                var relatedClient: HWClientModel = HWClientModel()
                relatedClient.clientInfoId = self.agentModel.clientInfoId!
                relatedClient.clientName = self.agentModel.clientName!
                relatedClient.clientPhone = infoModel.brokerPhone!
                newScheduleVC.relatedClient = relatedClient
                var relatedHouse: HWRelateHouseModel = HWRelateHouseModel()
                relatedHouse.houseId = infoModel.houseId
                relatedHouse.houseType = infoModel.houseType
                relatedHouse.houseName = infoModel.houseName
                newScheduleVC.relatedHouse = relatedHouse
                self.navigationController?.pushViewController(newScheduleVC, animated: true)
                
                
                
            }
        }

    }
    func addCallStateNotification()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dialingNotify:", name: HWCallDetectCenterStateDialingNotification, object: nil)
    }
    
    func removeCallStateNotification()
    {
        NSNotificationCenter .defaultCenter() .removeObserver(self, name: HWCallDetectCenterStateDialingNotification, object: nil)
    }
    func dialingNotify(notification:NSNotification)
    {
        self .removeCallStateNotification()
        
        if iOS8
        {
            var alertCtr  = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            var firstAction = UIAlertAction(title: "新建日程计划", style: UIAlertActionStyle.Default, handler:
                {(let action:UIAlertAction!) -> Void in
                    
                    let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
                    newScheduleVC.sourceType = NewScheduleSourceType.Appoint
                    self.navigationController?.pushViewController(newScheduleVC, animated: true)
                    
                    
            })
            alertCtr .addAction(firstAction)
            
            var secondAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler:
                {(let action:UIAlertAction!) -> Void in
                    
            })
            
            alertCtr .addAction(secondAction)
            
            self .presentViewController(alertCtr, animated: true, completion: nil)
            
        }
            
        else
        {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var action = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "新建日程计划")
                action.tag = 2002
                action .showInView(self.view)
            })
        }
    }
    //MARK:列表打电话
    func addCallStateNotifications()
    {
        NSNotificationCenter .defaultCenter() .addObserver(self, selector: "dialingNotifys:", name: HWCallDetectCenterStateDialingNotification, object: nil)
    }
    
    func removeCallStateNotifications()
    {
        NSNotificationCenter .defaultCenter() .removeObserver(self, name: HWCallDetectCenterStateDialingNotification, object: nil)
    }
    func dialingNotifys(notification:NSNotification)
    {
        self .removeCallStateNotifications()
        
        if iOS8
        {
            var alertCtr  = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            var firstAction = UIAlertAction(title: "新建日程计划", style: UIAlertActionStyle.Default, handler:
                {(let action:UIAlertAction!) -> Void in
                    var infoModel  = self.agentModel.houseTypeList.objectAtIndex(self.selectIndex) as HWHouseInfoModel
                    let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
                    newScheduleVC.sourceType = NewScheduleSourceType.Appoint
                    var relatedClient: HWClientModel = HWClientModel()
                    relatedClient.clientInfoId = self.agentModel.clientInfoId!
                    relatedClient.clientName = self.agentModel.clientName!
                    relatedClient.clientPhone = infoModel.brokerPhone!
                    newScheduleVC.relatedClient = relatedClient
                    var relatedHouse: HWRelateHouseModel = HWRelateHouseModel()
                    relatedHouse.houseId = infoModel.houseId
                    if infoModel.houseType == "新房"
                    {
                        relatedHouse.houseType = "new"
                    }
                    if infoModel.houseType == "二手房"
                    {
                        relatedHouse.houseType = "secondHouse"
                    }
                    relatedHouse.houseName = infoModel.houseName
                    newScheduleVC.relatedHouse = relatedHouse
                    
                    
                    
                    self.navigationController?.pushViewController(newScheduleVC, animated: true)
                    
                    
            })
            alertCtr .addAction(firstAction)
            
            var secondAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler:
                {(let action:UIAlertAction!) -> Void in
                    
            })
            
            alertCtr .addAction(secondAction)
            
            self .presentViewController(alertCtr, animated: true, completion: nil)
            
        }
            
        else
        {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var action = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "新建日程计划")
                action.tag = 2004
                action .showInView(self.view)
            })
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        tableView.registerClass(HWCustomerDetailTableViewCell.self, forCellReuseIdentifier: "cellCustomerDetail")
        let cell = tableView.dequeueReusableCellWithIdentifier("cellCustomerDetail", forIndexPath: indexPath) as HWCustomerDetailTableViewCell
        var houseInfoModel: HWHouseInfoModel = agentModel.houseTypeList.objectAtIndex(indexPath.section) as HWHouseInfoModel
        var listModel = houseInfoModel.followRecordArry .objectAtIndex(indexPath.row) as HWHouseListModel
        cell .didMakeModel(listModel)
        return cell;
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return self.agentModel.houseTypeList.count;

    }

    //MARK:-创建手势
    func createGesture(view:AnyObject,action:Selector)
    {
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: action);
    }
    //MARK:-短信方法
    func sendSms(bodyOfMessage:String,recipientList:NSArray)->Void
    {
        var controller:MFMessageComposeViewController = MFMessageComposeViewController();
        if(MFMessageComposeViewController.canSendText())
        {
            controller.body = bodyOfMessage;
            controller.recipients = recipientList;
            controller.messageComposeDelegate = self;
            self.presentViewController(controller, animated: true, completion: nil);
        }
    }
    //处理发送完的响应结果
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult)
    {
        controller.dismissViewControllerAnimated(true, completion: nil);
        //短信发送后状态码没法比较
    }
    
    //MARK:点击带看按钮的请求
    func lookBtn(sender:UIButton!)
    {
        selectLook = sender.tag-100
        if HWUserLogin.currentUserLogin().brokerType == "B"
        {
            Utility .showToastWithMessage("直客下线不可以发起带看", _view: self.view)
            return
        }

        Utility .showMBProgress(self.view, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        var houseInfoModel: HWHouseInfoModel = agentModel.houseTypeList.objectAtIndex(sender.tag-100) as HWHouseInfoModel
        param .setObject(houseInfoModel.followId!, forKey: "followId")
        manager .postHttpRequest(kClientSendLook, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("请求成功", _view: self.view)
            
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                if code == "2"
                {
                    var alert  = UIAlertView(title: "", message: "今天已经发起过带看，是否补发信息", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                    alert.tag = 1001
                    alert.show()
                }
                if code == "0"
                {
                   Utility .showToastWithMessage(error, _view: self.view)
                }
        }
        
    }
    //MARK:UIAlertView代理
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
        
    {
        if alertView.tag == 1001
        {
            if buttonIndex == 1
            {
                Utility .showMBProgress(self.view, _message: "请求中")
                let manager = HWHttpRequestOperationManager.baseManager()
                var param: NSMutableDictionary! = NSMutableDictionary()
                param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                var houseInfoModel: HWHouseInfoModel = agentModel.houseTypeList.objectAtIndex(selectLook) as HWHouseInfoModel
                param .setObject(houseInfoModel.followId!, forKey: "followId")
                param .setObject(self.agentModel.clientPhone!, forKey: "phone")
                manager .postHttpRequest(kClientSendMessage, parameters: param, queue: nil, success: { (responseObject) -> Void in
                    Utility .hideMBProgress(self.view)
                    Utility .showToastWithMessage("已补发短信信息", _view: self.view)
//                    println(responseObject)
                    //  var status = responseObject("status") as NSString
                    }) { (code, error) -> Void in
                        Utility .hideMBProgress(self.view)
//                        println(code)
                        Utility .showToastWithMessage(error, _view: self.view)
                        
                }
                
                
            }
        }
    }

    //MARK:点击新建日程
    func createSchedule(sender:UIButton!)
    {
        MobClick .event("Houseschedule_click")
        var houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(sender.tag-200) as HWHouseInfoModel;
        let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
        newScheduleVC.sourceType = NewScheduleSourceType.Appoint
        
        
        var relatedHouse: HWRelateHouseModel = HWRelateHouseModel()
        relatedHouse.houseId = houseModel.houseId
        relatedHouse.houseType = houseModel.houseType
        relatedHouse.houseName = houseModel.houseName
        newScheduleVC.relatedHouse = relatedHouse
        
        var relatedClient: HWClientModel = HWClientModel()
        relatedClient.clientInfoId = self.agentModel.clientInfoId!
        relatedClient.clientName = self.agentModel.clientName!
        relatedClient.clientPhone = self.agentModel.clientPhone!
        newScheduleVC.relatedClient = relatedClient
        newScheduleVC.myFunc = { ()->Void in
            self.agentModel.houseTypeList .removeAllObjects()
            self .customerDetailrequest()
            self._customerTable .reloadData()
        }
        self.navigationController?.pushViewController(newScheduleVC, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}
