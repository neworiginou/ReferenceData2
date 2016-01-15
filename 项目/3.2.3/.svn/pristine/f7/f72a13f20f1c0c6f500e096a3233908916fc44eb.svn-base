//
//  HWCustomerDetailViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import MessageUI
class HWCustomerDetailViewController: HWBaseViewController,MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,HWCustomSiftViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,HWCustomAlertViewDelegate
{
    
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    
    var _customerTable:UITableView = UITableView();
    var headerView:UIView = UIView();
    var buyHouseView:UIView = UIView();
    var RemarkView:UIView   = UIView();
    //add by gusheng
    var priviledgeTableV:UITableView = UITableView();
    var schduleArry:NSMutableArray = NSMutableArray();
    //end
    var houseViewTableHeader:UIView = UIView();
    var priviledgeView:UIView = UIView();
    var houseInfoArry = NSMutableArray()
    var houseDateArry:NSMutableArray = NSMutableArray();
    var houseData1:HWClientModel! = HWClientModel();
    var houseData3:HWClientModel! = HWClientModel();
    var houseData2:HWClientModel = HWClientModel();
    var agentModel = HWAgentCustomerDetailModel()
    
    var typeArry = NSMutableArray()
    var listArry = NSMutableArray()
    
    var titleArr = NSMutableArray()
    var clientIntention:NSString = NSString()
    var selectView = HWCustomSiftView()
    var selectIndex = Int()
    var sourceTypeStr = NSString();
    var clientInfoId = NSString()
    var selectLook = Int()
    var ishiden:Bool!
    var moneyText = NSString()
    var imgArr:NSArray =  NSArray()
   var secondLineOneView:UIImageView!
    //testData
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        houseData1.houseType = "新房";
        houseData2.houseType = "二手房";
        houseData1.isAppointHouseFlag = "0";
        houseData2.isAppointHouseFlag = "0";
        houseData3.houseType = "二手房";
        houseData3.isAppointHouseFlag = "1";
        self.navigationItem.titleView = Utility.navTitleView("客户详情")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "toShowMore:", _image: UIImage(named: "more_icon")!)
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod");
        self.view.backgroundColor = UIColor.whiteColor()
        self.customerDetailrequest()
        
        _customerTable = UITableView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), style: UITableViewStyle.Grouped);
        _customerTable.delegate = self;
        _customerTable.dataSource = self;
        _customerTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        _customerTable.backgroundView = nil;
        _customerTable.backgroundColor = UIColor .clearColor();
        self.view.addSubview(self._customerTable);
        
        
    }
    override func backMethod()
    {
        if(sourceTypeStr == "1")//1代表来自抢客
        {
//            self.navigationController?.popToRootViewControllerAnimated(true);
//            NSNotificationCenter.defaultCenter().postNotificationName(kRobCustomerNotification, object: nil);
            //MYP add v3.1 修改 客户详情直接返回抢客抢房
            self.navigationController?.popToViewController(robVC, animated: true)

        }
        else
        {
            if (self.myFunc != nil)
            {
                self.myFunc!()
            }

            
            self.navigationController?.popViewControllerAnimated(true);
        }
    }
    //MARK:-获取客户详情
    func customerDetailrequest()
    {
        Utility .showMBProgress(shareAppDelegate.window!, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(clientInfoId, forKey: "clientInfoId")
        manager .postHttpRequest(kClientDetailList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(shareAppDelegate.window!)
          //  Utility .showToastWithMessage("请求成功", _view: self.view)
            let resultDic: NSDictionary = (responseObject.dictionaryObjectForKey("data") as NSDictionary)
//            println(resultDic)
            
            self.agentModel = HWAgentCustomerDetailModel(dic: resultDic)
            var dic1 = NSDictionary()
            for var i = 0; i < self.agentModel.houseList?.count;i++
            {
                dic1 = self.agentModel.houseList?.objectAtIndex(i) as NSDictionary
                let infoModel = HWHouseInfoModel(dic: dic1 as NSDictionary)
                if(infoModel.houseType == "new")
                {
                    self.schduleArry = NSMutableArray(array: infoModel.nodeList!)
                }
                
                self.agentModel.houseTypeList.addObject(infoModel)
            }
            self.clientIntention = self.agentModel.hasIntention!
            var housePurpose = HWHousePurposeModel()
            //xiaohong
            if self.agentModel.intentionArea == ""
            {
                self.agentModel.intentionArea = "不限"
            }
            if self.agentModel.intentionType == ""
            {
                self.agentModel.intentionType = "住宅"
            }
            
            if self.agentModel.intentionHouseType == ""
            {
                self.agentModel.intentionHouseType = "不限"
            }
            

             self.agentModel.buyHousepurpose.houseTypeArry = [self.agentModel.intentionType!,self.agentModel.intentionArea!,self.agentModel.intentionHouseType!,"\(self.agentModel.intentionHousePrice!)","\(self.agentModel.intentionHouseSize!)"]
            if self.agentModel.intentionPurpose == ""
            {
                 self.agentModel.buyHousepurpose.housepurseArry = NSMutableArray()
            }
            
            else
            {
                var purpseStr:NSString = self.agentModel.intentionPurpose!;
                var purseArryInfo:NSArray = purpseStr.componentsSeparatedByString(",");
                var purseMutableArry:NSMutableArray = NSMutableArray();
                for(var i:Int = 0 ;i < purseArryInfo.count;i++)
                {
                    var str:NSString = purseArryInfo.objectAtIndex(i) as NSString;
                    //8满五年 7唯一住房  2学区房
                    if(str == "7")
                    {
                        purseMutableArry.addObject("唯一住房");
                    }
                    else if(str == "8")
                    {
                        purseMutableArry.addObject("满五年");
                    }
                    else if(str == "2")
                    {
                        purseMutableArry.addObject("学区房");
                    }
                }
                self.agentModel.buyHousepurpose.housepurseArry = purseMutableArry;
            }
            
             self._customerTable.tableHeaderView = self.createHeaderView();
            self._customerTable .reloadData();
           
            }) { (code, error) -> Void in
                Utility .hideMBProgress(shareAppDelegate.window!)
                Utility .showToastWithMessage(error, _view: self.view)
              //  self._customerTable.tableHeaderView = self.createHeaderView();

        }

    }
    func toShowMore(sender: UIButton!) -> Void
    {
        //let titleArr = NSArray(objects: "新建日程", "编辑客户", "转无意向")
        if self.clientIntention == "0"
        {
            titleArr = ["新建日程", "编辑客户", "转有意向","成交确认"]
        }
        if self.clientIntention == "1"
        {
            titleArr = ["新建日程", "编辑客户", "转无意向","成交确认"]

        }
        
        else
        {
             titleArr = ["新建日程", "编辑客户", "转有意向","成交确认"]
        }
        let imageArr = NSArray(objects: "editor_icon3","editor_icon1","editor_icon4","editor_icon7")
        selectView = HWCustomSiftView(title: titleArr, image:imageArr, andDependView: self.navigationItem.rightBarButtonItem?.customView)
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
            MobClick.event("Editclient_click")
            let vc = HWLoggingCustomerVC()
            vc.titileType = "1"
            vc.agentClientModel = self.agentModel
            vc.myFunc = { ()->Void in
                self.agentModel.houseTypeList .removeAllObjects()
                self .customerDetailrequest()
                self._customerTable .reloadData()
               
            }

           self.navigationController?.pushViewController(vc, animated: true)
        }
        else if(index == 2)
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
            self.selectView .removeFromSuperview()
            Utility .showToastWithMessage("修改成功", _view: self.view)
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
        
        else if(index == 3)
        {
               self.getmoneyContent()
        }
    }
    override func viewWillAppear(animated: Bool)
    {
       super.viewWillAppear(animated)
       self.navigationController?.navigationBarHidden = false
      
        
    }
    func createHeaderView()->UIView
    {
        headerView.removeFromSuperview();
        headerView.backgroundColor = UIColor.clearColor();
        if(agentModel.priviledgeArry?.count > 0)
        {
            if(agentModel.priviledgeArry.count > 1)
            {
                var headerFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 228-44+62+60);
                headerView = createView(headerFrame);
            }
            else
            {
                var headerFrame:CGRect = CGRectMake(0, 0, kScreenWidth,228-44+62+60);
                headerView = createView(headerFrame);
            }
            
        }
        else
        {
            var headerFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 228-44+62);
            headerView = createView(headerFrame);
        }
      
        
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
        var peopleLabel:UILabel = createCustomeLabel(peopelLabelFrame,CD_Txt_Color_33,self.agentModel.clientName, TF_13);
        headerView.addSubview(peopleLabel);
        
        var phoneLabelFrame:CGRect = CGRectMake(15, CGRectGetMaxY(peopleLabel.frame)+5, 150, 15);
        var phoneLabel:UILabel = createCustomeLabel(phoneLabelFrame, CD_Txt_Color_33,self.agentModel.clientPhone, TF_13);
        headerView.addSubview(phoneLabel);
        
        //add by gusheng 3.2.3
        
        var size = CGSize()
        if self.agentModel.clientRange == nil
        {
            size = Utility.calculateStringSize("", textFont: Define.font(TF_13), constrainedSize: CGSizeMake(1000, 15));
        }
        else
        {
            size = Utility.calculateStringSize(self.agentModel.clientRange!, textFont: Define.font(TF_13), constrainedSize: CGSizeMake(1000, 15));
        }
        var relationLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(peopleLabel.frame)+5, 15, size.width+6, 15);
        var relationLabel:UILabel = createCustomeLabel(relationLabelFrame, CD_Txt_Color_33, self.agentModel.clientRange,TF_13);
        relationLabel.backgroundColor = "#c7c7c7".UIColor;
        relationLabel.layer.cornerRadius = 2.0;
        relationLabel.layer.masksToBounds = true;
        relationLabel.textColor = UIColor.whiteColor();
        relationLabel.textAlignment = NSTextAlignment.Center;
        if self.agentModel.clientRange?.length == 0
        {
            relationLabel.hidden = true;
        }
        else
        {
            relationLabel.hidden = false;
        }
        headerView.addSubview(relationLabel);
        //end
        var size1 = CGSize()
        if self.agentModel.clientSourceWay == nil
        {
         size1 = Utility.calculateStringSize("", textFont: Define.font(TF_13), constrainedSize: CGSizeMake(1000, 15));
        }
        else
        {
            size = Utility.calculateStringSize(self.agentModel.clientSourceWay!, textFont: Define.font(TF_13), constrainedSize: CGSizeMake(1000, 15));
        }
        var relationLabelFrame1:CGRect = CGRectMake(CGRectGetMaxX(relationLabel.frame)+5, 15, size.width+6, 15);
        var relationLabel1:UILabel = createCustomeLabel(relationLabelFrame, CD_Txt_Color_33, self.agentModel.clientSourceWay,TF_13);
        relationLabel1.backgroundColor = "#c7c7c7".UIColor;
        relationLabel1.layer.cornerRadius = 2.0;
        relationLabel1.layer.masksToBounds = true;
        relationLabel1.textColor = UIColor.whiteColor();
        relationLabel1.textAlignment = NSTextAlignment.Center;
        if self.agentModel.clientSourceWay?.length == 0
        {
            relationLabel1.hidden = true;
        }
        else
        {
            relationLabel1.hidden = false;
        }
        headerView.addSubview(relationLabel1);
       if self.agentModel.isRental == "1"
       {
         imgArr = ["icon0430","client_mail","client_phone"];
       }
        else
       {
        imgArr = ["client_mail","client_phone"];
        }
        for(var i = 0;i<imgArr.count;i++)
        {
            var btn:UIButton = UIButton();
            var btnFrame:CGRect = CGRectMake(kScreenWidth-50*(CGFloat(i)+1),12,37, 37);
            btn.frame = btnFrame;
            btn.tag = 900+i;
            var imageString:String = imgArr.objectAtIndex(Int(i))as String;
            btn.setBackgroundImage(UIImage(named: imageString), forState: UIControlState.Normal);
            btn.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside);
            headerView.addSubview(btn);
           
        }
        self.createHouseHeaderView(headerView);
        headerView.backgroundColor = CD_BackGroundColor;
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
//                var webVC = HWWebViewController()
//                webVC.clientId = clientInfoId;
//                webVC.type = "客户详情"
//                webVC.messageModel.messageId = self.agentModel.messageId
//                webVC.messageModel.source = self.agentModel.messageSource
//                webVC.urlStr =  self.agentModel.phpImUrl
//                if self.agentModel.phpImUrl.length == 0
//                {
//                    Utility .showToastWithMessage("不可跳转", _view: self.view)
//                    return
//                }
//                else
//                {
//                    self.navigationController?.pushViewController(webVC, animated: false);
//
//                }
                Utility.showMBProgress(self.view, _message: "加载中")
                let manager = HWHttpRequestOperationManager.baseManager()
                var param: NSMutableDictionary = NSMutableDictionary()
                param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                param .setObject(self.agentModel.messageId, forKey: "messageId")
                param .setObject(self.agentModel.messageSource, forKey: "source")
                manager .postHttpRequest(kMessageDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
                    Utility .hideMBProgress(self.view);
                    Utility .showToastWithMessage("请求成功", _view: self.view)
                     var dataDic = NSDictionary()
                    let dict: NSDictionary = responseObject as NSDictionary
                    var dataArr:NSArray = dict.arrayObjectForKey("data")
                    dataDic = dataArr.objectAtIndex(0) as NSDictionary
                    var webVC = HWWebViewController()
                    webVC.messageModel.messageId = self.agentModel.messageId
                    webVC.messageModel.source = self.agentModel.messageSource
                    webVC.urlStr = dataDic.stringObjectForKey("imUrl")
                    if dataDic.stringObjectForKey("imUrl").length == 0
                    {
                        Utility .showToastWithMessage("不可跳转", _view: self.view)
                        return
                    }
                    else
                    {
                        self.navigationController?.pushViewController(webVC, animated: false);
                        
                    }
                    
                    
                    }, failure: { (error, code) -> Void in
                        Utility .hideMBProgress(self.view);
                        if (error.integerValue == kStatusFailure )
                        {
                            Utility .showToastWithMessage("网络未连接", _view: self.view)
                        }
                        else
                        {
                            Utility .showToastWithMessage(error, _view: self.view)
                            
                        }
                })

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
                
                else
                {
                    Utility .showToastWithMessage("手机号为空", _view: self.view)
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
        NSNotificationCenter .defaultCenter() .addObserver(self, selector: "dialingNotify:", name: HWCallDetectCenterStateDialingNotification, object: nil)
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
                    var relatedClient: HWClientModel = HWClientModel()
                    relatedClient.clientInfoId = self.agentModel.clientInfoId!
                    relatedClient.clientName = self.agentModel.clientName!
                    relatedClient.clientPhone = self.agentModel.clientPhone!
                    newScheduleVC.relatedClient = relatedClient

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

    //MARK:-创建sectionHeaderView
    func createHouseHeaderView(headerTempView:UIView)->Void
    {
        var houseHeaderFrame:CGRect;
        if(agentModel.priviledgeArry.count > 0)
        {
            if(agentModel.priviledgeArry.count > 1)
            {
                houseHeaderFrame = CGRectMake(0,62, kScreenWidth, headerTempView.frame.size.height - 62);
            }
            else
            {
                houseHeaderFrame = CGRectMake(0,62, kScreenWidth, headerTempView.frame.size.height - 62);
            }
            
        }
        else
        {
            houseHeaderFrame = CGRectMake(0,62, kScreenWidth, headerTempView.frame.size.height - 62);
        }
        var houseHeaderView:UIView = createView(houseHeaderFrame);
        houseHeaderView.userInteractionEnabled = true;
        headerTempView.addSubview(houseHeaderView);
        
        var houseHeaderTopImageFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 30);
        var houseHeaderTopImageV:UIImageView = createCustomerImageView(houseHeaderTopImageFrame, "");
        houseHeaderTopImageV.backgroundColor = CD_BackGroundColor;
        houseHeaderView.addSubview(houseHeaderTopImageV);
        
        var lineTopImageV:UIImageView = Utility.drawLine(CGPointMake(0, 0), width:kScreenWidth);
        houseHeaderTopImageV.addSubview(lineTopImageV);
        
        var relativeFrame:CGRect = CGRectMake(15, 5, 200, 20);
        var relativeHouseLabel:UILabel = createCustomeLabel(relativeFrame, CD_Txt_Color_66, "购房意向", TF_13);
        houseHeaderTopImageV.addSubview(relativeHouseLabel);
        
        var lineBootomImageV:UIImageView = Utility.drawLine(CGPointMake(0,29.5), width:kScreenWidth);
        houseHeaderTopImageV.addSubview(lineBootomImageV);
        
        //创建购房意向视图
        self.createBuyHouseView(houseHeaderView);
        if(self.agentModel.remarkStr == "")
        {
            
        }
        else
        {
            self.createRemarkView(houseHeaderView);
        }
        if(self.agentModel.clientSourceWay == "下线")
        {
            
        }
        else
        {
            self.createRecomondView(houseHeaderView);
        }
        if(agentModel.priviledgeArry?.count > 0)
        {
            //创建优惠劵列表视图
            self.createPrevildageView(houseHeaderView);
        }
        //创建报备以及二手房视图
        self.createFlightHouseView(houseHeaderView);
    }
    //MARK:-创建下线推荐人视图
    func createRecomondView(headerTempView:UIView)->Void
    {
            houseViewTableHeader = createView(CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 75));
            if(self.agentModel.remarkStr == "")
            {
                houseViewTableHeader.frame = CGRectMake(0,  CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 75);
            }
            else
            {
                houseViewTableHeader.frame = CGRectMake(0,  CGRectGetMaxY(RemarkView.frame), kScreenWidth, 75);
            }
            houseViewTableHeader.backgroundColor = UIColor.whiteColor();
            headerTempView.addSubview(houseViewTableHeader);
        
            var houseBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom)as UIButton;
            houseBtn.addTarget(self, action: "gotoNewHouseDetail:", forControlEvents: UIControlEvents.TouchUpInside);
            houseBtn.backgroundColor = UIColor.whiteColor();
            houseBtn.frame = CGRectMake(0, 30, kScreenWidth, 45);
            houseViewTableHeader.addSubview(houseBtn);
            
            
            var arrowImageV:UIImageView = createCustomerImageView(CGRectMake(kScreenWidth-15-8,30+(45-14)/2, 8, 14), "arrow_next");
            houseViewTableHeader.addSubview(arrowImageV);
            
            
            var grayView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 30));
            grayView.backgroundColor = CD_BackGroundColor;
            houseViewTableHeader.addSubview(grayView);
            
            var lineOneImageV:UIImageView = Utility.drawLine(CGPointMake(0, 0), width: kScreenWidth);
            //  houseViewTableHeader.addSubview(lineOneImageV);
            
            var lineTwoImageV:UIImageView = Utility.drawLine(CGPointMake(0, 29.5), width: kScreenWidth);
            houseViewTableHeader.addSubview(lineTwoImageV);
            
            //推荐人
            var houseTitleFrame:CGRect = CGRectMake(15, 5, 70, 20);
            var houseTitleLabel:UILabel = createCustomeLabel(houseTitleFrame, CD_Txt_Color_33, "推荐人", TF_13);
            houseTitleLabel.sizeToFit();
            houseViewTableHeader.addSubview(houseTitleLabel);
            
            //姓名
            var areaFrame:CGRect = CGRectMake(15, 30+12,100,20);
        
            var areaLabel:UILabel = createCustomeLabel(areaFrame, CD_Txt_Color_33, "谷胜", TF_13);
            areaLabel.textAlignment = NSTextAlignment.Left;
            //areaLabel.backgroundColor = UIColor .redColor()
            //areaLabel.sizeToFit();
            houseViewTableHeader.addSubview(areaLabel);
        
            //电话号码
            var phoneFrame:CGRect = CGRectMake(kScreenWidth - 100-10-23, 30+12,100,20);
            var phoneLabel:UILabel = createCustomeLabel(phoneFrame, CD_Txt_Color_33, "15921899183", TF_13);
            phoneLabel.textAlignment = NSTextAlignment.Right;
            //areaLabel.backgroundColor = UIColor .redColor()
            //areaLabel.sizeToFit();
            houseViewTableHeader.addSubview(phoneLabel);
        
    }
    //MARK：-创建备注视图
    func createRemarkView(headerTempView:UIView)->Void
    {
        var remarkFrame:CGRect = CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 80);
        RemarkView = createView(remarkFrame);
        RemarkView.userInteractionEnabled = true;
        RemarkView.backgroundColor = UIColor.whiteColor();
        
        
        var houseHeaderTopImageV:UIImageView = createCustomerImageView(CGRectMake(0, 0, kScreenWidth, 20), "");
        houseHeaderTopImageV.backgroundColor = CD_BackGroundColor;
        RemarkView.addSubview(houseHeaderTopImageV);

        var remarkTitleLabel:UILabel = createCustomeLabel(CGRectMake(15, 0, kScreenWidth-15, 20), CD_Txt_Color_66, "备注", TF_13);
        remarkTitleLabel.textColor = CD_Txt_Color_66;
        remarkTitleLabel.backgroundColor = UIColor.clearColor();
        RemarkView.addSubview(remarkTitleLabel);
        
        
        var remarkLabel:UILabel = createCustomeLabel(CGRectMake(15, 20, kScreenWidth-15, 100), CD_Txt_Color_66, "备注", TF_13);
        remarkLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        remarkLabel.numberOfLines = 0;
        remarkLabel.text = self.agentModel.remarkStr;
        var  factualSize =  Utility.calculateStringSize(remarkLabel.text!, textFont: Define.font(13), constrainedSize: CGSizeMake(kScreenWidth-30, 1000));
        remarkLabel.frame = CGRectMake(15, 20, kScreenWidth-30,factualSize.height);
        RemarkView.frame = CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 20.0+factualSize.height)
        RemarkView.addSubview(remarkLabel);
        headerTempView.addSubview(RemarkView);
        
    }
    //MARK:-创建优惠劵列表视图
    func createPrevildageView(headerTempView:UIView)->Void
    {
        if(agentModel.priviledgeArry.count > 1)
        {
            var privildageFrame:CGRect = CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 80);
            if(self.agentModel.clientSourceWay != "下线")
            {
                privildageFrame = CGRectMake(0, CGRectGetMaxY(houseViewTableHeader.frame), kScreenWidth, 80);
            }
            else
            {
                if(self.agentModel.remarkStr == "")
                {
                    privildageFrame = CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 80);
                }
                else
                {
                    privildageFrame = CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 80);
                }
                
            }
            priviledgeView = createView(privildageFrame);
            priviledgeView.userInteractionEnabled = true;
            priviledgeView.backgroundColor = UIColor.whiteColor();
            let count1 = agentModel.priviledgeArry.count;
            
            var houseHeaderTopImageV:UIImageView = createCustomerImageView(CGRectMake(0, 0, kScreenWidth, 20), "");
            houseHeaderTopImageV.backgroundColor = CD_BackGroundColor;
            priviledgeView.addSubview(houseHeaderTopImageV);
            
            
            var privilidageTitleLabel:UILabel = createCustomeLabel(CGRectMake(15, 0, kScreenWidth-15, 20), CD_Txt_Color_66, "优惠券信息", TF_13);
            priviledgeView.addSubview(privilidageTitleLabel);
            if(agentModel.selectedStr == "0")
            {
                priviledgeTableV = UITableView(frame: CGRectMake(0, 20, kScreenWidth, 60));
            }
            else
            {
                let count = agentModel.priviledgeArry.count;
                priviledgeTableV = UITableView(frame: CGRectMake(0, 20, kScreenWidth, CGFloat(40*count+20)));
                priviledgeView.frame = CGRectMake(priviledgeView.frame.origin.x, priviledgeView.frame.origin.y, priviledgeView.frame.size.width,CGFloat(40*count)+40);
            }
        }
        else
        {
            var privildageFrame:CGRect = CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 60);
            priviledgeView = createView(privildageFrame);
            priviledgeView.backgroundColor = UIColor.whiteColor();
            var privilidageTitleLabel:UILabel = createCustomeLabel(CGRectMake(15, 0, kScreenWidth-15, 20), CD_Txt_Color_66, "优惠劵信息", TF_13);
            
            var houseHeaderTopImageV:UIImageView = createCustomerImageView(CGRectMake(0, 0, kScreenWidth, 20), "");
            houseHeaderTopImageV.backgroundColor = CD_BackGroundColor;
            priviledgeView.addSubview(houseHeaderTopImageV);
             priviledgeView.addSubview(privilidageTitleLabel);
            
            priviledgeTableV = UITableView(frame: CGRectMake(0, 20, kScreenWidth, 40));
        }
        priviledgeTableV.backgroundColor = UIColor.blueColor();
        priviledgeTableV.separatorStyle = UITableViewCellSeparatorStyle.None;
        priviledgeTableV.delegate = self;
        priviledgeTableV.dataSource = self;
        priviledgeTableV.scrollEnabled = true;
        priviledgeTableV.backgroundColor = UIColor.whiteColor();
        priviledgeTableV.userInteractionEnabled = true;
        priviledgeView.addSubview(priviledgeTableV);
        headerTempView.addSubview(priviledgeView);
        
    }
    
    //MARK:-创建购房意向视图
    func createBuyHouseView(headerTempView:UIView)->Void
    {
        var buyhouseFrame:CGRect = CGRectMake(0, 30, kScreenWidth, 100);
        buyHouseView = createView(buyhouseFrame);
        buyHouseView.backgroundColor = UIColor.whiteColor();
        if self.agentModel.buyHousepurpose.houseTypeArry == ""
        {
            houseInfoArry = ["住宅","不限","不限","0-不限","0-不限"]
        }
        else
        {
            houseInfoArry = self.agentModel.buyHousepurpose.houseTypeArry
        }
        
        var lastLabel:UILabel? = nil;
        var fengLineFlag:String = "0";
        var houseTagLabel:UILabel = UILabel();
        var jixunFlag:String = "0";
        
        for(var i:Int = 0;i < houseInfoArry.count;i++)
        {
            if(lastLabel != nil)
            {
                var houseTagFrame = CGRectMake(CGRectGetMaxX(lastLabel!.frame)+10, 15, 100, 15);
                houseTagLabel = createCustomeLabel(houseTagFrame, CD_Txt_Color_33, houseInfoArry.objectAtIndex(Int(i))as NSString, TF_13);
                
                houseTagLabel.frame = returnLabelFactualSize(houseTagLabel, TF_13);
                lastLabel = houseTagLabel;
                if((CGRectGetMaxX(houseTagLabel.frame)>(kScreenWidth - 15))&&(fengLineFlag == "0")||(jixunFlag == "1"))
                {
                   fengLineFlag = "1";
                    if(jixunFlag == "1")
                    {
                        houseTagLabel.frame = CGRectMake(15+lastLabel!.frame.size.width+10, 30, houseTagLabel.frame.size.width, houseTagLabel.frame.size.height);
                        
                    }
                    else
                    {
                        houseTagLabel.frame = CGRectMake(15, 30, houseTagLabel.frame.size.width, houseTagLabel.frame.size.height);
                        buyHouseView.frame = CGRectMake(buyHouseView.frame.origin.x, buyHouseView.frame.origin.y, buyHouseView.frame.size.width, buyHouseView.frame.size.height + 15);
                         headerView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height+15)
                        //_customerTable.reloadData();

                    }
                    lastLabel = houseTagLabel;
                    jixunFlag = "1";
                }
            }
            else
            {
                if(fengLineFlag == "0")
                {
                    var houseTagTempFrame:CGRect = CGRectMake(15, 15, 100, 15);
                    houseTagLabel = createCustomeLabel(houseTagTempFrame, CD_Txt_Color_33, houseInfoArry.objectAtIndex(Int(i))as NSString, TF_13);
                    houseTagLabel.frame = returnLabelFactualSize(houseTagLabel, TF_13);
                }
                else
                {
                    var houseTagTempFrame:CGRect = CGRectMake(15, 30, 100, 15);
                    houseTagLabel = createCustomeLabel(houseTagTempFrame, CD_Txt_Color_33, houseInfoArry.objectAtIndex(Int(i))as NSString, TF_13);
                    houseTagLabel.frame = returnLabelFactualSize(houseTagLabel, TF_13);
                }
                lastLabel = houseTagLabel;
            }
            if(i < (houseInfoArry.count - 1))
            {
                var lineVerticalFrame:CGRect = CGRectMake(CGRectGetMaxX(houseTagLabel.frame)+5, houseTagLabel.frame.origin.y, 0.5, houseTagLabel.frame.size.height);
                var lineVerticalImageV:UIImageView = createCustomerImageView(lineVerticalFrame, "");
                lineVerticalImageV.backgroundColor = CD_LineColor;
                buyHouseView.addSubview(lineVerticalImageV);
            }
            buyHouseView.addSubview(houseTagLabel);
        }
        headerTempView.addSubview(buyHouseView);
        
        //
        var labelArry:NSArray = []
        if self.agentModel.intentionPurpose == nil
        {
            return
        }
        
        else
        {
            labelArry = self.agentModel.buyHousepurpose.housepurseArry;
            if(labelArry.count == 0)
            {
                buyHouseView.frame = CGRectMake(buyHouseView.frame.origin.x, buyHouseView.frame.origin.y, buyHouseView.frame.size.width, buyHouseView.frame.size.height - 15);
            }
        }
        var view:HWStreamLabelView = HWStreamLabelView(item: labelArry, constrainedFrame: CGRectMake(15, CGRectGetMaxY(houseTagLabel.frame)+15,kScreenWidth-30, 1000), constrainedItemSize: CGSizeMake(1000, 20));
        view.itemBorderColor = CD_MainColor.CGColor;
        view.itemBorderWidth = 1.0;
        view.itemCornerRadius = 3.0;
        view.itemTitleColor = CD_MainColor;
        view.itemFont = UIFont(name: "Helvetica Neue", size: TF_13);
        var i:CGFloat = CGFloat(labelArry.count/5);
        if(labelArry.count%5 != 0)
        {
            i++;
        }
        if(i > 1)
        {
            buyHouseView.frame = CGRectMake(buyHouseView.frame.origin.x, buyHouseView.frame.origin.y, buyHouseView.frame.size.width, buyHouseView.frame.size.height+(i-1)*20)
            headerView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height+(i-1)*20)
            _customerTable.reloadData();
        }
        buyHouseView.addSubview(view);
        var str = "客户有效期剩"+self.agentModel.robedProtectDays+"天"
        var attributeStr = NSMutableAttributedString(string: str)
        let range = NSMakeRange(countElements("客户有效期剩"),self.agentModel.robedProtectDays.length)
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: range)
        var protectDayFrame:CGRect = CGRectMake(15,buyHouseView.frame.size.height-25, kScreenWidth-2*15, 15);
        var protectDayLabel:UILabel = createCustomeLabel(protectDayFrame, CD_Txt_Color_66,"", TF_13);
         protectDayLabel.attributedText = attributeStr
        if self.agentModel.robedProtectDays == "-1"
        {
            protectDayLabel.hidden = true
            buyHouseView.frame = CGRectMake(buyHouseView.frame.origin.x, buyHouseView.frame.origin.y, buyHouseView.frame.size.width, buyHouseView.frame.size.height - 15);
        } 
        if self.agentModel.robedProtectDays == "0"
        {
            protectDayLabel.text = "客户已过保护期"
        }
        if self.agentModel.robedProtectDays?.intValue > 0
        {
            var str = "客户有效期剩"+self.agentModel.robedProtectDays!+"天"
            var attributeStr = NSMutableAttributedString(string: str)
            let range = NSMakeRange(countElements("客户有效期剩"),self.agentModel.robedProtectDays.length )
            attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: range)
            protectDayLabel.attributedText = attributeStr
        }
        if self.agentModel.robedProtectDays == ""
        {
           protectDayLabel.hidden = true
            
        }
        var buyHouseLine:UIImageView = Utility.drawLine(CGPointMake(0, buyHouseView.frame.size.height-0.5), width: kScreenWidth);
        buyHouseView.addSubview(buyHouseLine);
          buyHouseView.addSubview(protectDayLabel);
//        var confirmBtn = UIButton(frame: CGRectMake(kScreenWidth-90-15,buyHouseView.frame.size.height-15-40, 90, 40))
//        confirmBtn.backgroundColor = CD_GreenColor
//        confirmBtn.addTarget(self, action: "confirmBtnClick:", forControlEvents: .TouchUpInside)
//        confirmBtn.tag = 1000
//        confirmBtn.titleLabel?.font = Define.font(15)
//        confirmBtn.layer.cornerRadius = 3
//        confirmBtn.layer.masksToBounds = true
//        confirmBtn.setTitle("成交确认", forState: .Normal)
//        confirmBtn.bringSubviewToFront(self.view)
//        //buyHouseView.addSubview(confirmBtn)
     
    }
    func confirmBtnClick(sender:UIButton!)
    {
        
        
        if sender.tag == 1000
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
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
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
        if content == ""
        {
            Utility .showToastWithMessage("输入金额不能为空", _view: self.view)
            return
        }
        Utility .showMBProgress(self.view, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param .setObject(self.agentModel.clientInfoId!, forKey: "clientInfoId")
        param .setObject(content, forKey: "clientDealAmount")
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")

        
        manager .postHttpRequest(kClientDealAmount, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("请求成功", _view: self.view)
           
            
            }) { ( code, error) -> Void in
                Utility .hideMBProgress(self.view)
                 Utility .showToastWithMessage(error, _view: self.view)
        }
        
    

    }
    //MARK:-构建报备楼盘视图以及二手房
    func createFlightHouseView(headerTempView:UIView)->Void
    {
        //报备楼盘
        if(agentModel.priviledgeArry?.count > 0)
        {
            self.view.userInteractionEnabled = true;
            headerView.userInteractionEnabled = true;
             var flightTitleView:UIView = createView(CGRectMake(0, CGRectGetMaxY(priviledgeView.frame), kScreenWidth, 10));
            flightTitleView.backgroundColor = CD_BackGroundColor;
            headerTempView.addSubview(flightTitleView);
            
            
            var flightHouseView:UIView = createView(CGRectMake(10, CGRectGetMaxY(priviledgeView.frame)+10, kScreenWidth/2-5-15, 44));
            flightHouseView.layer.borderColor = CD_LineColor.CGColor;
            flightHouseView.layer.borderWidth = 0.5;
            flightHouseView.backgroundColor = UIColor.whiteColor();
            
            var flightTotalView:UIView = createView(CGRectMake(0, CGRectGetMaxY(priviledgeView.frame), kScreenWidth, 64));
            flightTotalView.backgroundColor = CD_BackGroundColor;
            
            
            headerTempView.addSubview(flightTotalView);
            headerTempView.userInteractionEnabled = true;
            headerTempView.addSubview(flightHouseView);
           
            
            var financialLineOneView:UIImageView = Utility.drawLine(CGPointMake(0, 0), width: kScreenWidth);
            //flightHouseView.addSubview(financialLineOneView);
            
            var flightImageV:UIImageView = createCustomerImageView(CGRectMake(15, (44-23)/2, 23, 23), "house_icon1");
            var flightHouseLabel:UILabel = createCustomeLabel(CGRectMake(CGRectGetMaxX(flightImageV.frame)+5, 13, 100, 15), CD_Txt_Color_33, "报备楼盘", TF_15);
            flightHouseView.addSubview(flightHouseLabel);
            flightHouseView.addSubview(flightImageV);
            
            var seperateLineImageV:UIImageView = Utility.drawLine(CGPointMake(0, 43.5), width: kScreenWidth);
            //flightHouseView.addSubview(seperateLineImageV);
            
            var flightHouseBtn:UIButton = UIButton(frame: flightHouseView.frame);
            flightHouseBtn.addTarget(self, action: "lookFlightHouse:", forControlEvents: UIControlEvents.TouchUpInside);
            //headerTempView.addSubview(flightHouseBtn);
            //二手房
            
            var secondHouseView:UIView = createView(CGRectMake(kScreenWidth-15-CGRectGetWidth(flightHouseView.frame), CGRectGetMaxY(priviledgeView.frame)+10, kScreenWidth/2-5-15, 44));
            secondHouseView.layer.borderColor = CD_LineColor.CGColor;
            secondHouseView.layer.borderWidth = 0.5;
            secondHouseView.backgroundColor = UIColor.whiteColor();
            
            headerTempView.addSubview(secondHouseView);//呵呵
            
            secondLineOneView = Utility.drawLine(CGPointMake(0, 43.5), width: kScreenWidth);
            //flightHouseView.addSubview(secondLineOneView);
            
            var secondImageV:UIImageView = createCustomerImageView(CGRectMake(15, (44-23)/2, 23, 23), "house_icon2");
            var secondHouseLabel:UILabel = createCustomeLabel(CGRectMake(CGRectGetMaxX(secondImageV.frame)+5, 13, 100, 15), CD_Txt_Color_33, "匹配二手房", TF_15);
            secondHouseView.addSubview(secondHouseLabel);
            secondHouseView.addSubview(secondImageV);
            headerView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(priviledgeView.frame)+126);
            headerTempView.frame = CGRectMake(0, 62, kScreenWidth, CGRectGetMaxY(priviledgeView.frame)+64);
            headerTempView.backgroundColor = CD_BackGroundColor;
            self.createGesture(flightHouseView, action: "lookFlightHouse:");
            self.createGesture(secondHouseView, action: "lookSecondHouse:");
        }
        else
        {
             var flightTitleView:UIView = createView(CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 10));
            if(self.agentModel.clientSourceWay != "下线")
            {
                 flightTitleView.frame = CGRectMake(0, CGRectGetMaxY(houseViewTableHeader.frame), kScreenWidth, 10)
            }
            else
            {
                if(self.agentModel.remarkStr == "")
                {
                    flightTitleView.frame = CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 10)
                }
                else
                {
                    flightTitleView.frame = CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 10)
                }

            }
            flightTitleView.backgroundColor = CD_BackGroundColor;
            headerTempView.addSubview(flightTitleView);
            
            
            
            var flightHouseView:UIView = createView(CGRectMake(10, CGRectGetMaxY(RemarkView.frame)+10, kScreenWidth/2-5-15, 44));
            if(self.agentModel.remarkStr == "")
            {
                flightHouseView.frame = CGRectMake(10, CGRectGetMaxY(buyHouseView.frame)+10, kScreenWidth/2-5-15, 44)
            }
            if(self.agentModel.clientSourceWay != "下线")
            {
                flightHouseView.frame = CGRectMake(10, CGRectGetMaxY(houseViewTableHeader.frame)+10, kScreenWidth/2-5-15, 44)
            }
            else
            {
                if(self.agentModel.remarkStr == "")
                {
                    flightHouseView.frame = CGRectMake(10, CGRectGetMaxY(buyHouseView.frame)+10, kScreenWidth/2-5-15, 44)
                }
                else
                {
                    flightHouseView.frame = CGRectMake(10, CGRectGetMaxY(RemarkView.frame)+10, kScreenWidth/2-5-15, 44)
                }
                
            }
            var flightTotalView:UIView = createView(CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 54));
            if(self.agentModel.clientSourceWay != "下线")
            {
                flightTotalView.frame = CGRectMake(0, CGRectGetMaxY(houseViewTableHeader.frame), kScreenWidth, 54)
            }
            else
            {
                if(self.agentModel.remarkStr == "")
                {
                    flightTotalView.frame = CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 54)
                }
                else
                {
                    flightTotalView.frame = CGRectMake(0, CGRectGetMaxY(RemarkView.frame), kScreenWidth, 54)
                }

            }
            flightTotalView.backgroundColor = CD_BackGroundColor;
             headerTempView.addSubview(flightTotalView);
            
            
            flightHouseView.layer.borderColor = CD_LineColor.CGColor;
            flightHouseView.layer.borderWidth = 0.5;
            flightHouseView.backgroundColor = UIColor.whiteColor();
            headerTempView.userInteractionEnabled = true;
            headerTempView.addSubview(flightHouseView);
            
            var financialLineOneView:UIImageView = Utility.drawLine(CGPointMake(0, 0), width: kScreenWidth);
            //flightHouseView.addSubview(financialLineOneView);
            
            var flightImageV:UIImageView = createCustomerImageView(CGRectMake(15, (44-23)/2, 23, 23), "house_icon1");
            var flightHouseLabel:UILabel = createCustomeLabel(CGRectMake(CGRectGetMaxX(flightImageV.frame)+5, 13, 100, 15), CD_Txt_Color_33, "报备楼盘", TF_15);
            flightHouseView.addSubview(flightHouseLabel);
            flightHouseView.addSubview(flightImageV);
            
            //二手房
            
            var secondHouseView:UIView = createView(CGRectMake(kScreenWidth-15-CGRectGetWidth(flightHouseView.frame), CGRectGetMaxY(RemarkView.frame)+10, kScreenWidth/2-10-15, 44));
            if(self.agentModel.clientSourceWay != "下线")
            {
                 secondHouseView.frame = CGRectMake(kScreenWidth-15-CGRectGetWidth(flightHouseView.frame), CGRectGetMaxY(houseViewTableHeader.frame)+10, kScreenWidth/2-10-15, 44)
            }
            else
            {
                if(self.agentModel.remarkStr == "")
                {
                    secondHouseView.frame = CGRectMake(kScreenWidth-15-CGRectGetWidth(flightHouseView.frame), CGRectGetMaxY(buyHouseView.frame)+10, kScreenWidth/2-10-15, 44)
                }
                else
                {
                    secondHouseView.frame = CGRectMake(kScreenWidth-15-CGRectGetWidth(flightHouseView.frame), CGRectGetMaxY(RemarkView.frame)+10, kScreenWidth/2-10-15, 44)
                }
                
            }
            secondHouseView.layer.borderColor = CD_LineColor.CGColor;
            secondHouseView.layer.borderWidth = 0.5;
            secondHouseView.backgroundColor = UIColor.whiteColor();
            headerTempView.addSubview(secondHouseView);//呵呵
            
            secondLineOneView = Utility.drawLine(CGPointMake(0, 43.5), width: kScreenWidth);
            //flightHouseView.addSubview(secondLineOneView);
            
            var secondImageV:UIImageView = createCustomerImageView(CGRectMake(15, (44-23)/2, 23, 23), "house_icon2");
            var secondHouseLabel:UILabel = createCustomeLabel(CGRectMake(CGRectGetMaxX(secondImageV.frame)+5, 13, 100, 15), CD_Txt_Color_33, "匹配二手房", TF_15);
            secondHouseView.addSubview(secondHouseLabel);
            secondHouseView.addSubview(secondImageV);
            
            
            self.createGesture(flightHouseView, action: "lookFlightHouse:");
            self.createGesture(secondHouseView, action: "lookSecondHouse:");
            headerTempView.frame = CGRectMake(0, 62, kScreenWidth, CGRectGetMaxY(RemarkView.frame)+54);
            if(self.agentModel.clientSourceWay != "下线")
            {
                    headerTempView.frame = CGRectMake(0, 62, kScreenWidth, CGRectGetMaxY(houseViewTableHeader.frame)+54);
            }
            else
            {
                if(self.agentModel.remarkStr == "")
                {
                    headerTempView.frame = CGRectMake(0, 62, kScreenWidth, CGRectGetMaxY(buyHouseView.frame)+54);
                }
                else
                {
                     headerTempView.frame = CGRectMake(0, 62, kScreenWidth, CGRectGetMaxY(RemarkView.frame)+54);
                }
                
            }
            headerView.backgroundColor = CD_BackGroundColor;
            headerView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(headerTempView.frame)+15);

        }
        
    }
    func lookFlightHouse(sender:UIButton!)
    {
        MobClick.event("Addnewhouse_click")
        if self.agentModel.clientInfoId == nil
        {
            return
        }
        if self.agentModel.clientPhone == ""
        {
            Utility .showToastWithMessage("录入手机号才能报备楼盘", _view: self.view)
        }
        
        else
        {
            var newHouseFlightV:HWFlightHouseViewController = HWFlightHouseViewController(clientInfoId: self.agentModel.clientInfoId!);
          
            newHouseFlightV.myFunc = { ()->Void in
                self .customerDetailrequest()
            

            
        }
        self.navigationController?.pushViewController(newHouseFlightV, animated: true);
            
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
    func lookSecondHouse(sender:UIButton!)
    {
         MobClick.event("AddSCDhouse_click")
        if self.agentModel.clientInfoId == nil
        {
            return
        }

        var relativeSecondV:HWRelativeSecondHouseViewController = HWRelativeSecondHouseViewController();
        relativeSecondV.clientInfoId = self.agentModel.clientInfoId!
        relativeSecondV.myFunc = { ()->Void in
            self .customerDetailrequest()
        }

        self.navigationController?.pushViewController(relativeSecondV, animated: true);
    }
    //MARK:-UITableViewDelegate方法
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if(tableView != priviledgeTableV)
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
                        
                    else if houseModel.showLook == "0"
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
            else if(houseModel.houseType == "secondhand") || houseModel.houseType == "secondHouse"
            {
                if(houseModel.appointStatus != "2" || houseModel.appointStatus != "1")
                {
                    if(houseModel.seletedStr == "0")
                    {
                        if (HWUserLogin .currentUserLogin().brokerId == houseModel.brokerId)
                        {
                             return 70;
                        }
                        return 190-45;
                        //add by gusheng
//                        return 70;
//                        //end by gusheng
                    }
                    else
                    {
                        if (HWUserLogin .currentUserLogin().brokerId == houseModel.brokerId)
                        {
                            return 235-60-75;
                        }
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
        else
        {
            return 0.0;
        }
        
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if(tableView != priviledgeTableV)
        {
              return 32.0;
        }
        else
        {
             if(agentModel.priviledgeArry.count > 1)
             {
                return 20.0;
            }
            else
             {
                return 0.0;
            }
            
        }
      
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(tableView != priviledgeTableV)
        {
            let houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(indexPath.section)as HWHouseInfoModel;
            let listModel = houseModel.followRecordArry .objectAtIndex(indexPath.row) as HWHouseListModel
            var size = Utility.calculateStringSize(listModel.content!, textFont:Define.font(13), constrainedSize: CGSizeMake(kScreenWidth-30, 1000))
            return size.height + 35;
        }
        else
        {
            return 40;
        }
       
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView != priviledgeTableV)
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
        else
        {
            if(agentModel.selectedStr == "0")
            {
                if(agentModel.priviledgeArry?.count >= 1)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
                
            }
            else
            {
                
                return agentModel.priviledgeArry.count;
            }
            
        }
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if(tableView != priviledgeTableV)
        {
            let houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(section)as HWHouseInfoModel;
            
            var footView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 32));
            footView.backgroundColor = CD_WhiteColor;
            var line = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 0.5))
            line.backgroundColor = CD_LineColor
            footView .addSubview(line)
            var line1 = UIImageView(frame: CGRectMake(0, 31.5, kScreenWidth, 0.5))
            line1.backgroundColor = CD_LineColor
            //footView .addSubview(line1)
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
             footView.userInteractionEnabled = true;
            return footView;
        }
        else
        {
            if(agentModel.priviledgeArry.count > 1)
            {
                var footView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 20));
                footView.backgroundColor = CD_WhiteColor;
                footView.userInteractionEnabled = true;
                var line = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 0.5))
                line.backgroundColor = CD_LineColor
                footView .addSubview(line)
                var line1 = UIImageView(frame: CGRectMake(0, 19.5, kScreenWidth, 0.5))
                line1.backgroundColor = CD_LineColor

                var recordBtnFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 20);
                var recordBtn:UIButton = createCustomeBtn(self ,"openPrivilidge:", recordBtnFrame,CD_Txt_Color_33, "", "");
                recordBtn.addTarget(self, action: "openPrivilidge:", forControlEvents: UIControlEvents.TouchUpInside);
                recordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                if(agentModel.selectedStr == "0")
                {
                     recordBtn.setTitle("展开", forState: UIControlState.Normal);
                }
                else
                {
                     recordBtn.setTitle("收起", forState: UIControlState.Normal);
                }
                recordBtn.setTitleColor(CD_Txt_Color_66, forState: UIControlState.Normal);
                recordBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_13);
                recordBtn.userInteractionEnabled = true;
                recordBtn.backgroundColor    = UIColor.clearColor();
                var arrowImageVFrame:CGRect = CGRectMake(kScreenWidth/2+15, 8, 15, 8);
                var arrowImageV:UIImageView = createCustomerImageView(arrowImageVFrame, "arrow_up");
                footView.addSubview(recordBtn);
                footView.addSubview(arrowImageV);
                
                if(agentModel.selectedStr == "0")
                {
                    arrowImageV.image = UIImage(named: "arrow_down");
                }
                else
                {
                    arrowImageV.image = UIImage(named: "arrow_up");
                }
                footView.backgroundColor = UIColor.clearColor();
                return footView;
            }
            else
            {
                return nil;
            }
            
        }
        
    }
    //MARK:-展开优惠劵
    func openPrivilidge(sender:UIButton)->Void
    {
        if(agentModel.selectedStr == "0")
        {
            agentModel.selectedStr = "1"
            self._customerTable.tableHeaderView = self.createHeaderView();
            priviledgeTableV.reloadData();
            self._customerTable .reloadData()
        }
        else
        {
            agentModel.selectedStr = "0"
            self._customerTable.tableHeaderView = self.createHeaderView();
            priviledgeTableV.reloadData();
            self._customerTable .reloadData()
        }
        
    }
    //MARK:-点击展开日程
    func scheduleClick(sender:UIButton)->Void
    {
       
        var houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(sender.tag)as HWHouseInfoModel;
        houseModel.followRecordArry .removeAllObjects()
        if(houseModel.seletedStr == "0")
        {
            Utility.showMBProgress(self.view, _message: "加载中");
            var param:NSMutableDictionary = NSMutableDictionary();
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
            param.setPObject(self.agentModel.clientInfoId, forKey: "clientInfoId")
            param.setPObject(houseModel.houseId, forKey: "houseId")
            if houseModel.houseType == "newHouse" || houseModel.houseType == "new"
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
       if(tableView != priviledgeTableV)
       {
        var houseViewTableHeader:UIView = createView(CGRectMake(0, 0, kScreenWidth, 215));
        houseViewTableHeader.backgroundColor = UIColor.whiteColor();
        var houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(section)as HWHouseInfoModel;
        if(houseModel.houseType == "newHouse" || houseModel.houseType == "new")
        {
            if(houseModel.seletedStr == "0")
            {
                if houseModel.currNode?.integerValue > 2 || houseModel.showLook == "0"
                {
                    houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 190-45);
                }
                else
                {
                    houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 190);
                }
            }
            else if houseModel.currNode?.integerValue > 2 || houseModel.showLook == "0"
                
            {
                houseViewTableHeader.frame = CGRectMake(0, 0, kScreenWidth, 235-45);
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
            //  houseViewTableHeader.addSubview(lineOneImageV);
            
            var lineTwoImageV:UIImageView = Utility.drawLine(CGPointMake(0, 9.5), width: kScreenWidth);
            houseViewTableHeader.addSubview(lineTwoImageV);
            
            //楼盘名称
            var houseTitleFrame:CGRect = CGRectMake(15, 12+10, 70, 15);
            var houseTitleLabel:UILabel = createCustomeLabel(houseTitleFrame, CD_Txt_Color_33, houseModel.houseName, TF_15);
            houseTitleLabel.sizeToFit();
            houseViewTableHeader.addSubview(houseTitleLabel);
            
            //区域
            var areaFrame:CGRect = CGRectMake(CGRectGetMaxX(houseTitleLabel.frame)+5, 12+10,kScreenWidth - CGRectGetMaxX(houseTitleLabel.frame)+5-15,22);
            var areaLabel:UILabel = createCustomeLabel(areaFrame, CD_Txt_Color_33, houseModel.houseAddress, TF_15);
            //areaLabel.backgroundColor = UIColor .redColor()
            //areaLabel.sizeToFit();
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
            
//            if houseModel.currNode == "0"
//            {
//                statusStr = "1"
//            }
//            if houseModel.currNode == "1"
//            {
//                statusStr = "2"
//            }
//            
//            if houseModel.currNode == "2"
//            {
//                statusStr = "3"
//            }
//            
//            if houseModel.currNode == "3"
//            {
//                statusStr = "4"
//            }
//            
//            if houseModel.currNode == "4"
//            {
//                statusStr = "5"
//            }
            let statusValueStr:NSString = houseModel.currNode as NSString!;
            let statusValue = statusValueStr.intValue;
            statusStr = "\(statusValue)";
            
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
            
            var protectLabelFrame:CGRect = CGRectMake(kScreenWidth-150-15, CGRectGetMaxY(secondHouseBtn.frame)+80, 150, 15);
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
            if houseModel.visitedProtectDays == ""
            {
                protectLabel.hidden = true
            }
            if houseModel.houseState == "fail"
            {
                protectLabel.text = "已过到访保护期"
                statusLabel.hidden = true
                
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
        else if(houseModel.houseType == "secondhand") || houseModel.houseType == "secondHouse"
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
            var houseTitleLabel:UILabel = createCustomeLabel(houseTitleFrame, CD_Txt_Color_33, houseModel.houseName, TF_15);
            houseTitleLabel.sizeToFit();
            houseViewTableHeader.addSubview(houseTitleLabel);
            
            //区域
            var areaFrame:CGRect = CGRectMake(CGRectGetMaxX(houseTitleLabel.frame)+5, 10+10, kScreenWidth - CGRectGetMaxX(houseTitleLabel.frame)+5-20,22);
            var areaLabel:UILabel = createCustomeLabel(areaFrame, CD_Txt_Color_33, houseModel.houseAddress, TF_15);
            // areaLabel.numberOfLines = 0
            // areaLabel.sizeToFit();
            //areaLabel.backgroundColor = UIColor.redColor()
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
            let priceStr = Utility .stringFrom(houseModel.houseTotalPrice) as NSString
            purposeStr = houseModel.houseFamilyType!+" \(houseModel.houseArea.integerValue)"+"㎡"+" \(priceStr)";//xiaohong
            purposeLabel.text = purposeStr;
            
            
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
                    
                    //                    //成交确认按钮
                    //
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
                    //                  //  houseViewTableHeader.addSubview(lookBtn);
                    //
                    //                    var lab:UILabel! = nil
                    //                    lab =  createCustomeLabel(lookBtnFrame, CD_MainColor, "已成交 2000万元", TF_13)
                    //                     houseViewTableHeader.addSubview(lab);
                    
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
                if HWUserLogin .currentUserLogin().brokerId == houseModel.brokerId
                {
                    lookBtn.hidden = true
                }
                else
                {
                    lookBtn.hidden = false
                }
                //                //成交确认按钮
                //                var confirmBtn:UIButton! = nil;
                //                var confirmBtnFrame:CGRect = CGRectMake(15, CGRectGetMaxY(lookBtn.frame)+10, kScreenWidth-2*15,35);
                //                confirmBtn = createCustomeBtn(self, "confirmBtnClick:", confirmBtnFrame, CD_RedLightColor, "跟进", "");
                //                confirmBtn.setTitle("成交确认", forState: UIControlState.Normal);
                //                confirmBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: TF_15);
                //                confirmBtn.layer.cornerRadius = 2.0;
                //                confirmBtn.layer.masksToBounds = true;
                //                confirmBtn.tag = section
                //                confirmBtn.layer.borderWidth = 1.0;
                //                confirmBtn.layer.borderColor = CD_GreenColor.CGColor;
                //                confirmBtn.setTitleColor(CD_GreenColor, forState: UIControlState.Normal);
                //                houseViewTableHeader.addSubview(confirmBtn);
                
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
                newScheduleBtn.tag = section + 200
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
        else
       {
                return nil;
       }
       
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
        let count:CGFloat = CGFloat(self.schduleArry.count);
        for(var j:CGFloat = 0;j < count; j++)
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
//            for(var k:CGFloat = 1;k < count+1;k++)
//            {
            
                scheduleLabel.text = "\(j+1)";
                let index:NSInteger = NSInteger(j)
                scheduleContentLabel.text = schduleArry.objectAtIndex(index) as NSString;
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
                    scheduleLabel.textColor = UIColor.clearColor();
                }

//            }
//            switch(j)
//            {
//                case 0:
//                    scheduleLabel.text = "1";
//                    scheduleContentLabel.text = "报备";
//                    if(scheduleLabel.text == status)
//                    {
//                        scheduleLabel.backgroundColor = CD_MainColor;
//                        scheduleLabel.textColor = UIColor.whiteColor();
//                        scheduleContentLabel.textColor = CD_MainColor;
//                        scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
//                    }
//                    else
//                    {
//                        scheduleLabel.backgroundColor = UIColor.whiteColor();
//                        scheduleLabel.textColor = UIColor.clearColor();
//                    }
//                    break;
//                case 1:
//                    scheduleLabel.text = "2";
//                    scheduleContentLabel.text = "到访";
//                    if(scheduleLabel.text == status)
//                    {
//                        scheduleLabel.backgroundColor = CD_MainColor;
//                        scheduleLabel.textColor = UIColor.whiteColor();
//                        scheduleContentLabel.textColor = CD_MainColor;
//                         scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
//                    }
//                    else
//                    {
//                        scheduleLabel.backgroundColor = UIColor.whiteColor();
//                        scheduleLabel.textColor = UIColor.clearColor();
//                    }
//
//                    break;
//                case 2:
//                    scheduleLabel.text = "3";
//                    scheduleContentLabel.text = "下定";
//                    if(scheduleLabel.text == status)
//                    {
//                        scheduleLabel.backgroundColor = CD_MainColor;
//                        scheduleLabel.textColor = UIColor.whiteColor();
//                        scheduleContentLabel.textColor = CD_MainColor;
//                         scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
//                    }
//                    else
//                    {
//                        scheduleLabel.backgroundColor = UIColor.whiteColor();
//                        scheduleLabel.textColor = UIColor.clearColor();
//                    }
//
//                    break;
//                case 3:
//                    scheduleLabel.text = "4";
//                    scheduleContentLabel.text = "成交";
//                    if(scheduleLabel.text == status)
//                    {
//                        scheduleLabel.backgroundColor = CD_MainColor;
//                        scheduleLabel.textColor = UIColor.whiteColor()
//                        scheduleContentLabel.textColor = CD_MainColor;
//                         scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
//                    }
//                    else
//                    {
//                        scheduleLabel.backgroundColor = UIColor.whiteColor();
//                        scheduleLabel.textColor = UIColor.clearColor();
//                    }
//
//                    break;
//                case 4:
//                    scheduleLabel.text = "5";
//                    scheduleContentLabel.text = "结佣";
//                    if(scheduleLabel.text == status)
//                    {
//                        scheduleLabel.backgroundColor = CD_MainColor;
//                        scheduleLabel.textColor = UIColor.whiteColor();
//                        scheduleContentLabel.textColor = CD_MainColor;
//                         scheduleLabel.layer.borderColor = CD_MainColor.CGColor;
//                    }
//                    else
//                    {
//                        scheduleLabel.backgroundColor = UIColor.whiteColor();
//                        scheduleLabel.textColor = UIColor.clearColor();
//                    }
//
//                    break;
//                default:break;
//            }
            //add by gusheng
            let statusLength = status.toInt();
            if(statusLength >= 2)
            {
                self.remarkStatus(status, houseTempView: houseTempView);
            }
            
        }
        
//        if(status == "2")
//        {
//            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
//            flightLabel.backgroundColor = CD_MainColor;
//            flightLabel.textColor = UIColor.whiteColor();
//             flightLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//
//        }
//        else if(status == "3")
//        {
//            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
//            flightLabel.backgroundColor = CD_MainColor;
//            flightLabel.textColor = UIColor.whiteColor();
//             flightLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//            var lookLabel:UILabel = houseTempView.viewWithTag(Int(801))as UILabel;
//            lookLabel.backgroundColor = CD_MainColor;
//            lookLabel.textColor = UIColor.whiteColor();
//             lookLabel.layer.borderColor = CD_MainColor.CGColor;
//
//        }
//        else if(status == "4")
//        {
//            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
//            flightLabel.backgroundColor = CD_MainColor;
//            flightLabel.textColor = UIColor.whiteColor();
//            flightLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//            var lookLabel:UILabel = houseTempView.viewWithTag(Int(801))as UILabel;
//            lookLabel.backgroundColor = CD_MainColor;
//            lookLabel.textColor = UIColor.whiteColor();
//            lookLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//            var orderLabel:UILabel = houseTempView.viewWithTag(Int(802))as UILabel;
//            orderLabel.backgroundColor = CD_MainColor;
//            orderLabel.textColor = UIColor.whiteColor();
//            orderLabel.layer.borderColor = CD_MainColor.CGColor;
//
//        }
//        else if(status == "5")
//        {
//            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800))as UILabel;
//            flightLabel.backgroundColor = CD_MainColor;
//            flightLabel.textColor = UIColor.whiteColor();
//            flightLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//            var lookLabel:UILabel = houseTempView.viewWithTag(Int(801))as UILabel;
//            lookLabel.backgroundColor = CD_MainColor;
//            lookLabel.textColor = UIColor.whiteColor();
//            lookLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//            var orderLabel:UILabel = houseTempView.viewWithTag(Int(802))as UILabel;
//            orderLabel.backgroundColor = CD_MainColor;
//            orderLabel.textColor = UIColor.whiteColor();
//            orderLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//            var tradeLabel:UILabel = houseTempView.viewWithTag(Int(803))as UILabel;
//            tradeLabel.backgroundColor = CD_MainColor;
//            tradeLabel.textColor = UIColor.whiteColor();
//            tradeLabel.layer.borderColor = CD_MainColor.CGColor;
//            
//
//        }
    }
    //标注状态
    func remarkStatus(status:NSString,houseTempView:UIView)->Void
    {
        let statusLength = status.intValue;
        for(var i:NSInteger = 0 ;i < (statusLength-2);i++)
        {
            var flightLabel:UILabel = houseTempView.viewWithTag(Int(800+i))as UILabel;
            flightLabel.backgroundColor = CD_MainColor;
            flightLabel.textColor = UIColor.whiteColor();
            flightLabel.layer.borderColor = CD_MainColor.CGColor;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(tableView != priviledgeTableV)
        {
            tableView.registerClass(HWCustomerDetailTableViewCell.self, forCellReuseIdentifier: "cellCustomerDetail")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellCustomerDetail", forIndexPath: indexPath) as HWCustomerDetailTableViewCell
            var houseInfoModel: HWHouseInfoModel = agentModel.houseTypeList.objectAtIndex(indexPath.section) as HWHouseInfoModel
            var listModel = houseInfoModel.followRecordArry .objectAtIndex(indexPath.row) as HWHouseListModel
            cell.didMakeModel(listModel)
            return cell;
        }
        else
        {
            tableView.registerClass(HWPrevilidgeTableViewCell.self, forCellReuseIdentifier: "HWPrevilidgeTableViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("HWPrevilidgeTableViewCell", forIndexPath: indexPath) as HWPrevilidgeTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            var  dic1:NSDictionary = self.agentModel.priviledgeArry?.objectAtIndex(indexPath.row) as NSDictionary
            let priviledgeModel = HWPriviledgeModel(dic: dic1);
            cell.floorNameLabel!.text = priviledgeModel.title+" | " + priviledgeModel.couponMoney + "元" + " | " + priviledgeModel.validityTime;
            return cell;

        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if(tableView != priviledgeTableV)
        {
            return self.agentModel.houseTypeList.count;
        }
        else
        {
            return 1;
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }

    //MARK:-创建手势
    func createGesture(view:UIView!,action:Selector)
    {
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: action);
        view.addGestureRecognizer(tapGesture);
        
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
//            println(responseObject)
          //  var status = responseObject("status") as NSString
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
//                println(code)
                
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
   

        func lookRequest()
        {
            
        }
        
    //MARK:点击新建日程
    func createSchedule(sender:UIButton!)
    {
        MobClick .event("Houseschedule_click")
        var houseModel:HWHouseInfoModel = self.agentModel.houseTypeList.objectAtIndex(sender.tag-200)as HWHouseInfoModel;
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
