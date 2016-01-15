//
//  HWChartsCell.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWChartsCell: UITableViewCell {

    var nameLabel:UILabel?
    var headImgView:UIImageView?
    var achievementLabel:UILabel?
    var numLabel:UILabel?
    var companyNameLabel:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        var numV = UIView.newAutoLayoutView()
        numV.backgroundColor = CD_Btn_MainColor
        numV.layer.cornerRadius = 9 * kScreenRate
        numV.layer.masksToBounds = true
        self.contentView.addSubview(numV)
        numV.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        numV.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: 15 * kScreenRate)
        numV.autoSetDimension(ALDimension.Height, toSize: 18 * kScreenRate)
        numV.autoSetDimension(ALDimension.Width, toSize: 18 * kScreenRate)
        
        numLabel = UILabel.newAutoLayoutView()
        numLabel?.backgroundColor = UIColor.clearColor()
        numLabel?.textColor = UIColor.whiteColor()
        numLabel?.textAlignment = NSTextAlignment.Center
        numLabel?.font = Define.font(TF_11)
        numV.addSubview(numLabel!)
        numLabel?.autoCenterInSuperview()
        
        //60
        headImgView = UIImageView.newAutoLayoutView()
        headImgView?.backgroundColor = UIColor.clearColor()
        headImgView?.layer.cornerRadius = 30 * kScreenRate
        headImgView?.layer.masksToBounds = true
        headImgView?.layer.borderWidth = 1
        headImgView?.layer.borderColor = CD_BackGroundColor.CGColor
        
        self.contentView.addSubview(headImgView!)
        headImgView?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        headImgView?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: numV, withOffset: 7 * kScreenRate)
        headImgView?.autoSetDimension(ALDimension.Height, toSize: 60 * kScreenRate)
        headImgView?.autoSetDimension(ALDimension.Width, toSize: 60 * kScreenRate)
        
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel?.backgroundColor = UIColor.clearColor()
        nameLabel?.textColor = CD_Txt_Color_00
        nameLabel?.font = Define.font(TF_13)
        nameLabel?.numberOfLines = 0
        self.contentView.addSubview(nameLabel!)
        nameLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        nameLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: headImgView, withOffset: 13 * kScreenRate)
        nameLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView)
        nameLabel?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.contentView)
        nameLabel?.autoSetDimension(ALDimension.Width, toSize: 150 * kScreenRate)
        
        achievementLabel = UILabel.newAutoLayoutView()
        achievementLabel?.backgroundColor = UIColor.clearColor()
        achievementLabel?.textColor = CD_MainColor
        achievementLabel?.font = Define.font(TF_18)
        self.contentView.addSubview(achievementLabel!)
        achievementLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        achievementLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -15 * kScreenRate)
        achievementLabel?.autoSetDimension(ALDimension.Height, toSize: 18)
        
        companyNameLabel = UILabel.newAutoLayoutView()
        companyNameLabel?.backgroundColor = UIColor.clearColor()
        companyNameLabel?.textColor = CD_Txt_Color_00
        companyNameLabel?.font = Define.font(TF_13)
        companyNameLabel?.numberOfLines = 0
        self.contentView.addSubview(companyNameLabel!)
        companyNameLabel?.autoPinEdge(ALEdge.Top, toEdge:ALEdge.Top, ofView: self.contentView)
        companyNameLabel?.autoPinEdge(ALEdge.Bottom, toEdge:ALEdge.Bottom, ofView: self.contentView)
        companyNameLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: numV, withOffset: 15)
        companyNameLabel?.autoSetDimension(ALDimension.Width, toSize:150 * kScreenRate)
        
        
        var label = UILabel(frame: CGRectMake(15 * kScreenRate, 80 * kScreenRate - 0.5, kScreenWidth - kScreenRate * 15 , 0.5))
        label.backgroundColor = CD_LineColor
        self.contentView.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
