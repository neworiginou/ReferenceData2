//
//  HWMyDisCountCell.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/22.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMyDisCountCell: HWBaseTableViewCell {

    var backImgView:UIImageView!
    var shareBtn:UIButton!
    var stateLabel:UILabel!//右上角状态
    var numberLabel:UILabel!//优惠卷编号
    var picImgView:UIImageView!//优惠项目图片
    var nameLabel:UILabel!//优惠券抬头
    var discountLabel:UILabel!//优惠额度
    var validityPeriod:UILabel!//有效期
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadUI()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI()
    {
        let v:UIView = UIView(frame:CGRectMake(0, 0, kScreenWidth, 150))
        v.backgroundColor = CD_BackGroundColor
        let v2:UIView = UIView(frame:CGRectMake(0, 0, kScreenWidth, 150))
        v2.backgroundColor = CD_BackGroundColor
        self.contentView.addSubview(v)
        self.selectedBackgroundView = v2
        
        //backImgView = UIImageView.newAutoLayoutView()
        backImgView = UIImageView(frame: CGRectMake(kScreenWidth == 320 ? 10:15,0, kScreenWidth - (kScreenWidth == 320 ? 20:30), 140))
        backImgView.userInteractionEnabled = true
        var image:UIImage = UIImage(named: "coupon1")!
        backImgView.image = image.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 20, 20, 20))
        //backImgView.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(backImgView)
//        backImgView.autoSetDimension(ALDimension.Height, toSize: 140)
//        backImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: kScreenWidth == 320 ? 5:15)
//        backImgView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: kScreenWidth == 320 ? -5:-15)
//        backImgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 0)
        
        var dottedLineView = HWDottedLineView(frame: CGRectMake(0, 0, kScreenWidth - (kScreenWidth == 320 ? 20:30), 38))
        backImgView.addSubview(dottedLineView)
        
        numberLabel = UILabel.newAutoLayoutView()
        numberLabel.backgroundColor = UIColor.clearColor()
        numberLabel.textColor = CD_Txt_Color_33
        numberLabel.font = Define.font(TF_13)
        backImgView.addSubview(numberLabel)
        numberLabel.autoSetDimension(ALDimension.Height, toSize: 37)
        numberLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: backImgView, withOffset: 0)
        numberLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backImgView, withOffset: 15)
        numberLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: backImgView, withOffset: -15)
        //numberLabel.text = "编号：01010030001"
    
        picImgView = UIImageView.newAutoLayoutView()
        picImgView.backgroundColor = UIColor.clearColor()
        picImgView.layer.cornerRadius = 3
        picImgView.layer.masksToBounds = true
        backImgView.addSubview(picImgView)
        picImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backImgView, withOffset: 15)
        picImgView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: backImgView, withOffset: -15)
        picImgView.autoSetDimension(ALDimension.Height, toSize: 75)
        picImgView.autoSetDimension(ALDimension.Width, toSize: 95)
        
        nameLabel = UILabel.newAutoLayoutView()
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textColor = CD_Txt_Color_33
        nameLabel.font = Define.font(TF_15)
        backImgView.addSubview(nameLabel)
        nameLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        nameLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: picImgView, withOffset: 10)
        nameLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Top, ofView: picImgView, withOffset: 0)
        nameLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: backImgView, withOffset: -5)
        //nameLabel.text = "中海山湖一号优惠劵"
        
        stateLabel = UILabel.newAutoLayoutView()
        stateLabel.backgroundColor = UIColor.clearColor()
        stateLabel.textColor = CD_Txt_Color_99
        stateLabel.font = Define.font(TF_13)
        backImgView.addSubview(stateLabel)
        stateLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: numberLabel)
        stateLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: backImgView, withOffset: -15)
        
        shareBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        shareBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        shareBtn.backgroundColor = UIColor.clearColor()
        shareBtn.setImage(UIImage(named: "newhomes_share"), forState: UIControlState.Normal)
        //shareBtn.setImage(UIImage(named: "share_020"), forState: UIControlState.Highlighted)
        backImgView.addSubview(shareBtn)
        shareBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: backImgView, withOffset: 0)
        shareBtn.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: backImgView, withOffset: 0)
        shareBtn.autoSetDimension(ALDimension.Height, toSize: 37)
        shareBtn.autoSetDimension(ALDimension.Width, toSize: 58)
        shareBtn.hidden = true
        
        discountLabel = UILabel.newAutoLayoutView()
        discountLabel.backgroundColor = UIColor.clearColor()
        discountLabel.textColor = CD_Txt_Color_99
        discountLabel.font = Define.font(TF_13)
        backImgView.addSubview(discountLabel)
        discountLabel.autoSetDimension(ALDimension.Height, toSize: 25)
        discountLabel.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: picImgView, withOffset: 10)
        discountLabel.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: 0)
        discountLabel.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: backImgView, withOffset: -5)
        //discountLabel.text = "优惠：2000元团购费"
        
        validityPeriod = UILabel.newAutoLayoutView()
        validityPeriod.backgroundColor = UIColor.clearColor()
        validityPeriod.textColor = CD_Txt_Color_99
        validityPeriod.font = Define.font(TF_11)
        validityPeriod.numberOfLines = 0
        backImgView.addSubview(validityPeriod)
        validityPeriod.autoSetDimension(ALDimension.Height, toSize: 25)
        validityPeriod.autoPinEdge(ALEdge.Left
            , toEdge: ALEdge.Right, ofView: picImgView, withOffset: 10)
        validityPeriod.autoPinEdge(ALEdge.Top
            , toEdge: ALEdge.Bottom, ofView: discountLabel, withOffset: 0)
        validityPeriod.autoPinEdge(ALEdge.Right
            , toEdge: ALEdge.Right, ofView: backImgView, withOffset: -5)
        //validityPeriod.text = "有效期：2015-01-08至2015-05-01"

    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
