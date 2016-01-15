//
//  HWRelateSecondHouseCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRelateSecondHouseCell: HWBaseTableViewCell {

    let marginLeft: CGFloat = 15.0
    let marginTop: CGFloat = 10.0
    
    var iconImgV: UIImageView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var roomLabel: UILabel!
    var areaLabel: UILabel!
    var priceLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImgV = UIImageView(frame: CGRectMake(marginLeft, marginTop, 95, 75))
        iconImgV.backgroundColor = UIColor.clearColor()
        iconImgV.layer.cornerRadius = 3
        iconImgV.layer.masksToBounds = true
        iconImgV.image = Utility.getPlaceHolderImage(iconImgV.frame.size, imageName: placeHolderBigImage)
        self.contentView.addSubview(iconImgV)
        
        titleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(iconImgV.frame) + 15, 10, kScreenWidth - (CGRectGetMaxX(iconImgV.frame) + 15) - 15, 25))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = CD_Txt_Color_00
        titleLabel.font = Define.font(TF_Text_15)
        self.contentView.addSubview(titleLabel)
        
        subTitleLabel = UILabel(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), 20))
        subTitleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.textColor = CD_Txt_Color_66
        subTitleLabel.font = Define.font(TF_13)
        self.contentView.addSubview(subTitleLabel)
        
        roomLabel = UILabel(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(subTitleLabel.frame), 65, 25))
        roomLabel.backgroundColor = UIColor.clearColor()
        roomLabel.textColor = CD_MainColor
        roomLabel.font = Define.font(TF_Text_15)
        self.contentView.addSubview(roomLabel)
        
        areaLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(roomLabel.frame), CGRectGetMaxY(subTitleLabel.frame), 65, 25))
        areaLabel.backgroundColor = UIColor.clearColor()
        areaLabel.textColor = CD_MainColor
        areaLabel.font = Define.font(TF_Text_15)
        self.contentView.addSubview(areaLabel)
        
        priceLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(areaLabel.frame), CGRectGetMaxY(subTitleLabel.frame), 65, 25))
        priceLabel.backgroundColor = UIColor.clearColor()
        priceLabel.textColor = CD_MainColor
        priceLabel.font = Define.font(TF_Text_15)
        self.contentView.addSubview(priceLabel)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWRelateSecondHouseCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return 95
    }
    
    func setRelateHouse(house: HWRelateHouseModel?) -> Void
    {
        // 问题 缺少 图片
        titleLabel.text = house?.houseTitle
        subTitleLabel.text = "\(house?.houseName as String) \(house?.houseAddress as String)"
        roomLabel.text = house?.houseFamilyType
        areaLabel.text = house?.houseArea
        priceLabel.text = house?.houseTotalPrice
    }

}
