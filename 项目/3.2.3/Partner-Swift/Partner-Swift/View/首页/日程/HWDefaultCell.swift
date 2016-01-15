//
//  HWDefaultCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：默认cell 样式 ，    左边一个label   右边 accessory
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//


import UIKit

let defaultCell_MarginLeft = 15 * kRate
let defaultCell_Height = 44 * kRate

class HWDefaultCell: HWBaseTableViewCell {
    
    var myTextLabel: UILabel!
    var accessoryImgV: UIImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        myTextLabel = UILabel(frame: CGRectMake(defaultCell_MarginLeft, 0, kScreenWidth - 80, defaultCell_Height))
        myTextLabel.font = Define.font(TF_Text_15)
        myTextLabel.textColor = CD_Txt_Color_66
        myTextLabel.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(myTextLabel)
        
        accessoryImgV = UIImageView(frame: CGRectMake(kScreenWidth - 8 - 15, (defaultCell_Height - 14) / 2.0, 8, 14))
        accessoryImgV.image = UIImage(named: "arrow_next")
        self.contentView.addSubview(accessoryImgV)
    }
    
    class func getIdentify() -> String
    {
        return "HWDefaultCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return defaultCell_Height
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
