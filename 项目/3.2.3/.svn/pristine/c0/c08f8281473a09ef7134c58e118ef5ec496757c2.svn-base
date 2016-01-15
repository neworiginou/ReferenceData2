//
//  HWDiscountCouponAlertView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/19.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWDiscountCouponAlertView: UIView {

    var backView:UIView!
    var topInfoLabel:UILabel!
    var middleImgView:UIImageView!
    var bottomBtn:UIButton!
    var numberLabel:UILabel!//优惠卷编号
    var picImgView:UIImageView!//优惠项目图片
    var nameLabel:UILabel!//优惠券抬头
    var discountLabel:UILabel!//优惠额度
    var validityPeriod:UILabel!//有效期
    var hideBtn:UIButton!//底部取消按钮
    var bottomLabel:UILabel!//跳转我的优惠劵列表
    
    var dataModel:HWDisCountShareModel!
    
    init(frame:CGRect,model:HWDisCountShareModel,isRobSuccess:Bool)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        self.backgroundColor = UIColor(white: 0, alpha: 0.0)
        dataModel = model
        
        self.userInteractionEnabled = true
        
        if isRobSuccess == true
        {
            self.loadType1()
        }
        else
        {
            self.loadType2()
        }
        self.show()
    }
    
    func loadType1()
    {
        backView = UIView.newAutoLayoutView()
        backView.alpha = 0.0
        backView.backgroundColor = UIColor.whiteColor()
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
        self.addSubview(backView)

        backView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self, withOffset:0)
        backView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self, withOffset: 0)
//        if kScreenHeight == 480
//        {
//            backView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self, withOffset: (kScreenHeight - 372) / 2 - 30)
//        }
//        else
//        {
//            backView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self, withOffset: 0)
//        }
        //backView.autoSetDimension(ALDimension.Width, toSize: kScreenWidth - kScreenWidth == 320 ? 5:15)
        backView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self, withOffset: kScreenWidth == 320 ? 5:15)
        backView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self, withOffset: kScreenWidth == 320 ? -5:-15)
        //backView.autoSetDimension(ALDimension.Height, toSize: 372)
        backView.autoSetDimension(ALDimension.Height, toSize: 372 - 31 - 15 - 5)
         
        var topLabel = UILabel.newAutoLayoutView()
        topLabel.backgroundColor = UIColor.clearColor()
        topLabel.textAlignment = NSTextAlignment.Center
        topLabel.font = Define.font(TF_18)
        topLabel.textColor = CD_MainColor
        topLabel.text = "恭喜您！"
        backView.addSubview(topLabel)
        topLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: backView, withOffset: 25)
        topLabel.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
        topLabel.autoSetDimension(ALDimension.Height, toSize: 19)
        topLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView:backView , withOffset:10)
        topLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView:backView, withOffset:-10)
        
//        topInfoLabel = UILabel.newAutoLayoutView()
//        topInfoLabel.backgroundColor = UIColor.clearColor()
//        topInfoLabel.textAlignment = NSTextAlignment.Center
//        topInfoLabel.font = Define.font(TF_15)
//        topInfoLabel.textColor = CD_Txt_Color_00
//        backView.addSubview(topInfoLabel)
//        topInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topLabel, withOffset: 15)
//        topInfoLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: backView, withOffset: -5)
//        topInfoLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backView, withOffset: 5)
//        topInfoLabel.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
//        topInfoLabel.autoSetDimension(ALDimension.Height, toSize: 16)
//        //topInfoLabel.text = "您已获得2000元凤凰西海岸优惠劵！"
//        topInfoLabel.text = "您已获得" + dataModel.couponMoney + dataModel.couponShortTitle + "优惠劵！"
        
        middleImgView = UIImageView.newAutoLayoutView()
        var image:UIImage = UIImage(named: "coupon3")!
        middleImgView.image = image.resizableImageWithCapInsets(UIEdgeInsetsMake(50, 15, 15, 15))
        middleImgView.backgroundColor = UIColor.clearColor()
        self.addSubview(middleImgView)
        middleImgView.autoSetDimension(ALDimension.Height, toSize: 138)
        middleImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backView, withOffset: kScreenWidth == 320 ? 5:15)
        middleImgView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: backView, withOffset: kScreenWidth == 320 ? -5:-15)
        //middleImgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topInfoLabel, withOffset: 30)
        middleImgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topLabel, withOffset: 20)
        
        numberLabel = UILabel.newAutoLayoutView()
        numberLabel.backgroundColor = UIColor.clearColor()
        numberLabel.textColor = CD_Txt_Color_33
        numberLabel.font = Define.font(TF_13)
        middleImgView.addSubview(numberLabel)
        numberLabel.autoSetDimension(ALDimension.Height, toSize: 33)
        numberLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: middleImgView, withOffset: 0)
        numberLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: middleImgView, withOffset: 15)
        numberLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: middleImgView, withOffset: -15)
        //numberLabel.text = "编号：01010030001"
        numberLabel.text = "编号：" + dataModel.couponNum
        
        picImgView = UIImageView.newAutoLayoutView()
        picImgView.backgroundColor = UIColor.greenColor()
        picImgView.layer.cornerRadius = 3
        picImgView.layer.masksToBounds = true
        middleImgView.addSubview(picImgView)
        picImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: middleImgView, withOffset: 15)
        picImgView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: middleImgView, withOffset: -15)
        picImgView.autoSetDimension(ALDimension.Height, toSize: 75)
        picImgView.autoSetDimension(ALDimension.Width, toSize: 85)
        picImgView.setImageWithURL(NSURL(string:dataModel.picUrl), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(95, 75), imageName: placeHolderSmallImage))
        
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textColor = CD_Txt_Color_33
        nameLabel.font = Define.font(TF_15)
        middleImgView.addSubview(nameLabel)
        nameLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        nameLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: picImgView, withOffset: 10)
        nameLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Top, ofView: picImgView, withOffset: 0)
        nameLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: middleImgView, withOffset: -5)
        //nameLabel.text = "中海山湖一号优惠劵"
        nameLabel.text = dataModel.couponTitle
        
        discountLabel = UILabel.newAutoLayoutView()
        discountLabel.backgroundColor = UIColor.clearColor()
        discountLabel.textColor = CD_Txt_Color_66
        discountLabel.font = Define.font(TF_13)
        middleImgView.addSubview(discountLabel)
        discountLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        discountLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: picImgView, withOffset: 10)
        discountLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: 0)
        discountLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: middleImgView, withOffset: -5)
        //discountLabel.text = "优惠：2000元团购费"
        discountLabel.text = "优惠：" + dataModel.couponMoney + "元团购费"
        
        validityPeriod = UILabel.newAutoLayoutView()
        validityPeriod.backgroundColor = UIColor.clearColor()
        validityPeriod.textColor = CD_Txt_Color_66
        validityPeriod.font = Define.font(TF_11)
        validityPeriod.numberOfLines = 0
        middleImgView.addSubview(validityPeriod)
        validityPeriod.autoSetDimension(ALDimension.Height, toSize: 25)
        validityPeriod.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: picImgView, withOffset: 10)
        validityPeriod.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Bottom, ofView: discountLabel, withOffset: 0)
        validityPeriod.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: middleImgView, withOffset: -5)
        //validityPeriod.text = "有效期：2015-01-08至2015-05-01"
        validityPeriod.text = dataModel.time

        bottomLabel = UILabel.newAutoLayoutView()
        bottomLabel.userInteractionEnabled = true
        bottomLabel.backgroundColor = UIColor.clearColor()
        bottomLabel.textColor = CD_Txt_Color_66
        bottomLabel.font = Define.font(TF_14)
        bottomLabel.textAlignment = NSTextAlignment.Center
        bottomLabel.text = "可在我的优惠劵查看"
        backView.addSubview(bottomLabel)
        bottomLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: backView, withOffset: -26)
        bottomLabel.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
        
        bottomBtn = UIButton.newAutoLayoutView()
        bottomBtn.backgroundColor = CD_MainColor
        bottomBtn.layer.cornerRadius = 20
        bottomBtn.layer.masksToBounds = true
        bottomBtn.setTitle("分享", forState: UIControlState.Normal)
        bottomBtn.setTitleColor(CD_Txt_Color_ff, forState: UIControlState.Normal)
        bottomBtn.titleLabel?.font = Define.font(TF_18)
        backView.addSubview(bottomBtn)
        bottomBtn.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
        bottomBtn.autoPinEdge(ALEdge.Bottom, toEdge:ALEdge.Top, ofView: bottomLabel, withOffset: -15)
        bottomBtn.autoSetDimension(ALDimension.Height, toSize: 40)
        bottomBtn.autoSetDimension(ALDimension.Width, toSize: 267)
        
        hideBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        hideBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        hideBtn.setBackgroundImage(UIImage(named: "delete3_2"), forState: UIControlState.Normal)
        self.addSubview(hideBtn)
        hideBtn.autoSetDimension(ALDimension.Height, toSize: 30)
        hideBtn.autoSetDimension(ALDimension.Width, toSize: 30)
        hideBtn.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
        hideBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: backView, withOffset: 30)
    }
    
    func loadType2()
    {
        backView = UIView.newAutoLayoutView()
        backView.alpha = 0.0
        backView.backgroundColor = UIColor.whiteColor()
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
        self.addSubview(backView)
        backView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self, withOffset: 0)
        backView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self, withOffset: 0)
        //backView.autoSetDimension(ALDimension.Width, toSize: kScreenWidth - kScreenWidth == 320 ? 5:15)
        backView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self, withOffset: 15)
        backView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self, withOffset: -15)
        backView.autoSetDimension(ALDimension.Height, toSize: 225)
        
        var imgView = UIImageView.newAutoLayoutView()
        imgView.image = UIImage(named: "no_coupon2")
        backView.addSubview(imgView)
        imgView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
        imgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: backView, withOffset: 47)
        imgView.autoSetDimension(ALDimension.Height, toSize: 129 / 2)
        imgView.autoSetDimension(ALDimension.Width, toSize: 182 / 2)
        
        var label = UILabel.newAutoLayoutView()
        label.textColor  = CD_MainColor
        label.backgroundColor = UIColor.clearColor()
        label.font = Define.font(TF_15)
        label.text = "晚了一步，优惠卷已被抢完"
        label.textAlignment = NSTextAlignment.Center
        backView.addSubview(label)
        label.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: imgView)
        label.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: imgView, withOffset: 40)
        hideBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        hideBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        hideBtn.setBackgroundImage(UIImage(named: "delete3_2"), forState: UIControlState.Normal)
        self.addSubview(hideBtn)
        hideBtn.autoSetDimension(ALDimension.Height, toSize: 30)
        hideBtn.autoSetDimension(ALDimension.Width, toSize: 30)
        hideBtn.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: backView)
        hideBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: backView, withOffset: 30)
    }
    
    func show()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor = UIColor(white: 0, alpha: 0.7)
            self.backView.alpha = 1.0
            }) { (finished) -> Void in
        }
    }
    
    func hide()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            //self.backgroundColor = UIColor(white: 0, alpha: 0.0)
            self.alpha = 0.0
            self.backView.alpha = 0.0
            }) { (finished) -> Void in
                
                self.removeFromSuperview()
        }
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
