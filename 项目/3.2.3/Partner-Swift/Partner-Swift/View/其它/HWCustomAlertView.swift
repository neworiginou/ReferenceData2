//
//  HWCustomAlertView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum AlertViewType :Int{
    case EditNickName//昵称修改
    case EditComplain//投诉
    case HiToOther//Hi经纪人
    case IsMyCustomer//客户录入
    case BindingCustomer//绑定客户
    case CustomerUnlock//积分解锁
    case PassWordInput//支付密码
    case DealConfirm//成交确认 MYP add v3.1
}

@objc protocol HWCustomAlertViewDelegate
{
     optional func didSelectdConfirm() -> Void
     optional func giveUp()->Void;
     optional func unlock()->Void;
     optional func ConfirmInPut(content:NSString) -> Void
}

class HWCustomAlertView: UIView,UITextFieldDelegate,UITextViewDelegate {

    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width

    let editBackViewWidth = kScreenWidth - 60 * kScreenRate
    
    var editBackView:UIView?//弹框背景视图
    var tf:UITextField?//投诉输入框
    var tf2:UITextField?//不使用的TF
    var tv:UITextView?//密码 昵称
    var cancelBtn:UIButton?//取消
    var confirmBtn:UIButton?//确定
    
    var alertType:AlertViewType?
    //var text:NSString?
    var delegate:HWCustomAlertViewDelegate?
    var moneyText = NSString()
    
    
    //MARK:积分解锁/支付密码/Hi一下
    init(type:AlertViewType, infoDic:NSMutableDictionary)
    {
        super.init(frame:CGRectMake(0, 0, screenWidth, screenHeight))
        
        alertType = type
        
        if(type == AlertViewType.CustomerUnlock)
        {
//            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 120:170, editBackViewWidth, 235 * kScreenRate),backgroundColor:UIColor.whiteColor())
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 120:170, editBackViewWidth, 145 * kScreenRate),backgroundColor:UIColor.whiteColor())
            
//            var headImgView = UIImageView.newAutoLayoutView()
//            headImgView.backgroundColor = UIColor.clearColor()
//            headImgView.image = UIImage(named: "panic2");
//            editBackView?.addSubview(headImgView)
////            headImgView.layer.cornerRadius = 75*kScreenRate/2.0;
////            headImgView.layer.masksToBounds = true;
//            headImgView?.autoSetDimension(ALDimension.Width, toSize: 75 * kScreenRate)
//            headImgView?.autoSetDimension(ALDimension.Height, toSize: 75 * kScreenRate)
//            headImgView?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
//            headImgView?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: editBackView, withOffset: 20 * kScreenRate)
//            
//            var nameLabel = UILabel.newAutoLayoutView()
//            nameLabel.backgroundColor = UIColor.clearColor()
//            nameLabel.font = Define.font(TF_13)
//            nameLabel.textColor = CD_Txt_Color_00
//            nameLabel.textAlignment = NSTextAlignment.Center
//            editBackView?.addSubview(nameLabel)
//            nameLabel.autoSetDimension(ALDimension.Height, toSize: 60  * kScreenRate)
//            nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: headImgView)
//            nameLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
//            var text = infoDic.stringObjectForKey("intention")
//            if text.isEqualToString("")
//            {
//                text = "无"
//            }
//            nameLabel.text = "需求描述：" + text
//            nameLabel.text = "需求描述：3室2厅｜100-200万｜80-120m"
            
            let titleLabel = UILabel.newAutoLayoutView()
            titleLabel.textColor = CD_Txt_Color_00
            titleLabel.font = Define.font(TF_15)
            //titleLabel.text = "绑定抢到的客户"
            titleLabel.text = infoDic.stringObjectForKey("titleText")
            editBackView?.addSubview(titleLabel)
            titleLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            titleLabel.autoSetDimension(ALDimension.Height, toSize: TF_15 )
            titleLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: editBackView, withOffset: 25 * kScreenRate)
            
            var numLabel = UILabel.newAutoLayoutView()
            numLabel.textColor = CD_Txt_Color_00
            numLabel.font = Define.font(TF_15)
            editBackView?.addSubview(numLabel)
            numLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel, withOffset: 10 * kScreenRate)
            numLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            numLabel.autoSetDimension(ALDimension.Height, toSize: TF_15 )
            
            
            var scoreStr = infoDic.stringObjectForKey("score")
            var attriStr = NSMutableAttributedString(string: "消费：\(scoreStr)")
            attriStr.addAttribute(NSForegroundColorAttributeName, value:CD_MainColor, range: NSMakeRange(3, scoreStr.length))
            numLabel.attributedText = attriStr

            
            cancelBtn = UIButton.newAutoLayoutView()
            cancelBtn?.backgroundColor = CD_LineColor
            cancelBtn?.titleLabel?.font = Define.font(TF_15)
            cancelBtn?.layer.cornerRadius = 3
            cancelBtn?.layer.masksToBounds = true
            cancelBtn?.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
            cancelBtn?.setTitle("取消", forState: UIControlState.Normal)
            editBackView?.addSubview(cancelBtn!)
            cancelBtn?.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
            cancelBtn?.autoSetDimension(ALDimension.Width, toSize:140 * kScreenRate)
            cancelBtn?.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
            cancelBtn?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView,withOffset:12 * kScreenRate)
            cancelBtn?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: editBackView,withOffset:-10 * kScreenRate)
            
            var timerStr:NSString = infoDic.stringObjectForKey("timer");
            //解锁积分按钮
            var time = HWCountDownLabel(frame:CGRectMake(editBackViewWidth - (140 + 12) * kScreenRate, (145 + 10) * kScreenRate - (40 + 20) * kScreenRate, 140 * kScreenRate, 40 * kScreenRate), totalSecond:timerStr);
            editBackView?.addSubview(time)
            
            let tapGas = UITapGestureRecognizer(target: self, action: "confirmAction")
            time.addGestureRecognizer(tapGas)
        }
        else if (type == AlertViewType.PassWordInput)
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 20:100 - CGFloat(iPhone5 ? 40 : 0),editBackViewWidth , 240 * kScreenRate), backgroundColor: CD_BackGroundColor)
            
            let titleLabel = UILabel.newAutoLayoutView()
            titleLabel.font = Define.font(TF_15)
            titleLabel.textColor = CD_Txt_Color_99
            titleLabel.backgroundColor = UIColor.clearColor()
            titleLabel.text = "支付密码"
            titleLabel.textAlignment = NSTextAlignment.Center
            editBackView?.addSubview(titleLabel)
            titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
            titleLabel.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
            
            let topLine = UIView.newAutoLayoutView()
            topLine.backgroundColor = CD_LineColor
            editBackView?.addSubview(topLine)
            topLine.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView, withOffset: 20)
            topLine.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView, withOffset: -20)
            topLine.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel)
            topLine.autoSetDimension(ALDimension.Height, toSize: 0.5)

            self.addCancelAndConfirmBtn()
            
            tf = UITextField.newAutoLayoutView()
            tf!.backgroundColor = UIColor.whiteColor()
            tf!.borderStyle = UITextBorderStyle.RoundedRect
            tf!.textColor = CD_Txt_Color_00
            tf!.font = Define.font(TF_16)
            tf!.delegate = self
            tf!.keyboardType = UIKeyboardType.ASCIICapable
            editBackView?.addSubview(tf!)
            tf!.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: cancelBtn, withOffset:-18 * kScreenRate)
            tf!.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            tf!.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView, withOffset: 20)
            tf!.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView, withOffset: -20)
            tf!.autoSetDimension(ALDimension.Height, toSize: 40)
            
            let expenseLabel = UILabel.newAutoLayoutView()
            expenseLabel.backgroundColor = UIColor.clearColor()
            expenseLabel.font = Define.font(TF_15)
            expenseLabel.textColor = CD_Txt_Color_00
            editBackView?.addSubview(expenseLabel)
            expenseLabel.autoSetDimension(ALDimension.Height, toSize: 15 )
            expenseLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: tf!)
            expenseLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: tf!, withOffset: -15 * kScreenRate)
            
            let expense = infoDic.stringObjectForKey("expense")
            let e:NSString = "10.00"
            var attriStr = NSMutableAttributedString(string: "消费：\(e)元")
            attriStr.addAttribute(NSForegroundColorAttributeName, value:CD_MainColor, range: NSMakeRange(3,e.length))
            expenseLabel.attributedText = attriStr
            
            let priceLabel = UILabel.newAutoLayoutView()
            priceLabel.backgroundColor = UIColor.clearColor()
            priceLabel.font = Define.font(TF_15)
            priceLabel.textColor = CD_Txt_Color_00
            editBackView?.addSubview(priceLabel)
            priceLabel.autoSetDimension(ALDimension.Height, toSize: 15 )
            priceLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: tf!)
            priceLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView:expenseLabel, withOffset: -15 * kScreenRate)
            priceLabel.text = "10元100个积分"
        
        }
        else if (type == AlertViewType.HiToOther)
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 120:170 ,editBackViewWidth , 235 * kScreenRate),backgroundColor:UIColor.whiteColor())
            
            var headImgView = UIImageView.newAutoLayoutView()
            headImgView.backgroundColor = UIColor.clearColor()
            headImgView.layer.cornerRadius = 39 * kScreenRate
            headImgView.layer.masksToBounds = true

            var urlStr = Utility.imageDownloadWithMongoDbKey(infoDic.stringObjectForKey("picKey"))
            headImgView.setImageWithURL(NSURL(string:urlStr), placeholderImage:UIImage(named: "personal_2"))
            editBackView?.addSubview(headImgView)
            headImgView?.autoSetDimension(ALDimension.Width, toSize: 78 * kScreenRate)
            headImgView?.autoSetDimension(ALDimension.Height, toSize: 78 * kScreenRate)
            headImgView?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            headImgView?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: editBackView, withOffset: 15 * kScreenRate)
            
            var nameLabel = UILabel.newAutoLayoutView()
            nameLabel.backgroundColor = UIColor.clearColor()
            nameLabel.font = Define.font(TF_15)
            nameLabel.textColor = CD_Txt_Color_00
            nameLabel.textAlignment = NSTextAlignment.Center
            editBackView?.addSubview(nameLabel)
            nameLabel.autoSetDimension(ALDimension.Height, toSize: 15 * kScreenRate)
            nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: headImgView, withOffset: 23 * kScreenRate)
            nameLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            nameLabel.text = infoDic.stringObjectForKey("brokerName")
            //nameLabel.text = "王老五"
            

            
            var HIBtn = UIButton.newAutoLayoutView()
            HIBtn.backgroundColor = CD_MainColor
            HIBtn.titleLabel?.font = Define.font(TF_16)
            HIBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            HIBtn.setTitle("HI一下", forState: UIControlState.Normal)
            HIBtn.addTarget(self, action: "confirmAction", forControlEvents: UIControlEvents.TouchUpInside)
            HIBtn.layer.cornerRadius = 35 / 2 * kScreenRate
            HIBtn.layer.masksToBounds = true
            editBackView?.addSubview(HIBtn)
            HIBtn.autoSetDimension(ALDimension.Height, toSize: 35 * kScreenRate)
            HIBtn.autoSetDimension(ALDimension.Width, toSize: 235 * kScreenRate)
            HIBtn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            HIBtn.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: editBackView, withOffset:-10 * kScreenRate)

            let line = UIView.newAutoLayoutView()
            line.backgroundColor = CD_Txt_Color_99
            editBackView?.addSubview(line)
            line.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView)
            line.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView)
            line.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: HIBtn, withOffset:-8 * kScreenRate)
            line.autoSetDimension(ALDimension.Height, toSize: 0.5)
            
            var tapGes = UITapGestureRecognizer(target: self, action: "hideAnimate")
            self.addGestureRecognizer(tapGes)
            
            var locationInfoLabel = UILabel.newAutoLayoutView()
            locationInfoLabel.textColor = CD_Txt_Color_00
            locationInfoLabel.font = Define.font(TF_12)
            locationInfoLabel.textAlignment = NSTextAlignment.Center
            locationInfoLabel.numberOfLines = 0
            editBackView?.addSubview(locationInfoLabel)
            locationInfoLabel.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: headImgView, withOffset: 10)
            //locationInfoLabel.autoSetDimension(ALDimension.Height, toSize: 30 * kScreenRate)
            //locationInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: 10 * kScreenRate)
            locationInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel)
            locationInfoLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: line)
            locationInfoLabel.autoSetDimension(ALDimension.Width, toSize: 200 * kScreenRate)
            locationInfoLabel.text = infoDic.stringObjectForKey("locationInfo")
            //locationInfoLabel.text = "宝山 通河新村 距离800米"
            locationInfoLabel.text = "位置信息解析中..."
            
            var localImgView = UIImageView.newAutoLayoutView()
            localImgView.backgroundColor = UIColor.clearColor()
            localImgView.image = UIImage(named: "map_2")
            editBackView?.addSubview(localImgView)
            localImgView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: locationInfoLabel, withOffset: -10)
            localImgView.autoSetDimension(ALDimension.Width, toSize: 21/2)
            localImgView.autoSetDimension(ALDimension.Height, toSize: 31/2)
            localImgView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: locationInfoLabel)
            
            //判断经纬度是否有效
            //var location = CLLocation(latitude: "31.350376".doubleValue, longitude: "121.446871".doubleValue)
            var logStr: NSString = infoDic.stringObjectForKey("log")
            var latStr:NSString = infoDic.stringObjectForKey("lat")
            var currLogStr:NSString = infoDic.stringObjectForKey("currLog")
            var currLatStr:NSString = infoDic.stringObjectForKey("currLat")
            //解析地址信息
            println("latStr ================== \(latStr)")
            println("logStr ================== \(logStr)")
            println("curLat ================== \(currLatStr)")
            println("curLog ================== \(currLogStr)")

            
            println("latStr ================== \(latStr.doubleValue)")
            println("logStr ================== \(logStr.doubleValue)")
            println("curLat ================== \(currLatStr.doubleValue)")
            println("curLog ================== \(currLogStr.doubleValue)")

            
            var distanceStr:NSString = ""
            if logStr.isEqualToString("0.0") || latStr.isEqualToString("0.0")
            {
                locationInfoLabel.text = "位置信息解析失败"
                return
            }
            else
            {
                var point1 = CLLocation(latitude: latStr.doubleValue, longitude: logStr.doubleValue)
                var point2 = CLLocation(latitude: currLatStr.doubleValue, longitude: currLogStr.doubleValue)
                var distance:CLLocationDistance = point1.distanceFromLocation(point2)
                println("distanceStr ===================== \(distanceStr)")
                if distance > 0
                {
                    distanceStr = "距\(Int(distance))m"
                    if distance > 2000
                    {
                        distanceStr = "距2000m"
                    }
                }
            }
            
            
            
            
            var addressInfo:NSString?
            var location = CLLocation(latitude:latStr.doubleValue, longitude:logStr.doubleValue)
            var geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                if error != nil
                {
//                    println("reverse geodcode fail: \(error.localizedDescription)")
                    addressInfo = "位置信息解析失败"
                    locationInfoLabel.text = addressInfo
                    return
                }
                
                var p: CLPlacemark?
                let pm = placemarks as [CLPlacemark]
                if (pm.count > 0)
                {
                    p = placemarks[0] as? CLPlacemark
                    //self.locationInfoLabel?.text = p?.addressDictionary["State"] as? NSString
                    //println("\(p?.subLocality!) \(p?.thoroughfare!) \(p?.subThoroughfare!) \(p?.name)")
                    if (p != nil)
                    {
                        var address: NSArray! = p?.addressDictionary["FormattedAddressLines"] as NSArray
            
                        let thoroughfare = address.pObjectAtIndex(0) as? NSString
                        addressInfo = "\(thoroughfare!) \(distanceStr)" as NSString
                        
                        locationInfoLabel.text = addressInfo
                    }
                    else
                    {
                        addressInfo = "位置信息解析失败"
                        locationInfoLabel.text = addressInfo!
                    }
                }
                else
                {
                    addressInfo = "位置信息解析失败"
                    locationInfoLabel.text = addressInfo!
                    println("No Placemarks!")
                }})

        }
    }
    
    //MARK:绑定客户/是否查看已录入客户信息
    init(type:AlertViewType,alertText:NSString)
    {
        super.init(frame:CGRectMake(0, 0, screenWidth, screenHeight))
        
        alertType = type
        
        if (type == AlertViewType.BindingCustomer)
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 120:170, editBackViewWidth, 140 * kScreenRate),backgroundColor:UIColor.whiteColor())
            self.addCancelAndConfirmBtn()
            
            let titleLabel = UILabel.newAutoLayoutView()
            titleLabel.textColor = CD_Txt_Color_00
            titleLabel.font = Define.font(TF_15)
            titleLabel.text = "绑定抢到的客户"
            editBackView?.addSubview(titleLabel)
            titleLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            titleLabel.autoSetDimension(ALDimension.Height, toSize: TF_15 * kScreenRate)
            titleLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: editBackView, withOffset: 25 * kScreenRate)
            
            var numLabel = UILabel.newAutoLayoutView()
            numLabel.textColor = CD_Txt_Color_00
            numLabel.font = Define.font(TF_15)
            editBackView?.addSubview(numLabel)
            numLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel, withOffset: 10 * kScreenRate)
            numLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            numLabel.autoSetDimension(ALDimension.Height, toSize: TF_15 * kScreenRate)
            
            var attriStr = NSMutableAttributedString(string: "消费：\(alertText)")
            attriStr.addAttribute(NSForegroundColorAttributeName, value:CD_MainColor, range: NSMakeRange(3, alertText.length))
            numLabel.attributedText = attriStr
        }
        else if (type == AlertViewType.IsMyCustomer)
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 120:170, editBackViewWidth, 150 * kScreenRate),backgroundColor:CD_BackGroundColor)
            
            self.addCancelAndConfirmBtn()
            
            var alertTextLabel = UILabel.newAutoLayoutView()
            alertTextLabel.numberOfLines = 0
            alertTextLabel.textColor = CD_Txt_Color_00
            alertTextLabel.font = Define.font(TF_15)
            alertTextLabel.backgroundColor = UIColor.clearColor()
            editBackView?.addSubview(alertTextLabel)
            alertTextLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: editBackView, withOffset:0)
            alertTextLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView, withOffset:15 * kScreenRate)
            alertTextLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView, withOffset:-15 * kScreenRate)
            alertTextLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: cancelBtn, withOffset:0)
            alertTextLabel.text = alertText
            let str:NSString = "#张大柱# 15628739475已经是我的客户，查看客户详情？"
            var attriStr = NSMutableAttributedString(string: str)
            var paragraphStyle1 = NSMutableParagraphStyle()
            paragraphStyle1.lineSpacing = 15
            attriStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle1, range: NSMakeRange(0, str.length))
            //alertTextLabel.text = "#张大柱# 15628739475已经是我的客户，查看客户详情？"
            alertTextLabel.attributedText = attriStr
            alertTextLabel.textAlignment = NSTextAlignment.Center
        }
    }
    
    func textFieledEditChanged(obj:NSNotification)
    {
//        var textF = obj.object as UITextField
        
        if self.tf == nil
        {
            return
        }
        
        var toBeString = self.tf!.text
        var lang = textInputMode?.primaryLanguage
    
//        println("lang ==================== \(lang)")
//        println("text ==================== \(toBeString)")
        if lang == "zh-Hans"
        {
            var selectedRange = self.tf!.markedTextRange
            //var position:UITextPosition = self.tf!.positionFromPosition(selectedRange!.start, offset: 0)!
            if selectedRange == nil
            {
                if(countElements(self.tf!.text) > 6)
                {
                    //self.tf!.text = toBeString.substringToIndex(advance(toBeString.startIndex, 8))
                    self.tf!.text = toBeString.substringToIndex(advance(toBeString.startIndex,6))
//                    println("tf.text =============== \(self.tf!.text)")
                }
            }
            else
            {
                
            }
            
        }
        else
        {
            if(countElements(self.tf!.text) > 6)
            {
                self.tf!.text = toBeString.substringToIndex(advance(toBeString.startIndex,6))
            }
            
            
        }
    }
    
    
    //MARK:修改下线昵称/投诉编辑
    init(type:AlertViewType)
    {
        super.init(frame:CGRectMake(0, 0, screenWidth, screenHeight))
        
        alertType = type
        
        if (type == AlertViewType.EditNickName)
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 60:170 - CGFloat(iPhone5 ? 40 : 0),editBackViewWidth , 150 * kScreenRate), backgroundColor: CD_BackGroundColor)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieledEditChanged:", name: "UITextFieldTextDidChangeNotification", object: nil)
            
            tf = UITextField.newAutoLayoutView()
            tf!.backgroundColor = UIColor.whiteColor()
            tf!.borderStyle = UITextBorderStyle.RoundedRect
            tf!.textColor = CD_Txt_Color_00
            tf!.font = Define.font(TF_16)
            tf!.delegate = self
            tf!.keyboardType = UIKeyboardType.Default
            editBackView?.addSubview(tf!)
            tf!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: editBackView, withOffset:33 * kScreenRate)
            tf!.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            tf!.autoSetDimension(ALDimension.Width, toSize: 265 * kScreenRate)
            tf!.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
            
            tf2 = UITextField.newAutoLayoutView()
            editBackView?.addSubview(tf2!)
            tf2?.autoSetDimension(ALDimension.Height, toSize: 0)
            tf2?.autoSetDimension(ALDimension.Width, toSize: 0)
            tf2?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self)
            
            self.addCancelAndConfirmBtn()
            
            
            
        }
        else if type == AlertViewType.EditComplain
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 30:140 - CGFloat(iPhone5 ? 40 : 0),editBackViewWidth , 196 * kScreenRate), backgroundColor: CD_BackGroundColor)
            
            let titleLabel = UILabel.newAutoLayoutView()
            titleLabel.font = Define.font(TF_15)
            titleLabel.textColor = CD_Txt_Color_66
            titleLabel.backgroundColor = UIColor.clearColor()
            titleLabel.text = "投诉"
            titleLabel.textAlignment = NSTextAlignment.Center
            editBackView?.addSubview(titleLabel)
            titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
            titleLabel.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
            
            let topLine = UIView.newAutoLayoutView()
            topLine.backgroundColor = CD_LineColor
            editBackView?.addSubview(topLine)
            topLine.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView, withOffset: 25)
            topLine.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView, withOffset: -25)
            topLine.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel)
            topLine.autoSetDimension(ALDimension.Height, toSize: 0.5)
            
            self.addCancelAndConfirmBtn()

            tv = UITextView.newAutoLayoutView()
            tv!.backgroundColor = UIColor.whiteColor()
            tv!.textColor = CD_Txt_Color_00
            tv!.font = Define.font(TF_16)
            tv!.delegate = self
            tv!.keyboardType = UIKeyboardType.Default
            editBackView?.addSubview(tv!)
            tv?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            tv?.autoSetDimension(ALDimension.Width, toSize: 265 * kScreenRate)
            //tv?.autoSetDimension(ALDimension.Height, toSize: 80 * kScreenRate)
            tv?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: cancelBtn, withOffset: -10 * kScreenRate)
            tv?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topLine, withOffset: 8 * kScreenRate)
            tv?.layer.cornerRadius = 3
            tv?.layer.masksToBounds = true
        }
}
    init(type:AlertViewType,str:NSString)
    {
        super.init(frame:CGRectMake(0, 0, screenWidth, screenHeight))
        
        alertType = type
        
        
        if type == AlertViewType.DealConfirm
        {
            self.addEditView(CGRectMake(30 * kScreenRate, screenHeight < 500 ? 60:170 - CGFloat(iPhone5 ? 40 : 0),editBackViewWidth , 370 / 2 * kScreenRate), backgroundColor: CD_BackGroundColor)
            
            let topLabel = UILabel.newAutoLayoutView()
            topLabel.backgroundColor = UIColor.clearColor()
            topLabel.textAlignment = NSTextAlignment.Center
            topLabel.textColor = CD_Txt_Color_99
            topLabel.text =  "成交确认"
            topLabel.font = Define.font(TF_15)
            editBackView?.addSubview(topLabel)
            topLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
            topLabel.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
            
            let topLine = UIView.newAutoLayoutView()
            topLine.backgroundColor = CD_LineColor
            editBackView?.addSubview(topLine)
            topLine.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView, withOffset: 25)
            topLine.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView, withOffset: -25)
            topLine.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topLabel)
            topLine.autoSetDimension(ALDimension.Height, toSize: 0.5)
            
            let tfBackView = UIView.newAutoLayoutView()
            tfBackView.backgroundColor = UIColor.whiteColor()
            tfBackView.layer.cornerRadius = 3
            tfBackView.layer.masksToBounds = true
            tfBackView.layer.borderColor = CD_LineColor.CGColor
            tfBackView.layer.borderWidth = 0.5
            editBackView?.addSubview(tfBackView)
            tfBackView.autoSetDimension(ALDimension.Width, toSize: editBackViewWidth - 50)
            tfBackView.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
            tfBackView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topLabel, withOffset: 20 * kScreenRate)
            tfBackView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: topLabel)
            
            let leftInfoLabel = UILabel.newAutoLayoutView()
            leftInfoLabel.backgroundColor = UIColor.clearColor()
            leftInfoLabel.textColor = CD_Txt_Color_99
            leftInfoLabel.font = Define.font(TF_15)
            leftInfoLabel.text = "成交金额"
            tfBackView.addSubview(leftInfoLabel)
            leftInfoLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: tfBackView, withOffset: 10)
            leftInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: tfBackView)
            leftInfoLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: tfBackView)
            
            let rightInfoLabel = UILabel.newAutoLayoutView()
            rightInfoLabel.backgroundColor = UIColor.clearColor()
            rightInfoLabel.textColor = CD_MainColor
            rightInfoLabel.font = Define.font(TF_15)
            rightInfoLabel.text = "万元"
            tfBackView.addSubview(rightInfoLabel)
            rightInfoLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: tfBackView, withOffset: -10)
            rightInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: tfBackView)
            rightInfoLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: tfBackView)
            
            tf = UITextField.newAutoLayoutView()
            tf!.backgroundColor = UIColor.clearColor()
            tf!.textColor = CD_Txt_Color_00
            tf?.text = str
            tf!.font = Define.font(TF_16)
            tf!.delegate = self
            tf!.keyboardType = UIKeyboardType.NumberPad
            tfBackView?.addSubview(tf!)
            tf!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: tfBackView)
            tf!.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: tfBackView)
            tf!.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: leftInfoLabel, withOffset:10)
            tf!.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: rightInfoLabel, withOffset:-10)
            
            self.addCancelAndConfirmBtn()
        }


    }

    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UITextFieldTextDidChangeNotification", object: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:放弃
    func cancel()
    {
        if(alertType == AlertViewType.CustomerUnlock)
        {
            delegate?.giveUp!();
            self.hideAnimate();
        }
    }
    
    //MARK:点击确定按钮回调方法
    func confirmAction()
    {
        if alertType == AlertViewType.EditNickName
        {
            //tf2?.becomeFirstResponder()
            tf?.resignFirstResponder()
            var nickName = tf?.text
            delegate?.ConfirmInPut!(nickName!)
        }
        else if alertType == AlertViewType.EditComplain
        {
            let complain = tv?.text
            if(complain != nil)
            {
                delegate?.ConfirmInPut!(complain!)
            }
            //println("发送投诉")
        }
        else if alertType == AlertViewType.BindingCustomer
        {
            delegate?.unlock!()
            //println("确认绑定客户")
        }
        else if alertType == AlertViewType.CustomerUnlock
        {
            //delegate?.didSelectdConfirm!()
            //println("积分解锁客户")
            delegate?.unlock!()
        }
        else if alertType == AlertViewType.HiToOther
        {
            delegate?.didSelectdConfirm!()
            //println("Hi一下")
        }
        else if alertType == AlertViewType.IsMyCustomer
        {
            delegate?.didSelectdConfirm!()
            //println("是否查看客户详情")
        }
        else if alertType == AlertViewType.PassWordInput
        {
            let password = tf?.text
            delegate?.ConfirmInPut!(password!)
            //println("支付密码")
        }
        else if alertType == AlertViewType.DealConfirm
        {
            tf?.resignFirstResponder()
            var nickName = tf?.text
            delegate?.ConfirmInPut!(nickName!)
        }
        self.hideAnimate()
    }
    
    //MARK:显示/消失动画
    func showAnimate() -> Void
    {
        tf?.becomeFirstResponder()
        tv?.becomeFirstResponder()
        editBackView?.alpha = 0.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor = UIColor(white: 0, alpha: 0.4)
            self.editBackView?.alpha = 1.0
        })
    }
    
    func hideAnimate() -> Void
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            //self.backgroundColor = UIColor(white: 0, alpha: 0.0)
            self.alpha = 0.0
            }) { (finished) -> Void in
                
                self.removeFromSuperview()
        }
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UITextFieldTextDidChangeNotification", object: nil)
    }

    //MARK:添加弹框背景试图/确定返回按钮方法
    func addEditView(frame:CGRect,backgroundColor:UIColor)
    {
        editBackView = UIView(frame: frame)
        editBackView?.backgroundColor = CD_BackGroundColor
        editBackView?.layer.cornerRadius = 5
        editBackView?.layer.masksToBounds = true
        self.addSubview(editBackView!)
    }
    
    func addCancelAndConfirmBtn()
    {
        cancelBtn = UIButton.newAutoLayoutView()
        cancelBtn?.backgroundColor = UIColor.clearColor()
        cancelBtn?.titleLabel?.font = Define.font(TF_18)
        cancelBtn?.setTitleColor(CD_Txt_CancelBtn, forState: UIControlState.Normal)
        cancelBtn?.setTitle("取消", forState: UIControlState.Normal)
        editBackView?.addSubview(cancelBtn!)
        cancelBtn?.addTarget(self, action: "hideAnimate", forControlEvents: UIControlEvents.TouchUpInside)
        cancelBtn?.autoSetDimension(ALDimension.Width, toSize: editBackViewWidth / 2)
        cancelBtn?.autoSetDimension(ALDimension.Height, toSize: 50 * kScreenRate)
        cancelBtn?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: editBackView)
        cancelBtn?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: editBackView)
        
        confirmBtn = UIButton.newAutoLayoutView()
        confirmBtn?.backgroundColor = UIColor.clearColor()
        confirmBtn?.titleLabel?.font = Define.font(TF_18)
        confirmBtn?.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
        confirmBtn?.setTitle("确定", forState: UIControlState.Normal)
        editBackView?.addSubview(confirmBtn!)
        confirmBtn?.addTarget(self, action: "confirmAction", forControlEvents: UIControlEvents.TouchUpInside)
        confirmBtn?.autoSetDimension(ALDimension.Width, toSize: editBackViewWidth / 2)
        confirmBtn?.autoSetDimension(ALDimension.Height, toSize: 50 * kScreenRate)
        confirmBtn?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: editBackView)
        confirmBtn?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: editBackView)
        
        let line = UIView.newAutoLayoutView()
        line.backgroundColor = CD_LineColor
        editBackView?.addSubview(line!)
        line.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: editBackView)
        line.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        line.autoSetDimension(ALDimension.Width, toSize: 0.5)
        line.autoSetDimension(ALDimension.Height, toSize: 50 * kScreenRate)
        
        cancelBtn?.drawTopLine()
        confirmBtn?.drawTopLine()
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
