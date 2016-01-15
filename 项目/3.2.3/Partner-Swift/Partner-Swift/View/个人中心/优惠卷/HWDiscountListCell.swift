//
//  HWDiscountListCell.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWDiscountListCell: HWBaseTableViewCell {

    var backImgView:UIImageView!
    var showImgView:UIImageView!//楼盘图片
    var nameLabel:UILabel!//优惠劵名称
    var leftNumLabel:UILabel!//剩余张数
    var preferentialLabel:UILabel!//优惠金额
    var validityPeriodLabel:UILabel!//有效期
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadUI()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    func loadUI()
    {
        let v:UIView = UIView(frame:CGRectMake(0, 0, kScreenWidth, 120))
        v.backgroundColor = CD_BackGroundColor
        self.contentView.addSubview(v)
        
        backImgView = UIImageView.newAutoLayoutView()
        backImgView.backgroundColor = UIColor.clearColor()
        var image:UIImage = UIImage(named: "coupon2")!
        backImgView.image = image.resizableImageWithCapInsets(UIEdgeInsetsMake(20, 20, 20, 20))
        self.contentView .addSubview(backImgView)
        backImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: kScreenWidth < 330 ? 10:15)
        backImgView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: kScreenWidth < 330 ? -10:-15)
        backImgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 0)
        backImgView.autoSetDimension(ALDimension.Height, toSize: 110)
        
        showImgView = UIImageView.newAutoLayoutView()
        showImgView.backgroundColor = UIColor.clearColor()
        showImgView.layer.cornerRadius = 3
        showImgView.layer.masksToBounds = true
        backImgView.addSubview(showImgView)
        showImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView:backImgView, withOffset: 15)
        showImgView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: backImgView)
        showImgView.autoSetDimension(ALDimension.Height, toSize: 75)
        showImgView.autoSetDimension(ALDimension.Width, toSize: 95)

        nameLabel = UILabel.newAutoLayoutView()
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textColor = CD_Txt_Color_33
        nameLabel.font = Define.font(TF_15)
        backImgView.addSubview(nameLabel)
        nameLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        nameLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: showImgView, withOffset: 10)
        nameLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Top, ofView: showImgView, withOffset: 0)
        nameLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: backImgView, withOffset: -75)
        if(kScreenWidth < 330)
        {
            nameLabel.autoSetDimension(ALDimension.Width, toSize: 105)
        }
        //nameLabel.text = "中海山湖一号优惠劵"
        
        
        
        preferentialLabel = UILabel.newAutoLayoutView()
        preferentialLabel.backgroundColor = UIColor.clearColor()
        preferentialLabel.textColor = CD_Txt_Color_99
        preferentialLabel.font = Define.font(TF_13)
        backImgView.addSubview(preferentialLabel)
        preferentialLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        preferentialLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: showImgView, withOffset: 10)
        preferentialLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: 0)
        preferentialLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: backImgView, withOffset: -5)
        //preferentialLabel.text = "优惠：2000元团购费"
        
        validityPeriodLabel = UILabel.newAutoLayoutView()
        validityPeriodLabel.backgroundColor = UIColor.clearColor()
        validityPeriodLabel.textColor = CD_Txt_Color_99
        validityPeriodLabel.font = Define.font(TF_11)
        validityPeriodLabel.numberOfLines = 0
        backImgView.addSubview(validityPeriodLabel)
        validityPeriodLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        validityPeriodLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: showImgView, withOffset: 10)
        validityPeriodLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Bottom, ofView: preferentialLabel, withOffset: 0)
        validityPeriodLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: backImgView, withOffset: -5)
        //validityPeriodLabel.text = "有效期：2015-01-08至2015-05-01"
        
        leftNumLabel = UILabel.newAutoLayoutView()
        leftNumLabel.backgroundColor = UIColor.clearColor()
        leftNumLabel.font = Define.font(TF_12)
        leftNumLabel.textColor = CD_Txt_Color_99
        backImgView.addSubview(leftNumLabel)
        leftNumLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: nameLabel)
        leftNumLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: backImgView, withOffset: -10)
        //leftNumLabel.text = "剩余10张"
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
