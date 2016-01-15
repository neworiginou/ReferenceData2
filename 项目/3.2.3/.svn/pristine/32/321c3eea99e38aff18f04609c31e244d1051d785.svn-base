//
//  HWRelateNewHouseCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRelateNewHouseCell: HWBaseTableViewCell {

    let marginLeft: CGFloat = 15.0
    let marginTop: CGFloat = 10.0
    
    var iconImgV: UIImageView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!     // 地址
    var tagButton: UIButton!        // 佣金
    var brokerageLabel: UILabel!
    var priceLabel: UILabel!
    var cooperateLabel: UILabel!
    var clientLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImgV = UIImageView(frame: CGRectMake(marginLeft, marginTop, 95, 75))
        iconImgV.backgroundColor = UIColor.clearColor()
        iconImgV.layer.cornerRadius = 3
        iconImgV.layer.masksToBounds = true
        iconImgV.image = Utility.getPlaceHolderImage(iconImgV.frame.size, imageName: placeHolderBigImage)
        self.contentView.addSubview(iconImgV)
        
        titleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(iconImgV.frame) + 15, 0, 0, 35))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = CD_Txt_Color_00
        titleLabel.font = Define.font(TF_Text_15)
        self.contentView.addSubview(titleLabel)
        
        subTitleLabel = UILabel(frame: CGRectMake(0, CGRectGetMinY(titleLabel.frame), 0, 35))
        subTitleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.textColor = CD_Txt_Color_66
        subTitleLabel.font = Define.font(TF_Small_12)
        self.contentView.addSubview(subTitleLabel)
        
        tagButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        tagButton.frame = CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(subTitleLabel.frame) - 3, 35, 15)
        tagButton.setBackgroundImage(Utility.imageWithColor(CD_MainColor, _size: CGSizeMake(35, 15)), forState: UIControlState.Normal)
        tagButton.setTitle("佣金", forState: UIControlState.Normal)
        tagButton.layer.cornerRadius = 3
        tagButton.layer.masksToBounds = true
        tagButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tagButton.titleLabel?.font = Define.font(TF_11)
        tagButton.userInteractionEnabled = false
        self.contentView.addSubview(tagButton)
        
        brokerageLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(tagButton.frame) + 3, CGRectGetMaxY(subTitleLabel.frame) - 3, 120, 15))
        brokerageLabel.backgroundColor = UIColor.clearColor()
        brokerageLabel.textColor = CD_MainColor
        brokerageLabel.font = Define.font(TF_Text_15)
        self.contentView.addSubview(brokerageLabel)
        
        priceLabel = UILabel(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(tagButton.frame) + 5, 120, 18))
        priceLabel.backgroundColor = UIColor.clearColor()
        priceLabel.textColor = CD_Txt_Color_66
        priceLabel.font = Define.font(TF_Small_12)
        self.contentView.addSubview(priceLabel)
        
        cooperateLabel = UILabel(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(priceLabel.frame), 100, 18))
        cooperateLabel.backgroundColor = UIColor.clearColor()
        cooperateLabel.textColor = CD_Txt_Color_66
        cooperateLabel.font = Define.font(TF_Small_12)
        self.contentView.addSubview(cooperateLabel)
        
        clientLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(cooperateLabel.frame) + 10, CGRectGetMaxY(priceLabel.frame), 100, 18))
        clientLabel.backgroundColor = UIColor.clearColor()
        clientLabel.textColor = CD_Txt_Color_66
        clientLabel.font = Define.font(TF_Small_12)
        self.contentView.addSubview(clientLabel)
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWRelateNewHouseCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return 95
    }

    func setRelateHouse(house: HWRelateHouseModel?) -> Void
    {
        titleLabel.text = house?.houseName
        subTitleLabel.text = house?.houseAddress
        brokerageLabel.text = house?.commission
        priceLabel.text = house?.houseAvgPrice
        cooperateLabel.text = "合作经纪人：\(house?.brokerNum as String)"
        clientLabel.text = "意向客户：\(house?.clientNum as String)"
       // iconImgV.image = Utility.imageDownloadWithMongoDbKey(house?.picKey as String)
       
        let size: CGSize = Utility.calculateStringSize(titleLabel.text!, textFont: titleLabel.font, constrainedSize: CGSizeMake(100000, 20))
        titleLabel.frame = CGRectMake(CGRectGetMaxX(iconImgV.frame) + 15, 0, min(size.width, 175), 30)
        
        subTitleLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, CGRectGetMinY(titleLabel.frame), kScreenWidth - (CGRectGetMaxX(titleLabel.frame) + 5) - 15, 30)
        
        
    }
    
}
