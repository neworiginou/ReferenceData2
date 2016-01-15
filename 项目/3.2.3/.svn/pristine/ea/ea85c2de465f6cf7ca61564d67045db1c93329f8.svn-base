//
//  HWRobCustomerView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/4/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWRobCustomerViewDelegate
{
    func pushRobSuccessVC(dic:NSMutableDictionary)
}

class HWRobCustomerView: UIView ,HWCustomAlertViewDelegate,MyScrollViewDelegate{

    var topInfoLabel:UILabel!
    //var ImgScrollView:UIView!
    var ImgScrollView:MyScrollView!
    
    var mainInfoView:UIImageView!
    var nameLabel:UILabel!
    //var sourceLabel:UILabel!
    var intentionLabel:UILabel!
    var emptyView:HWEmptyControl!
    
    var robBtn:UIButton!
    var bottomInfoLabel:UILabel!
    
    var customerModel:HWRobCustomerModel!
    var robOneCustomerModel:HWRobOneCustomerInfoModel!
    
    var isCountDownOver = false
    
    var delegate:HWRobCustomerViewDelegate!
    
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = CD_BackGroundColor
        
        self.loadUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "countDownOver", name: "countdownover", object: nil)
    }
    
    func countDownOver()
    {
        isCountDownOver = true
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "countdownover", object: nil)
    }

    func loadUI()
    {
        //topView
        topInfoLabel = UILabel.newAutoLayoutView()
        topInfoLabel.backgroundColor = CD_LineColor
        topInfoLabel.textAlignment = NSTextAlignment.Center
        topInfoLabel.font = Define.font(15)
        topInfoLabel.textColor = CD_Txt_Color_00
        self.addSubview(topInfoLabel)
        topInfoLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
        topInfoLabel.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
        topInfoLabel.attributedText = self.loadTopInfoLabelData("0", num2: "0")
        
        //ImgScrollView
        ImgScrollView = MyScrollView(frame: CGRectMake(0,iPhone4 ?60 : 100,kScreenWidth, kScreenWidth/3),imgName:"big_character")
        ImgScrollView.myDelegate = self
        self.addSubview(ImgScrollView)
        ImgScrollView.scrollViewLoadData()
        
        //抢的对象详情
        mainInfoView = UIImageView.newAutoLayoutView()
        mainInfoView.backgroundColor = UIColor.clearColor()
        mainInfoView.image = UIImage(named: "description_background")
        self.addSubview(mainInfoView)
        mainInfoView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: ImgScrollView, withOffset: 20 * kScreenRate)
        mainInfoView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: ImgScrollView)
        mainInfoView.autoSetDimension(ALDimension.Height, toSize: 115)
        mainInfoView.autoSetDimension(ALDimension.Width, toSize: 245)
        
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textColor = CD_Txt_Color_00
        nameLabel.font = Define.font(TF_16)
        mainInfoView.addSubview(nameLabel)
        nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: mainInfoView, withOffset: 25)
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: mainInfoView, withOffset: 15)
        nameLabel.autoSetDimension(ALDimension.Height, toSize: 18)
        //nameLabel.text = "张某国"
        
        //        sourceLabel = UILabel.newAutoLayoutView()
        //        sourceLabel.backgroundColor = CD_OrangeColor
        //        sourceLabel.textColor = UIColor.whiteColor()
        //        sourceLabel.font = Define.font(TF_13)
        //        sourceLabel.text = "租售中心"
        //        sourceLabel.textAlignment = NSTextAlignment.Center
        //        sourceLabel.layer.cornerRadius = 10
        //        sourceLabel.layer.masksToBounds = true
        //        mainInfoView.addSubview(sourceLabel)
        //        sourceLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: nameLabel, withOffset: 10)
        //        sourceLabel.autoSetDimension(ALDimension.Width, toSize: 65)
        //        sourceLabel.autoSetDimension(ALDimension.Height, toSize: 20)
        //        sourceLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: nameLabel)
        
        intentionLabel = UILabel.newAutoLayoutView()
        intentionLabel.font = Define.font(TF_15)
        intentionLabel.textColor = CD_Txt_Color_00
        intentionLabel.numberOfLines = 0
        intentionLabel.backgroundColor = UIColor.clearColor()
        mainInfoView.addSubview(intentionLabel)
        intentionLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 15, 15, 15), excludingEdge: ALEdge.Top)
        intentionLabel.autoSetDimension(ALDimension.Height, toSize: 50)
        //intentionLabel.text = "意向：宝山、闵行｜三室二厅｜100～200万｜80～120平米"
        //intentionLabel.attributedText = self.setInfoLabeltext("意向：宝山、闵行｜三室二厅｜100～200万｜80～120平米")
        
        
        //抢Btn
        robBtn = UIButton.newAutoLayoutView()
        robBtn.backgroundColor = CD_MainColor
        robBtn.setTitle("抢", forState: UIControlState.Normal)
        robBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        robBtn.titleLabel?.font = Define.font(TF_19)
        robBtn.layer.cornerRadius = 3
        robBtn.layer.masksToBounds = true
        self.addSubview(robBtn)
        robBtn.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self, withOffset: 15)
        robBtn.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self, withOffset: -15)
        robBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: intentionLabel, withOffset: 40)
        robBtn.autoSetDimension(ALDimension.Height, toSize: 45 * kScreenRate)
        robBtn.addTarget(self, action: "robAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        bottomInfoLabel = UILabel.newAutoLayoutView()
        bottomInfoLabel.backgroundColor = UIColor.clearColor()
        bottomInfoLabel.textColor = CD_Txt_Color_00
        bottomInfoLabel.font = Define.font(TF_13)
        bottomInfoLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(bottomInfoLabel)
        bottomInfoLabel.autoSetDimension(ALDimension.Width, toSize: kScreenWidth)
        bottomInfoLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self, withOffset: -15)
        bottomInfoLabel.autoSetDimension(ALDimension.Height, toSize: 13)
        bottomInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: robBtn, withOffset: 20 * kScreenRate)
        self.loadBottomInfoLableData("0", num2: "0")
        
        self.loadData()
        self.getRobCustomerInfo()
    }
    
    func showEmptyView()
    {
        emptyView = HWEmptyControl(frame: CGRectMake(0, 40 * kScreenRate, kScreenWidth, contentHeight - 40 * kScreenRate), titleStr: "当前没有客户", imageName: "nothing", click: { () -> Void in
            self.getRobCustomerInfo()
        })
        emptyView.backgroundColor = CD_BackGroundColor
        self.addSubview(emptyView)
    }
    
    func hideEmptyView() -> Void
    {
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
    }

    
    func anotherOne() {
        println("切换下一个房源")
        customerModel = nil
        self.getRobCustomerInfo()
    }
    
    func loadData()
    {
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetRobCustomerViewInfo, parameters: param, queue: nil, success: { (responseObject) -> Void in
            //Utility.hideMBProgress(self);
            var resultDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary;
            //设置顶部label数据
            var releaseNum = resultDic.stringObjectForKey("releaseNum")
            var remainingNum = resultDic.stringObjectForKey("remainingNum")
            self.topInfoLabel.attributedText = self.loadTopInfoLabelData(releaseNum, num2: remainingNum)
            
            //设置底部label数据
            var hisRobNum = resultDic.stringObjectForKey("hisRobNum")
            var myRobNum = resultDic.stringObjectForKey("myRobNum")
            self.loadBottomInfoLableData(hisRobNum, num2: myRobNum)
            
            })
            { (code, error) -> Void in
                //Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view:self);
        }
    }
    //MARK:请求抢房房源数据
    func getRobCustomerInfo()
    {
        self.customerModel = nil
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetRobCustomerInfo2, parameters: param, queue: nil, success: { (responseObject) -> Void in
            //Utility.hideMBProgress(self);
            var resultDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary;
            
            self.customerModel = HWRobCustomerModel(dic: resultDic)
            self.hideEmptyView()
            self.loadMainInfoViewData()
            
            })
            { (code, error) -> Void in
                //Utility.hideMBProgress(self)
                //Utility.showToastWithMessage(error, _view:self);
                //MYP add 显示没有数据
                if self.emptyView == nil
                {
                    self.showEmptyView()
                }
        }
    }
    
    //显示抢房房源信息
    func loadMainInfoViewData()
    {
        nameLabel.text = customerModel.clientName
        intentionLabel.attributedText = self.setInfoLabeltext(customerModel.infoText)
    }
    
    //设置底部label信息
    func loadBottomInfoLableData(num1:NSString, num2:NSString)
    {
        var subStr1:NSString = ""
        var subStr2:NSString = ""
        if(num1.isEqualToString("") || num1.isEqualToString("0"))
        {
            subStr1 = "0"
            subStr2 = "0"
        }
        if(num2.isEqualToString(""))
        {
            subStr2 = "0"
        }
        bottomInfoLabel.text = "历史被抢：\(num1) 我抢到：\(num2)"
    }
    
    //设置顶部label信息
    func loadTopInfoLabelData(num1:NSString, num2:NSString) ->NSMutableAttributedString
    {
        var subStr1:NSString = ""
        var subStr2:NSString = ""
        
//        if(num1.isEqualToString("") || num1.isEqualToString("0"))
//        {
//            subStr1 = "0"
//            subStr2 = "0"
//        }
//        else if(num2.isEqualToString(""))
//        {
//            subStr2 = "0"
//        }
//        else
//        {
//            subStr1 = num1
//            subStr2 = num2
//        }
        
        if num1.isEqualToString("")
        {
            subStr1 = "0"
        }
        else
        {
            subStr1 = num1
        }
        
        if num2.isEqualToString("")
        {
            subStr2 = "0"
        }
        else
        {
            subStr2 = num2
        }
        
        var attri = NSMutableAttributedString(string:"今日释放 \(subStr1) 个 剩 \(subStr2) 个")
        attri.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: NSMakeRange(5, subStr1.length))
        attri.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: NSMakeRange(4 + subStr1.length + 6, subStr2.length))
        return attri
    }
    
    //MARK:抢客相关
    
    func robAction()
    {
        if (customerModel == nil)
        {
            return
        }
        self.robCustomerRequest()
    }
    
    //MARK:-抢客请求
    func robCustomerRequest()->Void
    {
        MobClick.event("Takeclients-star_click");
        Utility.showMBProgress(self, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(customerModel.clientPoolId, forKey: "clientPoolId")
        param.setPObject(customerModel.version, forKey: "version")
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kRobOneCustomer, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self);
            var dataDic:NSDictionary =  responseObject.objectForKey("data") as NSDictionary;
            self.robOneCustomerModel = HWRobOneCustomerInfoModel(dic: dataDic)
            var intentionStr:String = NSMutableString();
            
            var isLimit = dataDic.stringObjectForKey("isLimit")
            if(self.robOneCustomerModel.isLimit == "yes")
            {
                Utility.showToastWithMessage("已达抢客上限", _view: self);
            }
            else
            {
                var timerStr:NSString = self.robOneCustomerModel.countdown;
                var timerInt:Int = timerStr.integerValue * 60;
//                var robDic:NSMutableDictionary = NSMutableDictionary(object: intentionStr, forKey: "intention");
//                robDic .setObject("\(timerInt)", forKey: "timer");
                var robDic = NSMutableDictionary(object: self.robOneCustomerModel.integral, forKey: "score")
                robDic.setObject("\(timerInt)", forKey: "timer")
                robDic.setObject("绑定抢到客户",forKey:"titleText")
                self.popUnlockAler(robDic);
                print("抢客");
            }
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self);
                self.getRobCustomerInfo()
                self.loadData()
        }
    }
    //MARK:--弹出解锁的Alert
    func popUnlockAler(dic:NSMutableDictionary)->Void
    {
        var alert:HWCustomAlertView = HWCustomAlertView(type: AlertViewType.CustomerUnlock, infoDic: dic);
        shareAppDelegate.window?.addSubview(alert)
        alert.delegate = self;
        alert.tag = 100;
        alert.showAnimate();
    }

    //MARK:--弹出积分确认Alert
    func popConfirmAler()->Void
    {
        
        var alertTip:HWCustomAlertView = HWCustomAlertView(type: AlertViewType.BindingCustomer, alertText: self.robOneCustomerModel.integral)
        shareAppDelegate.window?.addSubview(alertTip)
        alertTip.delegate = self;
        alertTip.tag = 100;
        alertTip.showAnimate();
    }

    
    //HWCustomerAlertViewDelegate
    func didSelectdConfirm() -> Void
    {
        self.popConfirmAler();
    }
    func unlock()
    {
        self.unclockRequest();
    }
    func giveUp()
    {
        //倒计时结束不发放弃请求
        if isCountDownOver == false
        {
            self.giveUpRobCustomerRequest();
        }
        else
        {
            self.getRobCustomerInfo()
        }
    }
    //MARK:-放弃抢客请求
    func giveUpRobCustomerRequest()->Void
    {
        Utility.showMBProgress(self, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(self.robOneCustomerModel.clientRobRecordId, forKey: "clientRobRecordId");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGiveUpRobCustomer, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self);
            print("放弃解锁");
            
            //放弃后重新请求一个抢房房源
            self.getRobCustomerInfo()
            self.loadData()
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.getRobCustomerInfo()
                self.loadData()
        }
    }
    //解锁请求
    func unclockRequest()->Void
    {
        MobClick.event("Takeclients-unlock_click");
        Utility.showMBProgress(self, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(self.robOneCustomerModel.clientRobRecordId, forKey: "clientRobRecordId");
        param.setPObject(self.robOneCustomerModel.integral, forKey: "integral");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kUnlockOneCustomer, parameters: param, queue: nil, success: { (responseObject) -> Void in
            MobClick.event("Takeclients-OK");
            let resDic = responseObject.objectForKey("data")as NSMutableDictionary;
            
            self.delegate.pushRobSuccessVC(resDic)
            
            //MYP add ??
            
            Utility.hideMBProgress(self)
            //积分解锁成功后获取新的被抢对象 刷新顶部底部Label数据
            self.getRobCustomerInfo()
            self.loadData()
            
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self);
                Utility.showToastWithMessage(error, _view: self);
                
                self.getRobCustomerInfo()
                self.loadData()
                
                print("积分解锁");
                
        }
        
    }

    func setInfoLabeltext(str:NSString) -> NSMutableAttributedString
    {
        var attriStr = NSMutableAttributedString(string: str)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attriStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.length))
        return attriStr
    }
    
    required init(coder aDecoder: NSCoder) {
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
