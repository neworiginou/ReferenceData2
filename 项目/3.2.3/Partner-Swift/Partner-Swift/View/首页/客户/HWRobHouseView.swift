//
//  HWRobHouseView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/4/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWRobHouseViewDelegate
{
    func pushSuccessView2(dic:NSDictionary)
}

class HWRobHouseView: UIView,UIAlertViewDelegate,HWCustomAlertViewDelegate,MyScrollViewDelegate{

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
    
    var houseModel:HWRobHouseModel!
    var robOneHouseModel:HWRobOneHouseInfoModel!
    
    var isCountDownOver = false
    
    var delegate:HWRobHouseViewDelegate!
    
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
        ImgScrollView = MyScrollView(frame: CGRectMake(0,iPhone4 ?60 : 100,kScreenWidth, kScreenWidth/3),imgName:"big_character2")
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
        //nameLabel.text = "通河新村"
        
        intentionLabel = UILabel.newAutoLayoutView()
        intentionLabel.font = Define.font(TF_15)
        intentionLabel.textColor = CD_Txt_Color_00
        intentionLabel.numberOfLines = 0
        intentionLabel.backgroundColor = UIColor.clearColor()
        mainInfoView.addSubview(intentionLabel)
        intentionLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 15, 15, 15), excludingEdge: ALEdge.Top)
        intentionLabel.autoSetDimension(ALDimension.Height, toSize: 50)
        //intentionLabel.text = "房源参数：3室2厅｜1200万｜120平米"
        //intentionLabel.attributedText = self.setInfoLabeltext("房源参数：3室2厅｜1200万｜120平米")
        
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
        self.getRobHouseinfo()
    }
    
    func showEmptyView()
    {
        emptyView = HWEmptyControl(frame: CGRectMake(0, 40 * kScreenRate, kScreenWidth, contentHeight - 40 * kScreenRate), titleStr: "当前没有房源", imageName: "nothing", click: { () -> Void in
            self.getRobHouseinfo()
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

    
    //MyScrollViewDelegate
    func anotherOne() {
        println("切换下一个房源")
        houseModel = nil
        self.getRobHouseinfo()
    }
    
    func loadData()
    {
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetRobHouseViewInfo, parameters: param, queue: nil, success: { (responseObject) -> Void in
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
    func getRobHouseinfo()
    {
        self.houseModel = nil
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetRobHouseInfo, parameters: param, queue: nil, success: { (responseObject) -> Void in
            //Utility.hideMBProgress(self);
            var resultDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary;
            
            self.houseModel = HWRobHouseModel(dic: resultDic)
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
        nameLabel.text = houseModel.villageName
        intentionLabel.attributedText = self.setInfoLabeltext(houseModel.infoText)
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
    
    //MARK:robBtnAction
    func robAction()
    {
        if (houseModel == nil)
        {
            return
        }
        isCountDownOver = false
        self.robHouseRequest()
    }
    
    
    
    
    //MARK:抢房相关
    
    //MARK:-抢房请求
    func robHouseRequest()->Void
    {
        MobClick.event("Takeclients-star_click");
        Utility.showMBProgress(self, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(houseModel.housePoolId, forKey: "housePoolId")
        param.setPObject(houseModel.version, forKey: "version")
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kRobOneHouse, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self);
            var dataDic:NSDictionary =  responseObject.objectForKey("data") as NSDictionary;
            
            self.robOneHouseModel = HWRobOneHouseInfoModel(dic: dataDic)
            var intentionStr:String = NSMutableString();
            
            var isLimit = dataDic.stringObjectForKey("isLimit")
            if(self.robOneHouseModel.isLimit == "yes")
            {
                Utility.showToastWithMessage("已达抢房上限", _view: self);
            }
            else
            {
                var timerStr:NSString = self.robOneHouseModel.countdown;
                var timerInt:Int = timerStr.integerValue * 60;
//                var robDic:NSMutableDictionary = NSMutableDictionary(object: intentionStr, forKey: "intention");
//                robDic .setObject("\(timerInt)", forKey: "timer");
                var robDic = NSMutableDictionary(object: self.robOneHouseModel.integral, forKey: "score")
                robDic.setObject("\(timerInt)", forKey: "timer")
                robDic.setObject("绑定抢到房源",forKey:"titleText")
                self.popUnlockAler(robDic);
                print("抢房");
                
            }
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self);
                self.getRobHouseinfo()
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
        
        var alertTip:HWCustomAlertView = HWCustomAlertView(type: AlertViewType.BindingCustomer, alertText: self.robOneHouseModel.integral)
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
            self.getRobHouseinfo()
        }
        
    }
    //MARK:-放弃抢房请求
    func giveUpRobCustomerRequest()->Void
    {
        Utility.showMBProgress(self, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(self.robOneHouseModel.housesRobRecordId, forKey: "houseRobRecordId");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGiveUpRobHouse, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self);
            print("放弃解锁");
            
            //放弃后重新请求一个抢房房源
            self.getRobHouseinfo()
            self.loadData()
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.getRobHouseinfo()
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
        param.setPObject(self.robOneHouseModel.housesRobRecordId, forKey: "houseRobRecordId");
        param.setPObject(self.robOneHouseModel.integral, forKey: "integral");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kUnlockOneHouse, parameters: param, queue: nil, success: { (responseObject) -> Void in
            MobClick.event("Takeclients-OK");
            let resDic = responseObject.objectForKey("data")as NSDictionary;
            
            
            Utility.hideMBProgress(self)
            
            self.delegate.pushSuccessView2(resDic)
            //解锁成功后重新加载新的被抢对象 重新刷新顶部底部Label数据
            self.getRobHouseinfo()
            self.loadData()
            
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self);
                Utility.showToastWithMessage(error, _view: self);
                
                self.getRobHouseinfo()
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
