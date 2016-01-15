//
//  HWRobCustomerViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
class HWRobCustomerViewController: HWBaseViewController,UIAlertViewDelegate,HWCustomAlertViewDelegate
{
    let kleft:CGFloat = 15;
    var historyRobTitleContentLabel:UILabel!;//历史被抢数
    var myRobCustomerNumLabel:UILabel!;//我抢到客户数
    var todayReleaseCustomerNumLabel:UILabel!;//今日释放客户数
    var leaveCustomerNumLabel:UILabel!;//剩余客户数
    
    var robInfoModel:HWRobbedCustomerInfoModel!;
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("抢客");
        self.view.backgroundColor = "#fff7e0".UIColor;
        self.createMainView();
        self.getRobCustomerInfoRequest();
    }
    //remark:解决导航bar隐藏，以及返回主页闪动的BUG
    override func backMethod() -> Void
    {
        self.navigationController?.popViewControllerAnimated(false);
        
    }
    //end
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        self.view.backgroundColor = "#fff7e0".UIColor;
        self.navigationController?.navigationBarHidden = false
        
    }
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBarHidden = true;
    }
    
    func createMainView()->Void
    {
        var historyRobTitleLabelFrame:CGRect = CGRectMake(kleft,11,56,20);
        var historyRobTitleLbaelColorColor:UIColor = CD_Txt_Color_33;
        var historyRobTitleLabel:UILabel = createCustomeLabel(historyRobTitleLabelFrame, historyRobTitleLbaelColorColor,"历史被抢:",TF_13);
        self.view.addSubview(historyRobTitleLabel);
        
        
        var historyRobTitleContentLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(historyRobTitleLabel.frame)+5,11,100,20);
        var historyRobTitleContentLabelColorColor:UIColor = CD_Txt_Color_33;
        historyRobTitleContentLabel = createCustomeLabel(historyRobTitleContentLabelFrame, historyRobTitleContentLabelColorColor,"",TF_13);
        self.view.addSubview(historyRobTitleContentLabel);
        
        var myRobCustomerFrame:CGRect = CGRectMake(kScreenWidth-170*0.85-170*0.85*(kScreenRate-1),11,45,20);
        var myRobCustomerColor:UIColor = CD_Txt_Color_33;
        var myRobCustomerLabel:UILabel = createCustomeLabel(myRobCustomerFrame, myRobCustomerColor,"我抢到:",TF_13);
        self.view.addSubview(myRobCustomerLabel);
        
        
        var myRobCustomerNumFrame:CGRect = CGRectMake(CGRectGetMaxX(myRobCustomerLabel.frame),11,100,20);
        var myRobCustomerNumColor:UIColor = CD_Txt_Color_33;
        myRobCustomerNumLabel = createCustomeLabel(myRobCustomerNumFrame, myRobCustomerNumColor,"",TF_13);
        self.view.addSubview(myRobCustomerNumLabel);
        //光芒图片
        var rayImageVFrame:CGRect = CGRectMake(0,CGRectGetMaxY(myRobCustomerNumFrame)+50,kScreenWidth,390);
        var rayImageV:UIImageView = createCustomerImageView(rayImageVFrame,"panicroom_bg");
        var rotationAnimation:CABasicAnimation = rotation(2, 3.1415926*0.2, 1.0, MAXFLOAT);
        rayImageV.layer.addAnimation(rotationAnimation, forKey: nil);
        self.view.addSubview(rayImageV);
        
        
        //创建抢的按钮
        var robBtnFrame:CGRect = CGRectMake(0,CGRectGetMaxY(myRobCustomerNumFrame)+50,162*(1/kScreenRate),162*(1/kScreenRate));
        var robBtn:UIButton = createCustomeBtn(self, "robCustomer", robBtnFrame,nil, "","panicroom_icon2");
        robBtn.center = rayImageV.center;
        self.view.addSubview(robBtn);
        
        //左边得三颗星星
        var leftStarFrame:CGRect = CGRectMake(robBtn.frame.origin.x-65,robBtn.frame.origin.y-10,60,80);
        var leftSatrImageV = createCustomerImageView(leftStarFrame, "panicroom_star2");
        self.view.addSubview(leftSatrImageV);
        //右边的两颗星星
        var rightStarFrame:CGRect = CGRectMake(CGRectGetMaxX(robBtn.frame)+20,robBtn.center.y,28,54);
        var rightStarImageV = createCustomerImageView(rightStarFrame, "panicroom_star1");
        self.view.addSubview(rightStarImageV);
        
        //今日释放客户数
        var todayReleaseCustomerNumFrame:CGRect = CGRectMake(0,CGRectGetMaxY(myRobCustomerNumLabel.frame)+50,kScreenWidth,30);
        var todayReleaseCustomerNumColor:UIColor = CD_Txt_Color_33;
        todayReleaseCustomerNumLabel = createCustomeLabel(todayReleaseCustomerNumFrame, todayReleaseCustomerNumColor,"",TF_13);
        todayReleaseCustomerNumLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(todayReleaseCustomerNumLabel);
        
        //剩余客户数
        var leaveCustomerNumLabelFrame:CGRect = CGRectMake(0,CGRectGetMaxY(todayReleaseCustomerNumLabel.frame)+15,kScreenWidth,30);
        var leaveCustomerNumLabelColor = CD_Txt_Color_33;
        leaveCustomerNumLabel = createCustomeLabel(leaveCustomerNumLabelFrame, todayReleaseCustomerNumColor,"",TF_13);
         leaveCustomerNumLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(leaveCustomerNumLabel);
    }
    //MARK-:获取抢客信息
    func getRobCustomerInfoRequest()->Void
    {
        Utility.showMBProgress(self.view, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetRobCustomerInfo, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view);
            var resultDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary;
            var resultRobModel:HWRobCustomerInfoModel = HWRobCustomerInfoModel(dic: resultDic);
            self.refershUI(resultRobModel);
            })
            { (code, error) -> Void in
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view);
        }
    }
    func createTestData()->HWRobCustomerInfoModel
    {
        var robInfo: HWRobCustomerInfoModel = HWRobCustomerInfoModel();
        /*
        {
        "detail": "请求数据成功!",
        "status": "1",
        "data": {
        "hisRobNum":"" -历史被抢数
        "myRobNum":"" -我抢到数
        "releaseNum":"" -今日释放数（根据经纪人城市id筛选）
        "remainingNum":"" -剩余数
        }];
        }
        }
        */
        robInfo.hisRobNum = "20000";
        robInfo.myRobNum = "230";
        robInfo.releaseNum = "100";
        robInfo.remainingNum = "450";
        return robInfo;
    }
    func refershUI(robModel:HWRobCustomerInfoModel)->Void
    {
            var releaseCustomerStr:String = "今日释放"+robModel.releaseNum+"个客户";
            //赋值今日释放客户数
            self.settingTodayCustomerNum(releaseCustomerStr,length:countElements(robModel.releaseNum));
            var remainCustomerStr:String = "剩"+robModel.remainingNum+"个客户";
            //赋值剩余客户数
            self.settingLeftCustomerNum(remainCustomerStr,length:countElements(robModel.remainingNum));
            historyRobTitleContentLabel.text = robModel.hisRobNum;
            myRobCustomerNumLabel.text = robModel.myRobNum;
            
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //赋值今日释放客户数
    func settingTodayCustomerNum(customerNum:String,length:Int)->Void
    {
        let originX = 4
        let length = length;
        var range:NSRange = NSMakeRange(originX, length);
        var rangeLeft:NSRange = NSMakeRange(0, countElements(customerNum));
        var todayReleaseCustomerStr:NSMutableAttributedString = NSMutableAttributedString(string: customerNum);
        todayReleaseCustomerStr.beginEditing();
        todayReleaseCustomerStr.addAttribute(NSFontAttributeName, value: Define.font(TF_16), range: rangeLeft);
        todayReleaseCustomerStr.addAttribute(NSFontAttributeName, value: Define.font(TF_40), range: range);
        todayReleaseCustomerStr.addAttribute(NSForegroundColorAttributeName, value: CD_OrangeRobColor, range: range);
        todayReleaseCustomerNumLabel.attributedText = todayReleaseCustomerStr;
        todayReleaseCustomerStr.endEditing();
    }
    //赋值剩余客户数
    func settingLeftCustomerNum(customerNum:String,length:Int)->Void
    {
        let originX = 1;
        let length = length;
        var range:NSRange = NSMakeRange(originX, length);
        var rangeLeft:NSRange = NSMakeRange(0, countElements(customerNum));
        var todayReleaseCustomerStr:NSMutableAttributedString = NSMutableAttributedString(string: customerNum);
        todayReleaseCustomerStr.addAttribute(NSFontAttributeName, value: Define.font(TF_16), range: rangeLeft);
        todayReleaseCustomerStr.addAttribute(NSFontAttributeName, value: Define.font(TF_40), range: range);
        todayReleaseCustomerStr.addAttribute(NSForegroundColorAttributeName, value: CD_OrangeRobColor, range: range);
        leaveCustomerNumLabel.attributedText = todayReleaseCustomerStr;
    }
    //抢客
    func robCustomer()->Void
    {
        self.robCustomerRequest();
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
        
        var alertTip:HWCustomAlertView = HWCustomAlertView(type: AlertViewType.BindingCustomer, alertText: self.robInfoModel.integral)
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
        self.giveUpRobCustomerRequest();

    }
    //MARK:-放弃抢客请求
    func giveUpRobCustomerRequest()->Void
    {
        Utility.showMBProgress(self.view, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(self.robInfoModel.recordId, forKey: "clientRobRecordId");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(KGiveUpRob, parameters: param, queue: nil, success: { (responseObject) -> Void in
        Utility.hideMBProgress(self.view);
        print("放弃解锁");
                
                }) { (code, error) -> Void in
      
        Utility.hideMBProgress(self.view)
            }
    }
    //解锁请求
    func unclockRequest()->Void
    {
        MobClick.event("Takeclients-unlock_click");
        Utility.showMBProgress(self.view, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(self.robInfoModel.recordId, forKey: "clientRobRecordId");
        param.setPObject(self.robInfoModel.integral, forKey: "integral");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kUnlockCustomer, parameters: param, queue: nil, success: { (responseObject) -> Void in
            MobClick.event("Takeclients-OK");
            let dic:NSDictionary = responseObject.objectForKey("data")as NSDictionary;
            let clientId = dic.stringObjectForKey("clientInfoId");
            let protectDayS = dic.stringObjectForKey("protectDays");
            let robSucessV:HWRobSucessViewController = HWRobSucessViewController();
            robSucessV.robClientId = clientId;
            robSucessV.sourceStr = "1"
            robSucessV.protectDays = protectDayS;
            self.navigationController?.pushViewController(robSucessV, animated:false);
            Utility.hideMBProgress(self.view)
            
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self.view);
                Utility.showToastWithMessage(error, _view: self.view);
                print("积分解锁");
                }
    }
    //MARK:-抢客请求
    func robCustomerRequest()->Void
    {
            MobClick.event("Takeclients-star_click");
            Utility.showMBProgress(self.view, _message: "加载中");
            var param:NSMutableDictionary = NSMutableDictionary();
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
            let manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kRobCustomer, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view);
            var dataDic:NSDictionary =  responseObject.objectForKey("data") as NSDictionary;
            self.robInfoModel = HWRobbedCustomerInfoModel(dic: dataDic)
            var intentionStr:String = NSMutableString();
            if(self.robInfoModel.intentionHousePrice == "")
            {
                
            }
            else
            {
                intentionStr = intentionStr + self.robInfoModel.intentionHousePrice + "万|";
            }
                
            if(self.robInfoModel.intentionHouseSize == "")
            {
                
            }
            else
            {
                intentionStr = intentionStr + self.robInfoModel.intentionHouseSize + "|"
            }
            if(self.robInfoModel.intentionHouseType == "")
            {
                
            }
            else
            {
                intentionStr = intentionStr + self.robInfoModel.intentionHouseType;
            }
            if(self.robInfoModel.isLimit == "yes")
            {
                Utility.showToastWithMessage("已达抢客上限", _view: self.view);
            }
            else
            {
                var timerStr:NSString = self.robInfoModel.countdown;
                var timerInt:Int = timerStr.integerValue * 60;
                var robDic:NSMutableDictionary = NSMutableDictionary(object: intentionStr, forKey: "intention");
                robDic .setObject("\(timerInt)", forKey: "timer");
                self.popUnlockAler(robDic);
                print("抢客");

            }
            }) { (code, error) -> Void in
        Utility.hideMBProgress(self.view)
                }
    }

}
//MARK:==旋转动画=
func rotation(dur:Double,degree:CGFloat,direction:CGFloat,repeateCount:Float)->CABasicAnimation
{
    var rotationTransform:CATransform3D = CATransform3DMakeRotation(degree, 0, 0, direction);
    var animation:CABasicAnimation = CABasicAnimation();
    var animationValue:NSValue = NSValue(CATransform3D: rotationTransform);
    animation.keyPath = "transform";
    
    animation.toValue = animationValue;
    animation.duration = dur;
    animation.autoreverses = false;
    animation.cumulative = true;
    animation.repeatCount = repeateCount;
    return animation;
    
    
}
//MARK:创建通用按钮方法
func createCustomeBtn(sender:AnyObject,actionName:Selector,generalFrame:CGRect,titleColor:UIColor?,titleContent:String,imageName:String)->UIButton
{
    var frame:CGRect = CGRectMake(generalFrame.origin.x, generalFrame.origin.y, generalFrame.size.width, generalFrame.size.height);
    var customeBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
    customeBtn.frame = frame;
    customeBtn.titleLabel?.textColor = titleColor;
    customeBtn.titleLabel?.text = titleContent;
     var tempImage:UIImage? = UIImage(named:imageName);
    customeBtn.setImage(tempImage, forState: UIControlState.Normal);
    customeBtn.backgroundColor = UIColor.clearColor();
    customeBtn.addTarget(sender, action:actionName, forControlEvents:UIControlEvents.TouchUpInside)
    return customeBtn;
}
//MARK:-创建通用Label方法
func createCustomeLabel(generalFrame:CGRect,labelColor:UIColor,labelContent:String?,generalFont:CGFloat)->UILabel
{
    var customeLabel = UILabel();
    var frame:CGRect = CGRectMake(generalFrame.origin.x, generalFrame.origin.y, generalFrame.size.width, generalFrame.size.height);
    customeLabel.text = labelContent;
    customeLabel.textAlignment = NSTextAlignment.Left;
    customeLabel.frame = frame;
    customeLabel.textColor = labelColor;
    customeLabel.font? = Define.font(generalFont);
    customeLabel.backgroundColor = UIColor.clearColor();
    return customeLabel;
}
//MARK:-返回实际label的尺寸--横向
func returnLabelFactualSize(caculationLabel:UILabel,fontSize:CGFloat)->CGRect
{
    caculationLabel.numberOfLines = 0;
    caculationLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping;
    caculationLabel.textAlignment = NSTextAlignment.Left;
    var textLabelFrame:CGRect = caculationLabel.frame;
    var labelSize:CGSize = Utility.calculateStringSize(caculationLabel.text!, textFont: Define.font(fontSize), constrainedSize: CGSizeMake(CGFloat(MAXFLOAT),caculationLabel.frame.size.height));
    textLabelFrame.size.width = labelSize.width;
    return textLabelFrame;
    
}
//MARK:-返回实际label的尺寸--纵向
func returnLabelVerticalFactualSize(caculationLabel:UILabel,fontSize:CGFloat)->CGRect
{
    caculationLabel.numberOfLines = 0;
    caculationLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping;
    caculationLabel.textAlignment = NSTextAlignment.Center;
    var textLabelFrame:CGRect = caculationLabel.frame;
    caculationLabel.frame = textLabelFrame;
    var labelSize:CGSize = Utility.calculateStringSize(caculationLabel.text!, textFont: Define.font(fontSize), constrainedSize: CGSizeMake(caculationLabel.frame.size.width, CGFloat(MAXFLOAT)));
    textLabelFrame.size.width = labelSize.width;
    return textLabelFrame;
}
//MARK:-创建通用的UIImageView方法
func createCustomerImageView(generalFrame:CGRect,imageContent:String)->UIImageView
{
    var generalImageV = UIImageView();
    var frame:CGRect = CGRectMake(generalFrame.origin.x, generalFrame.origin.y, generalFrame.size.width, generalFrame.size.height);
    generalImageV.frame = frame;
    var tempImage:UIImage? = UIImage(named:imageContent);
    generalImageV.image = tempImage;
    generalImageV.backgroundColor = UIColor.clearColor();
    return generalImageV;
}
//MARK:创建UIVIEW
func createView(generalFrame:CGRect)->UIView
{
    var generalView:UIView = UIView(frame: generalFrame);
    generalView.backgroundColor = UIColor.clearColor();
    return generalView;
}
