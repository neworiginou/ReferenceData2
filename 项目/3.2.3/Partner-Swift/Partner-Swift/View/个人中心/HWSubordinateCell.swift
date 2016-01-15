//
//  HWSubordinateCell.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSubordinateCell: HWBaseTableViewCell {

    var headImgView:UIImageView?
    var nameLabel:UILabel?
    var phoneNumLabel:UILabel?
    var achievementLabel:UILabel?
    var customerNumLabel:UILabel?
    var callBtn:UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //头像视图
        headImgView = UIImageView.newAutoLayoutView()
        headImgView?.backgroundColor = UIColor.clearColor()
        headImgView?.layer.cornerRadius = 25 * kScreenRate
        headImgView?.layer.masksToBounds = true
        headImgView?.layer.borderWidth = 1
        headImgView?.layer.borderColor = CD_BackGroundColor.CGColor
        self.contentView.addSubview(headImgView!)
        headImgView?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        headImgView?.autoSetDimension(ALDimension.Height, toSize: 50 * kScreenRate)
        headImgView?.autoSetDimension(ALDimension.Width, toSize: 50 * kScreenRate)
        headImgView?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: 15 * kRate)
        
        //下线名字
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel?.backgroundColor = UIColor.clearColor()
        nameLabel?.font = Define.font(TF_15)
        nameLabel?.textColor = CD_Txt_Color_00
        self.contentView.addSubview(nameLabel!)
        nameLabel?.autoSetDimension(ALDimension.Height, toSize: 15)
        nameLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: headImgView, withOffset: 15 * kRate)
        nameLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 15 * kScreenRate)
        //nameLabel?.text = "小胖胖"
        
        //下线电话号码
        phoneNumLabel = UILabel.newAutoLayoutView()
        phoneNumLabel?.backgroundColor = UIColor.clearColor()
        phoneNumLabel?.font = Define.font(TF_15)
        phoneNumLabel?.textColor = CD_Txt_Color_00
        self.contentView.addSubview(phoneNumLabel!)
        phoneNumLabel?.autoSetDimension(ALDimension.Height, toSize: 13)
        phoneNumLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: nameLabel, withOffset: 10 )
        phoneNumLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: nameLabel)
        //phoneNumLabel?.text = "13987654322"
        
        achievementLabel = UILabel.newAutoLayoutView()
        achievementLabel?.backgroundColor = UIColor.clearColor()
        achievementLabel?.font = Define.font(TF_11)
        achievementLabel?.textColor = CD_Txt_Color_00
        self.contentView.addSubview(achievementLabel!)
        achievementLabel?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.contentView, withOffset: -15 * kScreenRate)
        achievementLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: nameLabel)
        achievementLabel?.autoSetDimension(ALDimension.Height, toSize: 11)
        //achievementLabel?.text = "累计业绩:￥0.00"
        
        customerNumLabel = UILabel.newAutoLayoutView()
        customerNumLabel?.backgroundColor = UIColor.clearColor()
        customerNumLabel?.font = Define.font(TF_11)
        customerNumLabel?.textColor = CD_Txt_Color_00
        self.contentView.addSubview(customerNumLabel!)
        customerNumLabel?.autoSetDimension(ALDimension.Height, toSize: 11)
        //customerNumLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: achievementLabel, withOffset: 30 * kRate)
        customerNumLabel?.autoSetDimension(ALDimension.Width, toSize: 60 * kScreenRate)
        customerNumLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -70 * kScreenRate)
        customerNumLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: achievementLabel)
        //customerNumLabel?.text = "客户:0组"

        
        //打电话按钮
        callBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        callBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
        callBtn?.backgroundColor = UIColor.clearColor()
        callBtn?.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        self.contentView.addSubview(callBtn!)
        callBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        callBtn?.autoSetDimension(ALDimension.Width, toSize: 70 * kScreenRate)
        callBtn?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Left)

        self.contentView.drawBottomLine()
    }

     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
}
