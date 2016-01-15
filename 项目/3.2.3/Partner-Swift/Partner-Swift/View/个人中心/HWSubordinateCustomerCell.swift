//
//  HWSubordinateCustomerCell.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSubordinateCustomerCell: HWBaseTableViewCell {

    var nameLabel:UILabel?
    var infoLabel:UILabel?
    var stateLabel:UILabel?
    var timeStateLabel:UILabel?
    var callBtn:UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel?.font = Define.font(TF_15)
        nameLabel?.textColor = CD_Txt_Color_00
        self.contentView.addSubview(nameLabel!)
        nameLabel?.autoSetDimension(ALDimension.Height, toSize: 15)
        nameLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset:15 * kRate)
        nameLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 12 * kScreenRate)
        //nameLabel?.text = "阿五"
        
        timeStateLabel = UILabel.newAutoLayoutView()
        timeStateLabel?.font = Define.font(TF_12)
        timeStateLabel?.textColor = CD_Txt_Color_99
        self.contentView.addSubview(timeStateLabel!)
        timeStateLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset:15 * kRate)
        timeStateLabel?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.contentView, withOffset:-12 * kScreenRate)
        timeStateLabel?.autoSetDimension(ALDimension.Height, toSize: 12)
        //timeStateLabel?.text = "昨天"
        
        self.contentView.drawBottomLine()
        
        callBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        callBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
        //callBtn?.setBackgroundImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        callBtn?.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        callBtn?.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(callBtn!)
        callBtn?.autoSetDimension(ALDimension.Height, toSize: 60 * kScreenRate)
        callBtn?.autoSetDimension(ALDimension.Width, toSize: 60 * kScreenRate)
        callBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        callBtn?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset:0)
        
        stateLabel = UILabel.newAutoLayoutView()
        stateLabel?.font = Define.font(TF_12)
        stateLabel?.textAlignment = NSTextAlignment.Right
        stateLabel?.textColor = CD_MainColor
        stateLabel?.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(stateLabel!)
        stateLabel?.autoSetDimension(ALDimension.Height, toSize: 12)
        stateLabel?.autoSetDimension(ALDimension.Width, toSize: 60)
        stateLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: callBtn, withOffset:0)
        //stateLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        stateLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: callBtn)
        //stateLabel?.text = "房源预约"
        
        infoLabel = UILabel.newAutoLayoutView()
        infoLabel?.font = Define.font(TF_12)
        infoLabel?.textColor = CD_Txt_Color_99
        infoLabel?.numberOfLines = 0
        self.contentView.addSubview(infoLabel!)
        infoLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset:15 * kRate)
        infoLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel)
        infoLabel?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: timeStateLabel)
        //infoLabel?.autoSetDimension(ALDimension.Width, toSize: 220 * kScreenRate)
        infoLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: stateLabel, withOffset:-20 * kScreenRate)
        //infoLabel?.text = "[呼玛三村]住宅80-90平米|100万|学区房|满五年唯一住宅|"
    }

    required init(coder aDecoder: NSCoder)
    {
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
