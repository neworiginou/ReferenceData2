//
//  HWSubordinateRefreshTopView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSubordinateRefreshTopView: UIView {

    var headImgView:UIImageView?
    var nameLabel:UILabel?
    var phoneNumLabel:UILabel?
    var editBtn:UIButton?
    var callBtn:UIButton?
    var textMessageBtn:UIButton?
    var customerNumLabel:UILabel?
    var achievementLabel:UILabel?
    var titleL:UIView?
    var titleR:UIView?
    var rightView:UIView?
    var leftView:UIView?
    var clearView:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let whiteBackView = UIView.newAutoLayoutView()
        whiteBackView.backgroundColor = UIColor.whiteColor()
        self.addSubview(whiteBackView!)
        whiteBackView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
        whiteBackView.autoSetDimension(ALDimension.Height, toSize: 70 * kScreenRate)
        
        headImgView = UIImageView.newAutoLayoutView()
        headImgView?.backgroundColor = UIColor.clearColor()
        headImgView?.layer.cornerRadius = 50 * kScreenRate / 2
        headImgView?.layer.masksToBounds = true
        headImgView?.layer.borderWidth = 1
        headImgView?.layer.borderColor = CD_BackGroundColor.CGColor
        headImgView?.image = UIImage(named: "personal_2")
        whiteBackView.addSubview(headImgView!)
        headImgView?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: whiteBackView, withOffset:15 * kRate)
        headImgView?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        headImgView?.autoSetDimension(ALDimension.Height, toSize: 50 * kScreenRate)
        headImgView?.autoSetDimension(ALDimension.Width, toSize: 50 * kScreenRate)
        
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel?.backgroundColor = UIColor.clearColor()
        nameLabel?.font = Define.font(TF_16)
        nameLabel?.textColor = CD_Txt_Color_00
        whiteBackView.addSubview(nameLabel!)
        nameLabel?.autoSetDimension(ALDimension.Height, toSize: 18)
        nameLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: whiteBackView, withOffset: 15 * kScreenRate)
        nameLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: headImgView, withOffset: 10 * kRate)
        //nameLabel?.text = "小花"
        
//        editBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
//        editBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
//        editBtn?.setBackgroundImage(UIImage(named: "editor_icon1"), forState: UIControlState.Normal)
//        editBtn?.backgroundColor = UIColor.clearColor()
//        whiteBackView.addSubview(editBtn!)
//        editBtn?.autoSetDimension(ALDimension.Height, toSize: 18 * kScreenRate)
//        editBtn?.autoSetDimension(ALDimension.Width, toSize: 18 * kScreenRate)
//        editBtn?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: nameLabel)
//        editBtn?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: nameLabel, withOffset: 10 * kRate)

        
        
        phoneNumLabel = UILabel.newAutoLayoutView()
        phoneNumLabel?.backgroundColor = UIColor.clearColor()
        phoneNumLabel?.font = Define.font(TF_14)
        phoneNumLabel?.textColor = CD_Txt_Color_00
        whiteBackView.addSubview(phoneNumLabel!)
        phoneNumLabel?.autoSetDimension(ALDimension.Height, toSize: TF_14)
        phoneNumLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: headImgView, withOffset: 10 * kRate)
        phoneNumLabel?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: whiteBackView, withOffset: -15 * kScreenRate)
        //phoneNumLabel?.text = "18506543568"
        
        editBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        editBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
        //editBtn?.setBackgroundImage(UIImage(named: "editor_icon1"), forState: UIControlState.Normal)
        editBtn?.setImage(UIImage(named: "editor_icon1"), forState: UIControlState.Normal)
        editBtn?.backgroundColor = UIColor.clearColor()
        whiteBackView.addSubview(editBtn!)
        editBtn?.autoSetDimension(ALDimension.Height, toSize: 28 * kScreenRate)
        editBtn?.autoSetDimension(ALDimension.Width, toSize: 28 * kScreenRate)
        editBtn?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: nameLabel)
        editBtn?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: nameLabel, withOffset: 0)
        
        textMessageBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        textMessageBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
        textMessageBtn?.setBackgroundImage(UIImage(named: "client_mail"), forState: UIControlState.Normal)
        textMessageBtn?.backgroundColor = UIColor.clearColor()
        whiteBackView.addSubview(textMessageBtn!)
        textMessageBtn?.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
        textMessageBtn?.autoSetDimension(ALDimension.Width, toSize: 40 * kScreenRate)
        textMessageBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        textMessageBtn?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: whiteBackView, withOffset: -15 * kRate)
        
        callBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        callBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
        callBtn?.setBackgroundImage(UIImage(named: "client_phone"), forState: UIControlState.Normal)
        callBtn?.backgroundColor = UIColor.clearColor()
        whiteBackView.addSubview(callBtn!)
        callBtn?.autoSetDimension(ALDimension.Height, toSize: 40 * kScreenRate)
        callBtn?.autoSetDimension(ALDimension.Width, toSize: 40 * kScreenRate)
        callBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        callBtn?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: textMessageBtn, withOffset: -15 * kRate)

        let grayBackView = UIView.newAutoLayoutView()
        grayBackView.backgroundColor = CD_GrayColor
        self.addSubview(grayBackView!)
        grayBackView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: whiteBackView)
        grayBackView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self)
        grayBackView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self)
        grayBackView.autoSetDimension(ALDimension.Height, toSize: 60 * kScreenRate)
        grayBackView.userInteractionEnabled = true
        
        let eachWith = kScreenWidth / 2
        leftView = UIView.newAutoLayoutView()
        leftView?.backgroundColor = UIColor.clearColor()
        grayBackView.addSubview(leftView!)
        leftView?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Right)
        leftView?.autoSetDimension(ALDimension.Width, toSize: eachWith)
        
        customerNumLabel = UILabel.newAutoLayoutView()
        customerNumLabel?.backgroundColor = UIColor.clearColor()
        customerNumLabel?.font = Define.font(TF_18)
        customerNumLabel?.textColor = CD_MainColor
        leftView?.addSubview(customerNumLabel!)
        customerNumLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        customerNumLabel?.autoSetDimension(ALDimension.Height, toSize: 18)
        customerNumLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: leftView, withOffset: 12 * kScreenRate)
        customerNumLabel?.attributedText = self.setGroupString("0")
        
        var titleL = UILabel.newAutoLayoutView()
        titleL.backgroundColor = UIColor.clearColor()
        titleL.font = Define.font(TF_13)
        titleL.textColor = CD_Txt_Color_00
        leftView?.addSubview(titleL)
        titleL.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        titleL.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: customerNumLabel, withOffset: 10 * kScreenRate)
        titleL.autoSetDimension(ALDimension.Height, toSize: 13)
        titleL.text = "客户"
        
        rightView = UIView.newAutoLayoutView()
        rightView?.backgroundColor = UIColor.clearColor()
        grayBackView.addSubview(rightView!)
        rightView?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Left)
        rightView?.autoSetDimension(ALDimension.Width, toSize: eachWith)
        
        achievementLabel = UILabel.newAutoLayoutView()
        achievementLabel?.backgroundColor = UIColor.clearColor()
        achievementLabel?.font = Define.font(TF_18)
        achievementLabel?.textColor = CD_MainColor
        rightView?.addSubview(achievementLabel!)
        achievementLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        achievementLabel?.autoSetDimension(ALDimension.Height, toSize: 18)
        achievementLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: leftView, withOffset: 12 * kScreenRate)
        //achievementLabel?.text = "￥2000.00"
        achievementLabel?.attributedText = self.setYuanString("")

        let titleR = UILabel.newAutoLayoutView()
        titleR.backgroundColor = UIColor.clearColor()
        titleR.font = Define.font(TF_13)
        titleR.textColor = CD_Txt_Color_00
        rightView?.addSubview(titleR)
        titleR.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        titleR.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: achievementLabel, withOffset: 10 * kScreenRate)
        titleR.autoSetDimension(ALDimension.Height, toSize: 13)
        titleR.text = "业绩"
        
        
        grayBackView.autoSetDimension(ALDimension.Width, toSize: kScreenWidth)
        grayBackView.drawTopLine()
        grayBackView.drawBottomLine()
        
        let line = UIView.newAutoLayoutView()
        line.backgroundColor = CD_LineColor
        grayBackView.addSubview(line)
        line.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: grayBackView)
        line.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: grayBackView)
        line.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: grayBackView)
        line.autoSetDimension(ALDimension.Width, toSize: 0.5)
        
//        let bottomLine = UIView.newAutoLayoutView()
//        bottomLine.backgroundColor = CD_LineColor
//        self.addSubview(bottomLine)
//        bottomLine.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Top)
//        bottomLine.autoSetDimension(ALDimension.Height, toSize: 0.5)
        //self.drawBottomLine()
        
        clearView = UIView.newAutoLayoutView()
        clearView?.backgroundColor = UIColor.clearColor()
        whiteBackView.addSubview(clearView!)
        clearView?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: whiteBackView)
        clearView?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: whiteBackView)
        clearView?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: nameLabel)
        clearView?.autoSetDimension(ALDimension.Width, toSize: 70 * kScreenRate)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fethTopdicData(name:NSString, phoneNum:NSString, customerNum:NSString, achievement:NSString,imgUrl:NSString)
    {
        //headImgView?.setImageWithURL("", placeholderImage: UIImage(named: "personal_2"))
        headImgView?.setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "personal_2"))
        nameLabel?.text = name
        phoneNumLabel?.text = phoneNum
        customerNumLabel?.attributedText = setGroupString(customerNum)
        achievementLabel?.attributedText = setYuanString(achievement)
    }
    
    func setYuanString(str:NSString) ->NSMutableAttributedString
    {
        var yuanStr:NSString
        if str.isEqualToString("")
        {
            yuanStr = "￥0.00"
        }
        else
        {
            var numberFormatter = NSNumberFormatter()
            numberFormatter.positiveFormat = "0.00"
            println("floatValue ================== \(str.floatValue)")
            
            var str:NSString = numberFormatter.stringFromNumber(NSNumber(double: str.doubleValue))!
            yuanStr = "￥\(str)"

        }
        var attri = NSMutableAttributedString(string: yuanStr)
        attri.addAttribute(NSFontAttributeName, value: Define.font(TF_13), range: NSMakeRange(0, 1))
        return attri
    }
    
    func setGroupString(str:NSString) ->NSMutableAttributedString
    {
        var groupStr:NSString
        if str.isEqualToString("")
        {
            groupStr = "0组"
        }
        else
        {
            groupStr = "\(str)组"
        }
        var attri = NSMutableAttributedString(string: groupStr)
        attri.addAttribute(NSFontAttributeName, value: Define.font(TF_13), range: NSMakeRange(groupStr.length-1, 1))
        return attri
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
